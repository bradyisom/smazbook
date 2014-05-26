angular.module('smazbook').directive 'canvasWidget', ($sce)->
    templateUrl: '/smazbook/workspace/widget.html'
    restrict: 'EA'
    scope:
        state: '='
        widget: '='
        handleSize: '=?'
    link: (scope, el, attrs)->
        scope.handleSize or= 10
        scope.halfHandleSize = scope.handleSize / 2

        scope.isSvgWidget = (widget)->
            widget.type != 'text'

        scope.isDivWidget = (widget)->
            widget.type == 'text'

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.widget.href




