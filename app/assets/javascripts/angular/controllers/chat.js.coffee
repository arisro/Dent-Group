mod = angular.module('Drs.controllers')
mod.controller "ChatController", [
	'$scope'
	'$resource'
	'$log'
	'$window'
	($scope, $resource, $log, $window) ->
		$scope.current_user = {
			user_id: 0
			user_name: $("#chatbox").data("user-name")
			profile_picture: $("#chatbox").data("profile-picture")
		}
		$scope.openWindows = []
		$scope.users = []
		$scope.uid = $("#chatbox").data("uid")

		$scope.updateUsersList = (users) ->
			$scope.users = users

		$scope.openWindow = (uid) ->
			if !isOpenWindowForUser(uid)
				$scope.openWindows.push {
					user: (i for i in $scope.users when i.user_id is uid)[0]
					window: {
						visible: true
						messages: []
						message: ''
					}
				}

		$scope.sendMessage = (index) ->
			$chatWindow = $scope.openWindows[index]
			uid = $chatWindow.user.user_id
			msg = $chatWindow.window.message

			console.log "Sending message (to "+uid+"): " + msg

			$scope.$apply ->
				$chatWindow.window.messages.push {
					user: $scope.current_user
					text: msg
				}
			window.chatController.sendMessage(uid, msg)

			$scope.openWindows[index].window.message = ''
			$("#chatContainer textarea").eq(index).val('')


		$scope.receiveMessage = (user, msg) ->
			console.log "Received message (from "+user.user_id+"): "+msg

			window_found = false
			for win in $scope.openWindows
				if win.user.user_id == user.user_id
					window_found = true
					$scope.$apply ->
						win.window.messages.push {
							user: user
							text: msg
						}

			if !window_found
				console.log 'opening window :/'
				$scope.$apply ->
					$scope.showWindow(user.user_id)
					for win in $scope.openWindows
						if win.user.user_id == user.user_id
							win.window.messages.push {
								user: user
								text: msg
							}


		$scope.toggleWindow = (uid) ->
			if isOpenWindowForUser(uid)
				for win in $scope.openWindows
					if win.user.user_id == uid
						win.window.visible = !win.window.visible

		$scope.showWindow = (uid) ->
			$scope.openWindow(uid)
			for win in $scope.openWindows
				if win.user.user_id == uid
					win.window.visible = true

		isOpenWindowForUser = (uid) ->
			for win in $scope.openWindows
				if win.user.user_id == uid
					return true
			return false
]