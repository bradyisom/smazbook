angular.module('smazbook')
.directive 'workspaceCanvas', (createSVGNode)->
    templateUrl: '/smazbook/workspace/canvas.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
        widgets: '='
    link: (scope, el, attrs)->
        el.css 'position', 'relative'

        scope.handleSize = 10
        scope.halfHandleSize = scope.handleSize / 2
        scope.isSvgWidget = (widget)->
            widget.type != 'text'

        scope.isDivWidget = (widget)->
            widget.type == 'text'
