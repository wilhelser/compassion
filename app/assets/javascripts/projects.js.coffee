$ ->
  $("#project_category_ids_8").change ->
    if $(@).is(':checked')
      $("#goal_amount_wrap").hide()
      $("#address_info_wrap").show()
    else
      $("#goal_amount_wrap").show()
      $("#address_info_wrap").hide()

  $(".needs-acceptance").click ->
    $("#disclaimer_modal").modal('show')
    false

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

  $(".wysihtml5").each (i, elem) ->
    $(elem).wysihtml5()

  $("input[maxlength]").maxlength({
    alwaysShow: true
    threshold: 30
    })

  $(document).delegate "#contractor-search-btn", "click", ->
    $("#contractor_search_response").hide()
    $("#contractor_search_form").submit()