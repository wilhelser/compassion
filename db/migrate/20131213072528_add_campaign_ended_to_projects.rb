class AddCampaignEndedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :campaign_ended, :boolean, :default => false
  end
end
