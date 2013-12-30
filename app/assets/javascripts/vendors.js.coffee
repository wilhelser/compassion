$ ->
  $(document).delegate "#send_vendor_form", "click", ->
    $("#new_vendor").submit()

  $(document).delegate "#send_edit_vendor_form", "click", ->
    $(".edit_vendor").submit()

  $(document).delegate '.alert', 'click', ->
    $(@).hide()
