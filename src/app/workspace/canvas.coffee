angular.module('smazbook')
.directive 'workspaceCanvas', ->
    templateUrl: '/smazbook/workspace/canvas.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
    link: (scope, el, attrs)->
        el.css 'position', 'relative'
