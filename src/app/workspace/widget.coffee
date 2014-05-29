angular.module('smazbook').directive 'canvasWidget', ($sce)->
    templateUrl: '/smazbook/workspace/widget.html'
    restrict: 'EA'
    replace: true
    scope:
        state: '='
        widget: '='
    link: (scope, el, attrs)->

        scope.isDivWidget = (widget)->
            widget.type == 'text' || widget.type == 'image'

        scope.isSvgWidget = (widget)->
            !scope.isDivWidget(widget)

        scope.isTextWidget = (widget)->
            widget.type == 'text'

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.widget.href


