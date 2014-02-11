$ ->
  $(document).delegate "#send_estimate_form", "click", ->
    fields = $("#new_estimate input.required")
    for f in fields
      if $(f).val() == ''
        validates = false
      else if $(f).val() == 0.0
        validates = false
      else
        validates = true
    if validates == true
      $("#new_estimate").submit()
    else
      alert "Please fill out all fields!"
