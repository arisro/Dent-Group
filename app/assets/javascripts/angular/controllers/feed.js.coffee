mod = angular.module('Drs.controllers')
mod.controller "FeedController", [
	'$scope'
	'Upload'
	'$resource'
	'$log'
	'$window'
	($scope, Upload, $resource, $log, $window) ->
		json = {"Accept": "application/json"}
		$scope.window = $window

		$scope.removeUpload = (upload_id) ->
			deleteConfirmation = confirm('Are you sure you want to delete this image?')
			if deleteConfirmation
				Upload.delete({id: upload_id }, ->
					$("#upload-" + upload_id).remove()
				,(response) ->
					$scope.login_error = response.data.error
				)

		$scope.scroll = { busy: false, items: [], after: 0 }

		$ ->
			$('a.load-more-posts').on 'inview', (e, visible) ->
				return unless visible
				$('a.load-more-posts').addClass('hidden')
				$('#loadMoreContainer > span').removeClass('hidden')
				$.getScript $(this).attr('href')

			$('a.load-previous-comments').on 'click', (e) ->
				
]