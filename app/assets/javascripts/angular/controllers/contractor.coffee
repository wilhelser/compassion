Compapp.controller "ContractorCtrl", ($scope, Contractor) ->
  # This is the post we use for the form

  $scope.contractors = Contractor.query()

