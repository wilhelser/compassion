class AddStripeCardTokenToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :stripe_card_token, :string
  end
end
