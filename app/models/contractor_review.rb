class ContractorReview < ActiveRecord::Base
  attr_accessible :approved, :comments, :contractor_id, :private, :rating, :title, :user_id, :project_id
  validates :comments, :contractor_id, :rating, :title, :user_id, :presence => true
  belongs_to :contractor, touch: true
  belongs_to :user
  after_create :set_to_approved
  after_create :send_contractor_notification

  scope :approved, -> { where(approved: true) }
  scope :public, -> { where(private: false) }

  #
  # Automatically sets the review to approved if the rating is over 3
  #
  def set_to_approved
    if self.rating > 3
      self.update_attribute('approved', true)
    end
    @project = Project.find(self.project_id)
    @project.update_attribute('has_reviewed_contractor', true)
  end

  #
  # Emails contractor when a review is posted
  #
  def send_contractor_notification
    @contractor = Contractor.find(self.contractor_id)
    @user = User.find(self.user_id)
    @project = Project.find(self.project_id)
    @review = self
    ContractorMailer.contractor_review_notification(@contractor, @user, @project, @review).deliver
  end
end
