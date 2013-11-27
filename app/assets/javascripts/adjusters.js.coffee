$ ->
  $(document).delegate ".success", "click", ->
    $(@).fadeOut()

  $('.chosen-select').chosen()
