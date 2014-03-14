# == Schema Information
#
# Table name: donations
#
#  id                :integer          not null, primary key
#  amount            :decimal(8, 2)
#  name              :string(100)
#  zip_code          :integer
#  comments          :text
#  city              :string(60)
#  state             :string(2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_card_token :string(255)
#  email             :string(255)
#

class Donation < ActiveRecord::Base
  attr_accessible :amount, :city, :comments, :name, :state, :zip_code, :stripe_card_token, :email
  validates_presence_of :amount
  validates_numericality_of :amount, :message => "must not contain any punctuation"

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(
        :email => self.email || "not provided",
        :card => self.stripe_card_token
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => self.amount.to_i * 100,
        :description => "Compassion for Humanity Donation",
        :currency    => 'usd'
      )
      self.stripe_card_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
