//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require html5shiv
//= require angular
//= require angular-animate
//= require angular-route
//= require angular-resource
//= require_tree ./angular
//= require app
//= require jquery.qtip.js
//= require bootbox.min.js

$(document).ready(function() {
	var _scrollSpeed			= 1000;
	window.navHeight 			= jQuery("#header").height();

	$(".scrollTo").on("click", function(e) {
		e.preventDefault();
		var href = jQuery(this).attr('href');
		if(href != '#') {
			jQuery('html,body').animate({scrollTop: jQuery(href).offset().top - window.navHeight}, _scrollSpeed, 'easeInOutExpo');
		}
	});

	jQuery("a.toTop").bind("click", function(e) {
		e.preventDefault();
		jQuery('html,body').animate({scrollTop: 0}, 1000, 'easeInOutExpo');
	});

	if(jQuery(".full-screen").length > 0) {
		_fullscreen();

		jQuery(window).resize(function() {
			_fullscreen();
		});
	}
	function _fullscreen() {
		var _screenHeight = jQuery(window).height();
		jQuery(".full-screen, .full-screen ul, .full-screen li").height(_screenHeight);
	}

	$('.ttconnect').attr('title', $("#ttconnect").html());
	$('.ttdiscuss').attr('title', $("#ttdiscuss").html());
	$('.ttshare').attr('title', $("#ttshare").html());
	$('.ttmore').attr('title', $("#ttmore").html());
	$('.tt').tooltip({html: true });

	if(jQuery("#home").length > 0) {
		window.isOnTop 		= true;
		window.homeHeight 	= jQuery("#home").height() - window.navHeight;

		jQuery(window).scroll(function() {
			if(jQuery(document).scrollTop() > window.homeHeight) {
				if(window.isOnTop === true) {
					jQuery('#header').addClass('fixed');
					window.isOnTop = false;
				}
			} else {
				if(window.isOnTop === false) {
					jQuery('#header').removeClass('fixed');
					window.isOnTop = true;
				}
			}
		});

		jQuery(window).resize(function() {
			//window.homeHeight = jQuery("#home").height() - window.navHeight;
		});

	}

	$('.signin').qtip({
		id: "loginError",
		content: 'Incorrect e-mail or password. Make sure that they are typed correctly.',
		position: {
			my: 'bottom left',
			at: 'top left'
		},
		hide: {
			event: false,
			inactive: 5000
		},
		show: {
			event: false
		}	
	});
});

// easing - only needed
jQuery.extend( jQuery.easing,{
	easeInOutExpo: function (x, t, b, c, d) {
		if (t==0) return b;
		if (t==d) return b+c;
		if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
		return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
	},
});