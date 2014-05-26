angular.module('smazbook')
.directive 'workspaceCanvas', (createSVGNode)->
    templateUrl: '/smazbook/workspace/canvas.html'
    restrict: 'EA'
    scope:
        state: '='
        widgets: '='
    link: (scope, el, attrs)->
