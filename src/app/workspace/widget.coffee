angular.module('smazbook').directive 'widget', (createSVGNode, $document, $sce)->
    templateUrl: '/smazbook/workspace/widget.html'
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
        originalRect = null
        resetMode = ->
            moveMode = ''
            point = null
            originalRect = null

        scope.onMouseDown = (event, target)->
            moveMode = target
            originalRect = angular.copy scope.rect
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
                    scope.rect.x = Math.min(originalRect.x + originalRect.width, Math.max(0, scope.rect.x))
                    scope.rect.y = Math.min(originalRect.y + originalRect.height, Math.max(0, scope.rect.y))
                when 'ne'
                    scope.rect.y += diffY
                    scope.rect.width += diffX
                    scope.rect.height -= diffY
                    scope.rect.y = Math.min(originalRect.y + originalRect.height, Math.max(0, scope.rect.y))
                when 'se'
                    scope.rect.width += diffX
                    scope.rect.height += diffY
                when 'sw'
                    scope.rect.x += diffX
                    scope.rect.width -= diffX
                    scope.rect.height += diffY
                    scope.rect.x = Math.min(originalRect.x + originalRect.width, Math.max(0, scope.rect.x))
                else
                    scope.rect.x += diffX
                    scope.rect.y += diffY
                    scope.rect.x = Math.max(0, scope.rect.x)
                    scope.rect.y = Math.max(0, scope.rect.y)

            scope.rect.width = Math.max(0, scope.rect.width)
            scope.rect.height = Math.max(0, scope.rect.height)

            point =
                x: event.pageX
                y: event.pageY

        scope.onMouseUp = (event)->
            return if not moveMode
            resetMode()

        onMouseLeave = (event)->
            return if not moveMode
            scope.rect = originalRect
            resetMode()

        scope.$on 'mouseMove', (e, event)->
            scope.onMouseMove event
        scope.$on 'mouseUp', (e, event)->
            scope.onMouseUp event
        scope.$on 'mouseLeave', (e, event)->
            onMouseLeave event

        scope.getHref = ->
            $sce.trustAsResourceUrl scope.rect.href




