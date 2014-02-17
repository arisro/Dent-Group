$(document).ready ->
	$(".comment_input").on 'click', (e) ->
		e.preventDefault
		if e.which == 13
			$(this).blur
			$(this).closest("form").submit