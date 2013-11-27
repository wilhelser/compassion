$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  donation.setupForm()

donation =
  setupForm: ->
    $('#new_donation').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        donation.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, donation.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#donation_stripe_card_token').val(response.id)
      $('#new_donation').trigger('submit.rails')
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
