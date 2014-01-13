mod = angular.module('Drs.services')
mod.factory 'User', ['$resource', ($resource) ->
	$resource "/users", {},
		create:
			method: "POST"
			url: "/user.json"
]