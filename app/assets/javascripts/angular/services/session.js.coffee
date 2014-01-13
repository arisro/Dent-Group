mod = angular.module('Drs.services')
mod.factory 'Session', ['$resource', ($resource) ->
	$resource "/sessions", {},
		create:
			method: "POST"
]