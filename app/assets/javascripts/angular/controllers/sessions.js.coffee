mod = angular.module('Drs.controllers')
mod.controller "SessionsController", [
	'$scope'
	'Session'
	'$resource'
	'$log'
	'$window'
	($scope, Session, $resource, $log, $window) ->
		$scope.newSession = {remember_me: 1}
		json = {"Accept": "application/json"}
		$scope.window = $window

		$scope.hasErrorMessage = ->
			$scope.errorMessage?
 
		$scope.errorClass = ->
			"error" if $scope.errorMessage?
 
		$scope.signIn = ->
			Session.save({user: $scope.newSession}, ->
				$scope.window.location.href = "/"
			,(response) ->
				$scope.errorMessage = response.data.error
				$("#loginForm").tooltip({title: "test", placement: "bottom", delay: { show: 100, hide: 1000 }}).tooltip('show');
				true
			)
]