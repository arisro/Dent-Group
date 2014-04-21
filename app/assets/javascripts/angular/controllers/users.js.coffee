mod = angular.module('Drs.controllers')
mod.controller "UsersController", [
	'$scope'
	'User'
	'Session'
	'Password'
	'$resource'
	'$log'
	'$window'
	($scope, User, Session, Password, $resource, $log, $window) ->
		$scope.newUser = { }
		$scope.forgotPassword = {}
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
				if $("#qtip-loginError:visible").length == 0
					$('.signin').qtip('show')
			)

		$scope.pay = ->
			User.pay({}, ->
				$scope.window.location.href = "/"
			,(response) ->
				console.log response.data.errors
			)

		$scope.cancel = ->
			$scope.newUser.currentStep = 1

		$scope.sendResetPassword = ->
			Password.create({user: { email: $(".signin #user_email").val() } }, ->
				alert "Password reset instructions sent!"
			,(response) ->
				console.log response.data.errors
			)

		$scope.changePasswordReset = ->
			console.log $scope.forgotPassword
			Password.update({user: $scope.forgotPassword }, ->
				$scope.window.location.href = "/"
			,(response) ->
				$scope.reset_pass_errors = response.data
			)

		$scope.cancelResetPassword = ->
			User.cancel_reset({}, (->), (response) ->
				console.log response.data.errors
			)
]