$ ->
  $(document).delegate '#beta-signup', 'click', ->
    $('#beta-invite-code-container').hide()
    $('#beta-form-container').show()

  $(document).delegate '#beta-havecode', 'click', ->
    $('#beta-invite-code-container').show()
    $('#beta-form-container').hide()

  $(document).delegate '#invite_code_check', 'keyup', ->
    @code = $(@).val()
    @link = "/invite_codes/validate?access_code=#{@code}"
    $('#sign-in-with-code').prop('href', @link)
