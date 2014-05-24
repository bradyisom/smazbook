angular.module('smazbook').directive 'elementContainer', (createSVGNode, $document)->
    templateUrl: '/smazbook/elements/container.html'
    restrict: 'EA'
    scope:
        rect: '='
    link: (scope, el, attrs)->
        scope.handleSize = 10
        scope.halfHandleSize = scope.handleSize / 2

        el = createSVGNode('g', el, attrs)
        # el.attr 'ng-mousemove', 'onMouseMove($event)'
        # el.attr 'ng-mouseup', 'onMouseMove($event)'

        moveMode = ''
        point = null

        scope.onMouseDown = (event, target)->
            moveMode = target
            point =
                x: event.pageX
                y: event.pageY

        scope.onMouseMove = (event)->
            return if not moveMode
            diffX = event.pageX - point.x
            diffY = event.pageY - point.y
            switch moveMode
                when 'nw'
                    scope.rect.x += diffX
                    scope.rect.y += diffY
                    scope.rect.width -= diffX
                    scope.rect.height -= diffY
                when 'ne'
                    scope.rect.y += diffY
                    scope.rect.width += diffX
                    scope.rect.height -= diffY
                when 'se'
                    scope.rect.width += diffX
                    scope.rect.height += diffY
                when 'sw'
                    scope.rect.x += diffX
                    scope.rect.width -= diffX
                    scope.rect.height += diffY
                else
                    scope.rect.x += diffX
                    scope.rect.y += diffY
            point =
                x: event.pageX
                y: event.pageY

        scope.onMouseUp = (event)->
            return if not moveMode
            moveMode = ''
            point = null


