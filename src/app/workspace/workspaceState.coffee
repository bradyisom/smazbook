class WorkspaceState
    # @$inject = []
    constructor: (widgets, handleSize)->
        @resetMove()
        @selected = null
        @widgets = widgets or []
        @handleSize = handleSize or 15
        @halfHandleSize = @handleSize / 2
        @

    select: (widget)->
        @selected = widget

    startMove: (event, widget, mode)->
        @selected = widget
        @moveState =
            mode: mode
            widget: widget
            point:
                x: event.pageX
                y: event.pageY
            originalRect: _.pick widget, ['x', 'y', 'width', 'height']
            aspect: widget.width / widget.height
        event.stopPropagation()

    move: (event)->
        return if not @moveState
        diffX = event.pageX - @moveState.point.x
        diffY = event.pageY - @moveState.point.y

        switch @moveState.mode
            when 'nw'
                if diffX / @moveState.aspect > diffY
                    diffX = diffY / @moveState.aspect
                else
                    diffY = diffX * @moveState.aspect
                @moveState.widget.x = @moveState.originalRect.x + diffX
                @moveState.widget.y = @moveState.originalRect.y + diffY
                @moveState.widget.width = @moveState.originalRect.width - diffX
                @moveState.widget.height = @moveState.originalRect.height - diffY
                @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, Math.max(0, @moveState.widget.x))
                @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, Math.max(0, @moveState.widget.y))
            when 'ne'
                if -(diffX / @moveState.aspect) > diffY
                    diffX = -(diffY / @moveState.aspect)
                else
                    diffY = -(diffX * @moveState.aspect)
                @moveState.widget.y = @moveState.originalRect.y + diffY
                @moveState.widget.width = @moveState.originalRect.width + diffX
                @moveState.widget.height = @moveState.originalRect.height - diffY
                @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, Math.max(0, @moveState.widget.y))
            when 'se'
                if diffX / @moveState.aspect > diffY
                    diffY = diffX * @moveState.aspect
                else
                    diffX = diffY / @moveState.aspect
                @moveState.widget.width = @moveState.originalRect.width + diffX
                @moveState.widget.height = @moveState.originalRect.height + diffY
            when 'sw'
                if diffX / @moveState.aspect > -diffY
                    diffX = -(diffY / @moveState.aspect)
                else
                    diffY = -(diffX * @moveState.aspect)
                @moveState.widget.x = @moveState.originalRect.x + diffX
                @moveState.widget.width = @moveState.originalRect.width - diffX
                @moveState.widget.height = @moveState.originalRect.height + diffY
                @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, Math.max(0, @moveState.widget.x))
            when 'we'
                @moveState.widget.x = @moveState.originalRect.x + diffX
                @moveState.widget.width = @moveState.originalRect.width - diffX
                @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, Math.max(0, @moveState.widget.x))
            when 'ew'
                @moveState.widget.width = @moveState.originalRect.width + diffX
            when 'ns'
                @moveState.widget.y = @moveState.originalRect.y + diffY
                @moveState.widget.height = @moveState.originalRect.height - diffY
                @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, Math.max(0, @moveState.widget.y))
            when 'sn'
                @moveState.widget.height = @moveState.originalRect.height + diffY
            else
                @moveState.widget.x = @moveState.originalRect.x + diffX
                @moveState.widget.y = @moveState.originalRect.y + diffY
                @moveState.widget.x = Math.max(0, @moveState.widget.x)
                @moveState.widget.y = Math.max(0, @moveState.widget.y)

        @moveState.widget.width = Math.max(0, @moveState.widget.width)
        @moveState.widget.height = Math.max(0, @moveState.widget.height)

    endMove: ->
        return if not @moveState
        @resetMove()

    cancelMove: ->
        return if not @moveState
        angular.extend @moveState.widget, @moveState.originalRect
        @resetMove()

    resetMove: ->
        @moveState = null

    moveToTop: ->
        index = _.indexOf @widgets, @selected
        return if index == -1
        @widgets.splice index, 1
        @widgets.push @selected

    moveToBottom: ->
        index = _.indexOf @widgets, @selected
        return if index == -1
        @widgets.splice index, 1
        @widgets.unshift @selected

    moveUp: ->
        index = _.indexOf @widgets, @selected
        return if index == -1 or index >= @widgets.length - 1
        @widgets.splice index, 1
        @widgets.splice index+1, 0, @selected

    moveDown: ->
        index = _.indexOf @widgets, @selected
        return if index <= 0
        @widgets.splice index, 1
        @widgets.splice index-1, 0, @selected




angular.module('smazbook').factory 'WorkspaceState', -> WorkspaceState
