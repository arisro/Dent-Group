mod = angular.module('Drs.services')
mod.factory 'HomepageMessagesCategory', ['$resource', ($resource) ->
	$resource "/homepage_messages_categories/:id.json", id: '@id',
    update:
      method: 'PUT'

]