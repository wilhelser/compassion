class AddCampaignExtendedDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :campaign_extended_date, :date
  end
end
