jQuery ->
	window.chatController = new Chat.Controller('msg.drs.local/websocket', true)
	
$(document).ready ->
	setTimeout ->
		console.log ''
		# window.chatController.sendMessage(null)
	, 2000

window.Chat = {}

class Chat.Controller 
	constructor: (url, useWebSockets) ->
		@uid = $("#chatbox").data("uid")
		@key = $("#chatbox").data("key")
		@messageQueue = []
		@dispatcher = new WebSocketRails(url, useWebSockets)
		@dispatcher.on_open = @createUser

	bindEvents: =>
		@channel.bind 'chat_new_message', @newMessage
		@dispatcher.bind 'chat_user_list', @updateUsersList

	newMessage: (event) =>
		$("#chatContainer").scope().receiveMessage(event.from, event.message)

	updateUsersList: (users) =>
		$("#chatContainer").scope().$apply ->
			$("#chatContainer").scope().updateUsersList(users)

	sendMessage: (uid, message) =>
		@dispatcher.trigger 'chat_new_message', {to_user_id: uid, msg_body: message}

	createUser: =>
	    @dispatcher.trigger 'chat_new_user', { user_id: @uid, key: @key }
	    @channel = @dispatcher.subscribe_private('u' + @uid)
	    @bindEvents()