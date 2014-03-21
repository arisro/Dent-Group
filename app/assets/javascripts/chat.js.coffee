jQuery ->
	window.chatController = new Chat.Controller('msg.drs.local/websocket', true)
	
$(document).ready ->
	setTimeout ->
		console.log 'chat'
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

	newMessage: (message) =>
		alert('new message')
		console.log(message)
		# @messageQueue.push message
		# @shiftMessageQueue() if @messageQueue.length > 15
		# @appendMessage message

	updateUsersList: (users) =>
		console.log('users list:')
		console.log users
		$("#chatContainer").scope().updateUsersList(users)

	sendMessage: (event) =>
		# event.preventDefault()
		alert('send message')
		# message = $('#message').val()
		@dispatcher.trigger 'chat_new_message', {to_user_id: 2, msg_body: 'test message'}
		# $('#message').val('')

	createUser: =>
	    @dispatcher.trigger 'chat_new_user', { user_id: @uid, key: @key }
	    @channel = @dispatcher.subscribe_private('u' + @uid)
	    @bindEvents()