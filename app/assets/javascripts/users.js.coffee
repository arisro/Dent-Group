$ ->
	$('#upload_uploaded_file').attr('name','upload[uploaded_file]')
	$('#fileupload').fileupload
		dataType: 'script'
		autoUpload: true
		add: (e, data) ->
			types = /(\.|\/)(jpe?g|png)$/i
			file = data.files[0]
			file.cname = file.name.replace(/[^a-zA-Z0-9]/g, '')
			if types.test(file.type) || types.test(file.name)
				data.context = $(tmpl("template-upload", file))
				$('.images-list').append(data.context)
				data.submit()
			else
				alert("#{file.name} is not a jpg or png image file")

	$('#but-add-image').on 'click', (e) ->
		e.preventDefault()
		$('#input_files').trigger 'click'

	$('a.feed-item-image-link').fancybox()
	$('a.offer-image-link').fancybox()

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

	$("#upload-pic").on 'uploadComplete', (event, filename, width, height) ->
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