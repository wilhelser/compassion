$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  contribution.setupForm()
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

      card_number:
        required: false
  )

  $("#new_contribution").easyWizard
    showSteps: false,
    showButtons: false,
    submitButton: false

  $("#contribution_next").bind "click", ->
    $("#card_number").rules("remove")
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

  $(".sb_main_donate").click ->
    $("#contribution_modal").modal('show')


contribution =
  setupForm: ->
    $('#submit_contribution').click ->
      $(@).attr('disabled', true)
      if $('#card_number').length
        contribution.processCard()
        false
      else
        true

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
      $('#new_contribution')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
      false