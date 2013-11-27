class AddWebsiteUrlToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :website_url, :string
  end
end
