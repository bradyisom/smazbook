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
        offset = $(event.currentTarget).closest('.workspace-canvas').offset()
        origin =
            x: offset.left + widget.x + widget.width/2
            y: offset.top + widget.y + (widget.height or 0)/2
        point =
            x: event.pageX
            y: event.pageY
        if mode != 'container'
            point = @rotatePoint(origin, -widget.rotate, point)
        @moveState =
            mode: mode
            widget: widget
            origin: origin
            point: point
            originalRect: _.pick widget, ['x', 'y', 'width', 'height']
            aspect: widget.width / widget.height
        event.stopPropagation()

    startRotate: (event, widget)->
        point =
            x: event.pageX
            y: event.pageY
        offset = $(event.currentTarget).closest('.workspace-canvas').offset()
        origin =
            x: offset.left + widget.x + widget.width/2
            y: offset.top + widget.y + (widget.height or 0)/2

        @rotateState =
            widget: widget
            origin: origin
            originalAngle: @getAngle(origin, point)
            originalRotation: widget.rotate

        event.stopPropagation()

    move: (event)->
        return if not @moveState and not @rotateState

        if @moveState
            p =
                x: event.pageX
                y: event.pageY
            if @moveState.mode != 'container'
                p = @rotatePoint(@moveState.origin, -@moveState.widget.rotate, p)
            diffX = p.x - @moveState.point.x
            diffY = p.y - @moveState.point.y

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
                    @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, @moveState.widget.x)
                    @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, @moveState.widget.y)
                when 'ne'
                    if -(diffX / @moveState.aspect) > diffY
                        diffX = -(diffY / @moveState.aspect)
                    else
                        diffY = -(diffX * @moveState.aspect)
                    @moveState.widget.y = @moveState.originalRect.y + diffY
                    @moveState.widget.width = @moveState.originalRect.width + diffX
                    @moveState.widget.height = @moveState.originalRect.height - diffY
                    @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, @moveState.widget.y)
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
                    @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, @moveState.widget.x)
                when 'we'
                    @moveState.widget.x = @moveState.originalRect.x + diffX
                    @moveState.widget.width = @moveState.originalRect.width - diffX
                    @moveState.widget.x = Math.min(@moveState.originalRect.x + @moveState.originalRect.width, @moveState.widget.x)
                when 'ew'
                    @moveState.widget.width = @moveState.originalRect.width + diffX
                when 'ns'
                    @moveState.widget.y = @moveState.originalRect.y + diffY
                    @moveState.widget.height = @moveState.originalRect.height - diffY
                    @moveState.widget.y = Math.min(@moveState.originalRect.y + @moveState.originalRect.height, @moveState.widget.y)
                when 'sn'
                    @moveState.widget.height = @moveState.originalRect.height + diffY
                else
                    @moveState.widget.x = @moveState.originalRect.x + diffX
                    @moveState.widget.y = @moveState.originalRect.y + diffY

            @moveState.widget.width = Math.max(0, @moveState.widget.width)
            @moveState.widget.height = Math.max(0, @moveState.widget.height)
        else if @rotateState
            angle = @getAngle(@rotateState.origin,
                x: event.pageX
                y: event.pageY
            )
            @rotateState.widget.rotate = (@rotateState.originalRotation or 0) + (angle - @rotateState.originalAngle)

    endMove: ->
        return if not @moveState and not @rotateState
        @resetMove()

    cancelMove: ->
        return if not @moveState and not @rotateState
        if @moveState
            angular.extend @moveState.widget, @moveState.originalRect
        else if @rotateState
            @rotateState.widget.rotate = @rotateState.originalRotation
        @resetMove()

    resetMove: ->
        @moveState = null
        @rotateState = null

    getAngle: (origin, point)->
        dx = point.x - origin.x
        dy = point.y - origin.y
        if dx == 0
            angle = if dy >= 0 then Math.PI/2 else -Math.PI/2
        else
            angle = Math.atan(dy/dx)
            if dx < 0
                angle += Math.PI
        if angle < 0
            angle += 2*Math.PI
        angle

    rotatePoint: (origin, angle, point)->
        angle or= 0
        s = Math.sin(angle)
        c = Math.cos(angle)

        p = _.clone(point)
        p.x -= origin.x
        p.y -= origin.y

        p.x = (p.x * c) - (p.y * s) + origin.x
        p.y = (p.x * s) + (p.y * c) + origin.y

        p

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
