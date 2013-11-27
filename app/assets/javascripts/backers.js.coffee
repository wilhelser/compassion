$ ->
  $("#nc_amount").blur ->
    @amount = $(@).val()
    $("#contribution_amount").val(@amount)