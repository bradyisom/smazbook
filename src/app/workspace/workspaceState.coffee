class WorkspaceState
    # @$inject = []
    constructor: ->
        @resetMove()
        @

    startMove: (event, widget, mode)->
        @moveState =
            mode: mode
            widget: widget
            point:
                x: event.pageX
                y: event.pageY
            originalRect: _.pick widget, ['x', 'y', 'width', 'height']

    move: (event)->
        return if not @moveState
        diffX = event.pageX - @moveState.point.x
        diffY = event.pageY - @moveState.point.y
        switch @moveState.mode
            when 'nw'
                @moveState.widget.x += diffX
                @moveState.widget.y += diffY
                @moveState.widget.width -= diffX
                @moveState.widget.height -= diffY
                @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, Math.max(0, @moveState.widget.x))
                @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, Math.max(0, @moveState.widget.y))
            when 'ne'
                @moveState.widget.y += diffY
                @moveState.widget.width += diffX
                @moveState.widget.height -= diffY
                @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, Math.max(0, @moveState.widget.y))
            when 'se'
                @moveState.widget.width += diffX
                @moveState.widget.height += diffY
            when 'sw'
                @moveState.widget.x += diffX
                @moveState.widget.width -= diffX
                @moveState.widget.height += diffY
                @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, Math.max(0, @moveState.widget.x))
            else
                @moveState.widget.x += diffX
                @moveState.widget.y += diffY
                @moveState.widget.x = Math.max(0, @moveState.widget.x)
                @moveState.widget.y = Math.max(0, @moveState.widget.y)

        @moveState.widget.width = Math.max(0, @moveState.widget.width)
        @moveState.widget.height = Math.max(0, @moveState.widget.height)

        @moveState.point =
            x: event.pageX
            y: event.pageY

    endMove: ->
        return if not @moveState
        @resetMove()

    cancelMove: ->
        return if not @moveState
        angular.extend @moveState.widget, @moveState.originalRect
        @resetMove()

    resetMove: ->
        @moveState = null


angular.module('smazbook').factory 'WorkspaceState', -> WorkspaceState
