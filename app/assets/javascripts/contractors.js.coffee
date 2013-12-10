$ ->
  $(document).on "cocoon:before-insert", ->
    $(".selectpicker").selectpicker()

  $("[data-behavior~=datepicker]").datepicker()

  $(document).delegate "#contractor_logo", "change", ->
    image = $(@).val()
    $("#dashboard-logo").attr('src', image).removeClass('hide')

  $(document).delegate ".fs-toggle", 'click', ->
    target = $(@).data('target')
    $(target).slideToggle()

  $(".contractor-rating").raty
    score: ->
      $(this).data "score"
    readOnly: true

  $("#new_contractor_signup_button").click ->
    if $(@).hasClass('disabled')
      alert('You must read the Contactor Code of Business Practices and Application Requirements!')
      $("#read-contractor-docs").css('background', 'yellow')
    else
      $("#new_contractor").submit()
