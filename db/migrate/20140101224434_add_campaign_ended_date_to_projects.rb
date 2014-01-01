class AddCampaignEndedDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :campaign_ended_date, :date
  end
end
