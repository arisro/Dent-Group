mod = angular.module('Drs.services')
mod.factory 'NewsCategory', ['$resource', ($resource) ->
	$resource "/news_categories/:id.json", id: '@id',
    update:
      method: 'PUT'

]