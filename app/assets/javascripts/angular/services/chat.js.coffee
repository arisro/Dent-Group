mod = angular.module('Drs.services')
mod.factory 'Chat', ['$resource', ($resource) ->
	$resource "/chat", {},
		online:
			method: "GET"
			url: "/chat/online.json"
		get_user:
			method: "GET"
			url: "/chat/get_user/:id.json"
		ignore:
			method: "POST"
			url: "/chat_ignores.json"
		unignore:
			method: "DELETE"
			url: "/chat_ignores/:user_id.json"
]