angular.module('smazbook').directive 'widget', (createSVGNode, $document, $sce)->
    templateUrl: '/smazbook/workspace/widget.html'
    restrict: 'EA'
    scope:
        state: '='
        rect: '='
    link: (scope, el, attrs)->
        scope.handleSize = 10
        scope.halfHandleSize = scope.handleSize / 2

        el = createSVGNode('g', el, attrs)

        scope.onMouseDown = (event, target)->
            scope.state.startMove event, scope.rect, target

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.rect.href




