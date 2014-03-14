# == Schema Information
#
# Table name: projects
#
#  id                      :integer          not null, primary key
#  user_id                 :integer
#  goal_amount             :decimal(, )
#  page_title              :string(60)       not null
#  zip_code                :integer          not null
#  page_message            :text             not null
#  slug                    :string(255)
#  approved                :boolean          default(TRUE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  featured_image          :string(255)
#  featured_video          :string(255)
#  project_category_id     :integer
#  status                  :string(255)      default("In Progress")
#  street_address          :string(255)
#  city                    :string(255)
#  state                   :string(255)
#  latitude                :float
#  longitude               :float
#  notify_on_donate        :boolean
#  private                 :boolean          default(FALSE)
#  has_reviewed_contractor :boolean          default(FALSE)
#  backer_count            :integer          default(0)
#  project_deadline        :date
#  reason_for_deadline     :text
#  funded                  :boolean          default(FALSE)
#  funded_date             :date
#  funded_confirm          :boolean          default(FALSE)
#  campaign_ended          :boolean          default(FALSE)
#  key                     :string(255)
#  campaign_ended_date     :date
#  campaign_extended_date  :date
#  vendors_paid            :boolean          default(FALSE)
#

require 'spec_helper'

describe Project do

  context 'without featured_image' do
    before { subject.stub(:featured_image) { nil } }
    it { should validate_presence_of(:featured_video) }
  end

  context 'without featured_video' do
    before { subject.stub(:featured_video) { nil } }
    it { should validate_presence_of(:featured_image) }
  end

  context 'construction project' do
    before(:each) do
      project = Project.new(:category_ids => ['4'])
    end

    it "should be classified construction" do
      expect { project.construction_project? to be_false }
    end

    it "should have a zero goal_amount without an estimate" do
      project = Project.new(:category_ids => ['4'])
      expect { project.goal_amount.to_be 0 }
    end
  end

  context 'non-construction project' do
    before(:each) do
      project = Project.new(:category_ids => ['1,2'])
    end

    it "should not be classified construction" do
      expect { project.construction_project? to be_true }
    end

    it "should have a zero goal_amount without at least one vendor" do
      expect { project.goal_amount.to_be 0 }
    end
  end

  it { should validate_presence_of(:page_title) }
  it { should validate_presence_of(:page_message) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:category_ids) }

  it "should be approved if not a construction project" do
    project = Project.new(:category_ids => [1, 2])
    expect { project.approved.to be_true }
  end

  it "should not be approved if a construction project" do
    project = Project.new(:category_ids => [4])
    expect { project.approved.to be_false }
  end
end
