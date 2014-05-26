angular.module('smazbook')
.directive 'workspaceCanvas', (createSVGNode)->
    templateUrl: '/smazbook/workspace/canvas.html'
    restrict: 'EA'
    scope:
        rects: '='
    link: (scope, el, attrs)->

        scope.onMouseMove = (e)->
            scope.$broadcast 'mouseMove', e
        scope.onMouseUp = (e)->
            scope.$broadcast 'mouseUp', e
        scope.onMouseLeave = (e)->
            scope.$broadcast 'mouseLeave', e
