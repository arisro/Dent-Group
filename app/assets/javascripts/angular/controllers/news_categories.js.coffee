mod = angular.module('Drs.controllers')
mod.controller 'NewsCategoriesController', [
  '$scope'
  'NewsCategory'
  '$resource'
  '$log'
  '$window'
  ($scope, NewsCategory, $resource, $log, $window) ->
    $scope.categories = []
    $scope.selectedCategory = {}
    $scope.thisCategory = null

    $scope.categories = NewsCategory.query()

    $scope.editCategory = (category) ->
      $scope.selectedCategory = $.extend({}, category)
      $scope.thisCategory = category
      $scope.selectedCategory.oldIdent = $scope.selectedCategory.ident

    $scope.saveCategory = ->
      unless $scope.selectedCategory.id?
        NewsCategory.save($scope.selectedCategory, (data) ->
          $scope.categories.unshift(data)
          $scope.cancelEdit()
        )
      else
        $scope.selectedCategory.$update( ->
          $scope.thisCategory.ident = $scope.selectedCategory.ident
          $scope.cancelEdit()
        )

    $scope.deleteCategory = (category) ->
      $scope.categories = $scope.categories.filter (c) -> c.id != category.id
      category.$delete( ->
        category = null
      )

    $scope.cancelEdit = ->
      $scope.selectedCategory = null
      $scope.thisCategory = null
]
