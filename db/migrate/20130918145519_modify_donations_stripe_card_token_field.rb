class ModifyDonationsStripeCardTokenField < ActiveRecord::Migration
  def change
    change_column :donations, :stripe_card_token, :string, :null => true
  end
end
