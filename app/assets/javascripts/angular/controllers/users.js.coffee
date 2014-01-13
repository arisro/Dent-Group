mod = angular.module('Drs.controllers')
mod.controller "UsersController", [
	'$scope'
	'User'
	'Session'
	'$resource'
	'$log'
	'$window'
	($scope, User, Session, $resource, $log, $window) ->
		$scope.newUser = { }
		json = {"Accept": "application/json"}
		$scope.window = $window

		$scope.hasErrorMessage = ->
			$scope.errorMessage?
 
		$scope.errorClass = ->
			"error" if $scope.errorMessage?
 
		$scope.signUp = ->
			$scope.newUser.password_confirmation = $scope.newUser.password

			User.create({user: $scope.newUser, authenticity_token: $('.signup input[name="authenticity_token"]').val() }, ->
				$scope.window.location.href = "/"
			,(response) ->
				$scope.register_errors = response.data.errors
			)

		$scope.user = {}
		$scope.signIn = ->
			Session.create({user: $scope.user, authenticity_token: $('.signin input[name="authenticity_token"]').val() }, ->
				$scope.window.location.href = "/"
			,(response) ->
				$scope.login_error = response.data.error
			)
]