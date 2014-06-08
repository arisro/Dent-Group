angular.module('Drs.controllers', ['ngResource'])
	.config ($httpProvider) ->
		authToken = $("meta[name=\"csrf-token\"]").attr("content")
		$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
	.directive 'ngEnter', ->
	    return ($scope, element, attrs) ->
	        element.bind "keydown", (event) ->
	            if event.which == 13
	                $scope.$eval(attrs.ngEnter)
	                event.preventDefault()