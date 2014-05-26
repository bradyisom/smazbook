angular.module('smazbook').directive 'canvasWidget', ($sce)->
    templateUrl: '/smazbook/workspace/widget.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
        widget: '='
        handleSize: '=?'
    link: (scope, el, attrs)->
        scope.handleSize or= 10
        scope.halfHandleSize = scope.handleSize / 2

        scope.isDivWidget = (widget)->
            widget.type == 'text' || widget.type == 'image'

        scope.isSvgWidget = (widget)->
            !scope.isDivWidget(widget)

        scope.isTextWidget = (widget)->
            widget.type == 'text'

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.widget.href


