$ ->
	clearJcrop = ->
		if $('#picUrl').data('Jcrop')? then $('#picUrl').data('Jcrop').destroy()
		$("#picUrl").attr 'src', ''
		$("#picUrl").css 'width', 'auto'
		$("#picUrl").css 'height', 'auto'
		$.fancybox.update()
		$('#user_pic_cropx').val(0)
		$('#user_pic_cropy').val(0)
		$('#user_pic_cropw').val(0)
		$('#user_pic_croph').val(0)
		$('#user_pic_name').val('')

	$("#bUploader").fancybox {
		scrolling: 'no'
		autoScale: true
		autoDimensions: true
		afterClose: ->
			clearJcrop()
	}

	$("#dUploader").on 'uploadComplete', (event, filename, width, height) ->
		$("#picUrl").attr 'src', '/temp_profile_pictures/' + filename
		$('#user_pic_name').val(filename)

		$('#picUrl').Jcrop {
			aspectRatio: 1
			minSize: [80, 80]
			setSelect: [ 30, 30, 100, 100 ]
			boxWidth: 1000
			boxHeight: 500
			onSelect: (c) ->
				$('#user_pic_cropx').val(c.x)
				$('#user_pic_cropy').val(c.y)
				$('#user_pic_cropw').val(c.w)
				$('#user_pic_croph').val(c.h)
		}
		setTimeout ->
			$.fancybox.update()
		, 200
		true

	$("#fProfilePicture").on 'change', '#tiInput', (event) ->
		clearJcrop()
		if $(this).val() != ''
			$(this).parent().submit()

	$('#fPicker').on 'click', ->
		$('#tiInput').trigger('click');

	$('#fPickerDone').on 'click', ->
		$.post '/user/save_profile_picture',
			filename: $('#user_pic_name').val()
			cropx: $('#user_pic_cropx').val()
			cropy: $('#user_pic_cropy').val()
			cropw: $('#user_pic_cropw').val()
			croph: $('#user_pic_croph').val()
			(data) ->
				$("#iCurrentProfilePic").attr 'src', '/profile_pictures/thumbs2/' + $('#user_pic_name').val()
				$(".menu-profile-icon").attr 'src', '/profile_pictures/thumbs2/' + $('#user_pic_name').val()
				clearJcrop()
				$.fancybox.close()

	$('#fPickerCancel').on 'click', ->
		clearJcrop()
		$.fancybox.close()

	true