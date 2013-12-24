class Contribution < ActiveRecord::Base
  include DonorClass
  attr_accessible :amount, :project_id, :comments, :stripe_card_token, :public, :address, :address_2, :city, :email, :first_name, :image, :last_name, :private, :state, :zip_code
  validates :amount, :project_id, :email, :first_name, :last_name, :presence => true
  after_save :check_funded_status
  belongs_to :project

  scope :public, -> { where(private: false) }
  scope :private, -> { where(private: true) }
  default_scope -> { order('created_at DESC') }

  attr_accessor :stripe_card_token
  attr_accessor :categories

  def name
    [first_name, last_name].compact.join(' ')
  end

  def check_funded_status
    @project = Project.find(self.project_id)
    if @project.total_contributions >= @project.goal_amount
      @project.set_to_funded
    else
      Rails.logger.info "Not yet!"
    end
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
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
