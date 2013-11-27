Compapp.controller "ProjCtrl", ($scope, Project) ->
  # This is the post we use for the form
  $scope.project = new Project()

  $scope.media = "image"

  # Posts for the list
  $scope.projects = Project.query()

  # Add a new post
  $scope.add = ->
    # add to the local array and also save to the server
    $scope.projects.push Project.save
    # reset the post for the form
    $scope.project = new Project()

  # Delete a post
  $scope.delete = ($index) ->
    # Yay, UX!
    if confirm("Are you sure you want to delete this staff listing?")
      # Remove from the server
      $scope.projects[$index].$delete()
      # Remove from the local array
      $scope.projects.splice($index, 1)

  $scope.update = ($index) ->
    $scope.projects[$index].$update()