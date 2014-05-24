angular.module('smazbook', [
    'ngRoute'
    'smazbook.todo'
    'smazbook-templates'
])
.config ($routeProvider, $logProvider) ->
    'use strict'
    $logProvider.debugEnabled true
    $routeProvider
        .when '/todo',
            controller: 'TodoCtrl'
            templateUrl: '/smazbook/todo/todo.html'
        .when '/testsvg',
            controller: 'TestSvgCtrl as ctrl'
            templateUrl: '/smazbook/test/testSvg.html'
        .otherwise
            redirectTo: '/testsvg'


