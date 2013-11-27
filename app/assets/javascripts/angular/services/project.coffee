Compapp.factory "Project", ($resource) ->
  $resource("/projects/:id",
   id: "@id"
  ,
    isArray: true,
    update:
      method: "PUT"
  )