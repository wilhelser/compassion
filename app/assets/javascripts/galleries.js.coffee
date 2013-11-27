$ ->
  $(document).delegate "#create_new_gallery", "click", ->
    $("#new_gallery").submit()

  $(document).delegate "#photo_image", "change", ->
    @image = $(@).val()
    $("#photo_preview_thumb").html("<img src='#{@image}'>").show()

  $(document).delegate "#send_new_photo", "click", ->
    $("#new_photo").submit()

  $(".gallery-wrap").each -> # the containers for all your galleries
    $(@).magnificPopup
      delegate: "a" # the selector for gallery item
      type: "image"
      image:
        titleSrc: 'title'
      gallery:
        enabled: true