mod = angular.module('Drs.controllers')
mod.controller "NewsController", [
	'$scope'
	'$resource'
	'$log'
	'$window'
	($scope, $resource, $log, $window) ->
		json = {"Accept": "application/json"}
		$scope.window = $window

		$scope.scroll = { busy: false, items: [], after: 0 }

		$ ->
			$('a.load-more-news').on 'inview', (e, visible) ->
				return unless visible
				$('a.load-more-news').addClass('hidden')
				$('#loadMoreContainer > span').removeClass('hidden')
				$.getScript $(this).attr('href')
]