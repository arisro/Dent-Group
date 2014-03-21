mod = angular.module('Drs.controllers')
mod.controller "ChatController", [
	'$scope'
	'$resource'
	'$log'
	'$window'
	($scope, $resource, $log, $window) ->
		$scope.zzz = 'test'
		$scope.users = []
		$scope.updateUsersList = (users) ->
			$scope.test = 'test2123123'
			$scope.users = users
			console.log 'got users!'
]