Compapp.factory "Contractor", ($resource) ->
  $resource("/contractors/:id",
   id: "@id"
  ,
    isArray: true,
    update:
      method: "PUT"
  )