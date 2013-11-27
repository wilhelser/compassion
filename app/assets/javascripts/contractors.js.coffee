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



