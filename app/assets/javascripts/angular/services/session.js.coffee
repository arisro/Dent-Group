mod = angular.module('Drs.services')
mod.factory 'Session', ['$resource', ($resource) ->
	$resource "/sessions", {},
		save:
			method: "POST"
]