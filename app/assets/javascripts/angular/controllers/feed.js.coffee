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
]