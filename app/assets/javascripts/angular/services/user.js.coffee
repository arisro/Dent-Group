mod = angular.module('Drs.services')
mod.factory 'User', ['$resource', ($resource) ->
	$resource "/users", {},
		create:
			method: "POST"
			url: "/user.json"
		pay:
			method: "PUT"
			url: "/user/pay"
		cancel_reset:
			method: "PUT"
			url: "/user/cancel_reset"
		followed:
			method: "GET"
			url: "/users/:id/following.json"
		resendEmail:
      method: "POST"
      url: "/user/confirmation.json"
]