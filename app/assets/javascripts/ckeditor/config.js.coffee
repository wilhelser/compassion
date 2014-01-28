CKEDITOR.editorConfig = (config) ->
  config.language = "en"
  config.removePlugins = 'elementspath,resize'
  config.extraPlugins = 'autogrow'
  config.resize_enabled = true
  config.resize_dir = "vertical"
  config.autoGrow_onStartup = true
  config.autoGrow_minHeight = 200
  config.autoGrow_maxHeight = 545
  config.autoGrow_absoluteMax = 545
  config.scayt_autoStartup = false
  config.enterMode = CKEDITOR.ENTER_P
  config.forceSimpleAmpersand = true
  config.disableNativeSpellChecker = true
  config.entities_greek = false
  config.entities = false
  config.entities_latin = true
  config.entities_processNumerical = false
  config.toolbar = [
    name: "clipboard"
    groups: ["clipboard", "undo"]
    items: ["Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"]
  ,
    name: "editing"
    groups: ["selection", "spellchecker"]
    items: ["SelectAll", "-", "Scayt"]
  ,
    name: "basicstyles"
    groups: ["basicstyles", "cleanup"]
    items: ["Bold", "Italic", "Underline", "Strike", "-", "RemoveFormat"]
  ,
    name: "paragraph"
    groups: ["list", "indent", "blocks", "align", "bidi"]
    items: ["NumberedList", "BulletedList", "-", "Outdent", "Indent", "-", "Blockquote", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"]
  ,
    name: "links"
    items: ["Link", "Unlink"]
  ]
  true
