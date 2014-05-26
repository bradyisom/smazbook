angular.module('smazbook').directive 'canvasWidget', (createSVGNode, $document, $sce)->
    templateUrl: '/smazbook/workspace/widget.html'
    restrict: 'EA'
    scope:
        state: '='
        widget: '='
        handleSize: '=?'
    link: (scope, el, attrs)->
        scope.handleSize or= 10
        scope.halfHandleSize = scope.handleSize / 2

        el = createSVGNode('g', el, attrs)

        scope.onMouseDown = (event, target)->
            scope.state.startMove event, scope.widget, target

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.widget.href




