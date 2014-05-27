$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  $validator = $("#new_contribution").validate(
    rules:
      contribution_amount:
        required: true
        number: true
        minlength: 3

      contribution_first_name:
        required: true
        minlength: 3

      contribution_last_name:
        required: true
        minlength: 3

      contribution_email:
        required: true
        email: true
        minlength: 3

      contribution_address:
        required: true
        minlength: 3

      contribution_city:
        required: true
        minlength: 3

      contribution_state:
        required: true
        minlength: 2

      contribution_zip_code:
        required: true
        minlength: 3

      card_number:
        required: false
  )

  contribution.setupForm()

  # $("#new_contribution").easyWizard
  #   showSteps: false,
  #   showButtons: false,
  #   submitButton: false

  $("#contribution_next").bind "click", ->
    $("#card_number").rules("remove")
    # $("#contribution_address").rules("remove")
    # $("#contribution_city").rules("remove")
    # $("#contribution_state").rules("remove")
    # $("#contribution_zip_code").rules("remove")
    $valid = $("#new_contribution").valid()
    unless $valid
      errors = $validator.numberOfInvalids()
      message = (if errors is 1 then "You missed 1 field. It has been highlighted" else "You missed " + errors + " fields. They have been highlighted")
      $("div.contribution-error span").html message
      $("div.contribution-error").show()
      false
    else
      $("#contribution_next").hide()
      $("#submit_contribution").show()
      $("#new_contribution").easyWizard "nextStep"
      false

contribution =
  setupForm: ->
    $('#submit_contribution').click ->
      $(@).attr('disabled', true)
      $valid = $("#new_contribution").valid()
      unless $valid
        errors = $validator.numberOfInvalids()
        message = (if errors is 1 then "You missed 1 field. It has been highlighted" else "You missed " + errors + " fields. They have been highlighted")
        $("div.contribution-error span").html message
        $("div.contribution-error").show()
        false
      else
        contribution.processCard()
        false

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, contribution.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#contribution_stripe_card_token').val(response.id)
      contribution.validatePanelTwo()
    else
      $('#stripe_error').text(response.error.message).show()
      $('#submit_contribution').attr('disabled', false)
      false

  validatePanelTwo: ->
    $valid = $("#new_contribution").valid()
    unless $valid
      errors = $validator.numberOfInvalids()
      message = (if errors is 1 then "You missed 1 field. It has been highlighted" else "You missed " + errors + " fields. They have been highlighted")
      $("div.contribution-error span").html message
      $("div.contribution-error").show()
    else
      $('#new_contribution')[0].submit()
