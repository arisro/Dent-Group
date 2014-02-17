mod = angular.module('Drs.services')
mod.factory 'Upload', ['$resource', ($resource) ->
	$resource "/uploads", {},
		delete:
			method: "DELETE"
			url: "/uploads/:id.json"

]