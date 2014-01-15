$ ->
  $("#project_category_ids_4").change ->
    if $(@).is(':checked')
      $("#new-project-trades-wrap").slideDown()
    else
      $("#new-project-trades-wrap").slideUp()
      $("input[name='project[trade_ids][]'").prop('checked', false)

  $(".needs-acceptance").click ->
    $("#disclaimer_modal").modal('show')
    false

  $('#project_page_message').ckeditor()

  # $(".project_show_main_image").imagefill()

  $("#disclaimer-accept").click ->
    $("#new_project").submit()

  $(document).delegate ".accepted-new-project", "click", ->
    $("#new_project").submit()

  $(document).delegate "#project_notify_on_donate", "change", ->
    $("#project_settings_update_form").submit()

  $("#submit_contractor_review_button").click ->
    $("#new_contractor_review").submit()

  $("#project_featured_image").change ->
    data = $(@).val()
    $("#project_preview_image").attr('src', data)

  # $(".wysihtml5").each (i, elem) ->
  #   $(elem).wysihtml5()

  $("input[maxlength]").maxlength({
    alwaysShow: true
    threshold: 30
    })

  $("input[name='media']").change ->
    if $(@).val() == 'image'
      $("#featured_upload").show()
      $("#youtube_add").hide()
    else
      $("#featured_upload").hide()
      $("#youtube_add").show()


  $(document).delegate "#contractor-search-btn", "click", ->
    $("#contractor_search_response").hide()
    $("#contractor_search_form").submit()

window.updateLogoPreview = (event) ->
  @url = event.fpfile.url
  $(".logo-preview").html("<img class='thumbnail' src='#{@url}' height='175' width='175'>").removeClass('hide')
