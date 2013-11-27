Rails.configuration.stripe = {
  :publishable_key => ENV['COMP_PUBLISHABLE_KEY'],
  :secret_key      => ENV['COMP_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]