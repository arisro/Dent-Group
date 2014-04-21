mod = angular.module('Drs.services')
mod.factory 'Password', ['$resource', ($resource) ->
	$resource "/user/password", {},
		create:
			method: "POST"
			url: "/user/password.json"
		update:
			method: "PUT"
			url: "/user/password.json"
]