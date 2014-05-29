angular.module('smazbook').directive 'workspace', ->
    templateUrl: '/smazbook/workspace/workspace.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
    link: (scope, el, attrs)->

