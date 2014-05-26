angular.module('smazbook')
.directive 'workspaceCanvas', ->
    templateUrl: '/smazbook/workspace/canvas.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
        widgets: '='
    link: (scope, el, attrs)->
        el.css 'position', 'relative'

        scope.handleSize = 15
        scope.halfHandleSize = scope.handleSize / 2
