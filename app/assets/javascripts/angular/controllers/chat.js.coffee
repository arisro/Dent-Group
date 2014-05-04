mod = angular.module('Drs.controllers')
mod.controller "ChatController", [
	'$scope'
	'$resource'
	'$log'
	'$window'
	'User'
	'Chat'
	($scope, $resource, $log, $window, User, Chat) ->
		$scope.current_user = {
			user_id: 0
			user_name: $("#chatbox").data("user-name")
			profile_picture: $("#chatbox").data("profile-picture")
		}
		$scope.searchString = ''
		$scope.openWindows = []
		$scope.followed_users = []
		$scope.users = []
		$scope.uid = $("#chatbox").data("uid")

		searchTimeout = null

		$scope.init = ->
			$ ->
				setTimeout ->
					$(".chat-box-bot").removeClass('hidden')
				,1000

				# load followed users
				User.followed({id: $scope.uid}, (response) ->
					$scope.followed_users = response.data
					$scope.users = $scope.followed_users
				,(response) ->
					console.log 'error while loading followed users'
				)

				# load more messages link
				$('#chatContainer').on 'click', 'a.load-more-messages', (e) ->
					that = $(this)
					$(this).addClass('hidden')
					$(this).parent().find('> span').removeClass('hidden')
					chat_window = $(this).closest(".chat-window")
					window_data = $scope.openWindows[chat_window.data('index')]
					$scope.loadHistory(window_data, ->
						that.parent().find('> span').addClass('hidden')
						that.removeClass('hidden') if window_data.window.show_more
					)


		$scope.$watch 'searchString', (search_string) ->
			if searchTimeout != null
				clearTimeout(searchTimeout)
			searchTimeout = setTimeout ->
				if search_string == ''
					$scope.users = $scope.followed_users
				else
					Chat.online({q: search_string}, (response) ->
						$scope.users = response.data
					, (response) ->
						console.log "error while loading online users"
					)
			,1000


		$scope.loadHistory = (wwindow, callback) ->
			# load history
			Chat.history({user_id: wwindow.user.user_id, page: wwindow.window.page + 1}, (history_response) ->
				for m in history_response.messages
					_u = if m.from_user_id == $scope.uid then $scope.current_user else wwindow.user
					# $scope.$apply ->
					wwindow.window.messages.unshift({user: _u, text:m.text}) 

				wwindow.window.show_more = history_response.show_more
				wwindow.window.page = wwindow.window.page + 1

				if typeof callback != 'undefined'
					callback()
			,(history_response) ->
				console.log 'unable to load chat history'
			)

		$scope.updateUsersList = (users) ->
			$scope.users = users

		$scope.openWindow = (uid, from_user, msg) ->
			if !isOpenWindowForUser(uid)
				Chat.get_user({id: uid}, (response) ->
					new_window = {
						user: response.user
						window: {
							visible: true
							messages: []
							message: ''
							page: 0
							show_more: false
						}
					}
					$scope.openWindows.push new_window

					$scope.loadHistory(new_window, ->
						setTimeout(->
							$(".chat-window-body").scrollTop(10000)
						,100)
					)

					# if we also have a message
					if from_user
						new_window.window.messages.push {
							user: from_user
							text: msg
						}
				,(response) ->
					console.log "unable to load user details"
				)
				

		$scope.sendMessage = (index) ->
			$chatWindow = $scope.openWindows[index]
			uid = $chatWindow.user.user_id
			msg = $chatWindow.window.message

			# console.log "Sending message (to "+uid+"): " + msg

			$scope.$apply ->
				$chatWindow.window.messages.push {
					user: $scope.current_user
					text: msg
				}
			window.chatController.sendMessage(uid, msg)

			$scope.openWindows[index].window.message = ''
			$("#chatContainer textarea").eq(index).val('')

			$(".chat-window-body").scrollTop(10000)


		$scope.receiveMessage = (user, msg) ->
			# console.log "Received message (from "+user.user_id+"): "+msg

			do_scroll = false
			window_body = null
			window_found = false

			for win, i in $scope.openWindows
				if win.user.user_id == user.user_id
					window_found = true

					# check if scroll is at the bottom and auto scroll if yes
					window_body = $($(".chat-window")[i]).find('.chat-window-body')
					if $(window_body).scrollTop() >= $(window_body)[0].scrollHeight - $(window_body).height()
						do_scroll = true

					$scope.$apply ->
						win.window.messages.push {
							user: user
							text: msg
						}
					break

			if !window_found
				$scope.$apply ->
					$scope.showWindow(user.user_id, user, msg)

			# check if scroll is at the bottom before auto scroll!
			if do_scroll
				window_body.scrollTop(10000)


		$scope.ignoreUser = (user_id, index) ->
			Chat.ignore({user_id: user_id}, ->
				if index != null
					$scope.openWindows[index].user.is_ignored = true
			,(response) ->
				console.log 'error while ignoring user'
			)

		$scope.unignoreUser = (user_id, index) ->
			Chat.unignore({user_id: user_id}, ->
				if index != null
					$scope.openWindows[index].user.is_ignored = false
			,(response) ->
				console.log 'error while unignoring user'
			)


		$scope.toggleWindow = (uid) ->
			if isOpenWindowForUser(uid)
				for win in $scope.openWindows
					if win.user.user_id == uid
						win.window.visible = !win.window.visible

		$scope.showWindow = (uid, from_user, msg) ->
			$scope.openWindow(uid, from_user, msg)
			for win in $scope.openWindows
				if win.user.user_id == uid
					win.window.visible = true

		isOpenWindowForUser = (uid) ->
			for win in $scope.openWindows
				if win.user.user_id == uid
					return true
			return false

		$scope.notMeFilter = (user) ->
			return user.user_id != $scope.uid;
]