$(document).ready(function(e) {
	$('.with-hover-text, .regular-link').click(function(e){
		e.stopPropagation();
	});

	$('.selectpicker').selectpicker({showContent: true, width: '160px'});
	$("#countrySelect").on('change', function(e) {
		var _url = '/' + $(this).val();
		if (/\/(int|ro|de)/.test(window.location.href)) {
			_url = window.location.href.replace(/\/(int|ro|de)/, '/' + $(this).val());
			// _url = _url.replace(/\/\d+$/, '');
		}
		window.location.href = _url;
	});

	// menu dropdowns
	var dropdownHideTimer = null;
	$(".dropdown").parents(".menu-item").on("mouseover", function(e) {
		var dropdown = $(this).find('.dropdown');
		if ($(dropdown).not(":visible")) {
			$(dropdown).fadeIn('slow');
		}
		if (dropdownHideTimer) {
			clearTimeout(dropdownHideTimer);
		}
	}).on("mouseleave", function(e) {
		var item = $(this);
		dropdownHideTimer = setTimeout(function() {
			$(item).find('.dropdown').fadeOut('slow');
		}, 500);
	});

	// search box width animation
	$('#menu-search-box input').focus(function() {
		$(this).attr('data-default', $(this).parent().width());
		$(this).parent().animate({ width: 180 }, 'slow');
	}).blur(function() {
		var w = $(this).attr('data-default');
		$(this).parent().animate({ width: w }, 'slow');
	});

	// CHAT TOGGLE
	$("#chat-toggle-link").on('click', function(e) {
		e.preventDefault();
		$('.main-container').stop().animate({"padding-left": '10'}, 750,'easeOutQuart');
		$("#aShowChat").parent().fadeIn('slow');
	});
	$("#aShowChat").on('click', function(e) {
		e.preventDefault();
		$('.main-container').stop().animate({"padding-left": '210'}, 750,'easeOutQuart');
		$("#aShowChat").parent().fadeOut('fast');
	});

	$("#menu-search-box input").on('keyup', function(e) {
		if (e.keyCode == 13) {
			$('.main-container').stop().animate({"padding-right": '210'}, 750,'easeOutQuart');

			// do search here!
		}
	});
	$(".sidebar-right .close").on('click', function(e) {
		$('.main-container').stop().animate({"padding-right": '10'}, 750,'easeOutQuart');
		$("#menu-search-box input").val('');
	});

	/***************
	* = Hover text *
	* Hover text for the last slide
	***************/
	$('.with-hover-text').hover(
		function(e) {
			$(this).css('overflow', 'visible');
			$(this).find('.hover-text')
				.show()
				.css('opacity', 0)
				.delay(200)
				.animate(
					{
						paddingTop: '25px',
						opacity: 1
					},
					'fast',
					'linear'
				);
		},
		function(e) {
			var obj = $(this);
			$(this).find('.hover-text')
				.animate(
					{
						paddingTop: '0',
						opacity: 0
					},
					'fast',
					'linear',
					function() {
						$(this).hide();
						$( obj ).css('overflow', 'hidden');
					}
				);
		}
	);
	
	var img_loaded = 0;
	var j_images = [];
	
	/*************************
	* = Controls active menu *
	* Hover text for the last slide
	*************************/
	$('#slide-3 img').each(function(index, element) {
		var time = new Date().getTime();
		var oldHref = $(this).attr('src');
		var myImg = $('<img />').attr('src', oldHref + '?' + time );
		
		myImg.load(function(e) {
			img_loaded += 1;;
			if ( img_loaded == $('#slide-3 img').length ) {
				$(function() {
					var pause = 10;
					$(document).scroll(function(e) {
						delay(function() {
							
							var tops = [];
							
							$('.story').each(function(index, element) {
								tops.push( $(element).offset().top - 200 );
							});
				
							var scroll_top = $(this).scrollTop();
							
							var lis = $('.nav > li');
							
							for ( var i=tops.length-1; i>=0; i-- ) {
								if ( scroll_top >= tops[i] ) {
									menu_focus( lis[i], i+1 );
									break;
								}
							}
						},
						pause);
					});
					$(document).scroll();
				});
			}
		});
	});
	
});

var delay = (function(){
	var timer = 0;
	return function(callback, ms){
		clearTimeout (timer);
		timer = setTimeout(callback, ms);
	};
})();

function menu_focus( element, i ) {
	if ( $(element).hasClass('active') ) {
		if ( i == 6 ) {
			if ( $('.navbar').hasClass('inv') == false )
				return;
		} else {
			return;
		}
	}
	
	enable_arrows( i );
		
	if ( i == 1 || i == 3 )
		$('.navbar').removeClass('inv');
	else
		$('.navbar').addClass('inv');
	
	$('.nav > li').removeClass('active');
	$(element).addClass('active');
	
	var icon = $(element).find('.icon');
	
	var left_pos = icon.offset().left - $('.nav').offset().left + 10;
	var el_width = icon.width() + $(element).find('.text').width() + 10;
	
	$('.active-menu').stop(false, false).animate(
		{
			left: left_pos,
			width: el_width
		},
		1500,
		'easeInOutQuart'
	);
}

/*************
* = Parallax *
*************/
jQuery(document).ready(function ($) {	
	//Cache some variables
	var links = $('.nav').find('li.menu-item');
	slide = $('.slide');
	button = $('.button');
	mywindow = $(window);
	htmlbody = $('html,body');
	
	//Create a function that will be passed a slide number and then will scroll to that slide using jquerys animate. The Jquery
	//easing plugin is also used, so we passed in the easing method of 'easeInOutQuint' which is available throught the plugin.
	function goToByScroll(dataslide) {
		if ($("#lp").length > 0) {
			var offset_top = ( dataslide == 1 ) ? '0px' : $('.slide[data-slide="' + dataslide + '"]').offset().top;

			htmlbody.stop(false, false).animate({
				scrollTop: offset_top
			}, 1500, 'easeInOutQuart');
		}
	}
	
	//When the user clicks on the navigation links, get the data-slide attribute value of the link and pass that variable to the goToByScroll function
	links.click(function (e) {
		if ($("#lp").length > 0) {
			e.preventDefault();
			dataslide = $(this).attr('data-slide');
			goToByScroll(dataslide);
		}
	});
	
	//When the user clicks on the navigation links, get the data-slide attribute value of the link and pass that variable to the goToByScroll function
	$('.navigation-slide').click(function (e) {
		e.preventDefault();
		dataslide = $(this).attr('data-slide');
		goToByScroll(dataslide);
	});
});

/***************
* = Menu hover *
***************/
jQuery(document).ready(function ($) {
	//Cache some variables
	var menu_item = $('.nav').find('li.menu-item');
	
	menu_item.hover(
		function(e) {
			var icon = $(this).find('.icon');
			
			var left_pos = icon.offset().left - $('.nav').offset().left + 10;
			var el_width = icon.width() + $(this).find('.text').width() + 10;
			
			var hover_bar = $('<div class="active-menu special-active-menu"></div>')
				.css('left', left_pos)
				.css('width', el_width)
				.attr('id', 'special-active-menu-' + $(this).data('slide') );
			
			$('.active-menu').after( hover_bar );
		},
		function(e) {
			$('.special-active-menu').remove();
		}
	);
});