class AddStripCardTokenToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_card_token, :string, :null => false
  end
end
