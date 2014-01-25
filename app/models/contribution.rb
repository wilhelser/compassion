class Contribution < ActiveRecord::Base
  include DonorClass
  attr_accessible :amount, :project_id, :comments, :stripe_card_token, :public, :address, :address_2, :city, :email, :first_name, :image, :last_name, :private, :state, :zip_code
  validates :amount, :project_id, :email, :first_name, :last_name, :presence => true
  validates_numericality_of :amount, :message => "must not contain any punctuation"
  belongs_to :project, touch: true
  after_create :send_donation_notification

  scope :public, -> { where(private: false) }
  scope :private, -> { where(private: true) }
  default_scope -> { order('created_at DESC') }

  attr_accessor :stripe_card_token
  attr_accessor :categories

  def name
    [first_name, last_name].compact.join(' ')
  end

  def to_s
    id
  end

  def categories
    self.project.categories
  end

  def donor_class
    get_donor_class(self.email)
  end

  def second_donate_amount
    25.00
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(
        :email => self.email,
        :card => self.stripe_card_token
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => self.amount.to_i * 100,
        :description => "Project id: #{self.project.id} - #{self.project.page_title}",
        :currency    => 'usd'
      )
      self.stripe_card_token = customer.id
      save!
      self.project.check_funded_status
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def send_donation_notification
    if self.project.notify_on_donate?
      ProjectMailer.donation_notification_email(self.project.user, self.project, self).deliver
    end
  end

end
