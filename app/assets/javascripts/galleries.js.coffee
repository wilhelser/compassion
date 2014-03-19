$ ->
  $(document).delegate "#create_new_gallery", "click", ->
    $("#new_gallery").submit()

  $(document).delegate "#photo_image", "change", ->
    @image = $(@).val()
    $("#photo_preview_thumb").html("<img src='#{@image}'>").show()

  $(document).delegate "#send_new_photo", "click", ->
    $("#new_photo").submit()

  $("a.sb").nivoLightbox
    effect: "fall" # The effect to use when showing the lightbox
    keyboardNav: true # Enable/Disable keyboard navigation (left/right/escape)
    errorMessage: "The requested content cannot be loaded. Please try again later." # Error message when content can't be loaded

  $(".gallery-title").on "mouseenter", ->
    $(@).stop().animate({
      opacity: 0.65
      }, 300)

  $(".gallery-title").on "mouseleave", ->
    $(@).stop().animate({
      opacity: 0
      }, 300)
