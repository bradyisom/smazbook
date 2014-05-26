class TestSvgCtrl
    @$inject: ['$scope', 'WorkspaceState']
    constructor: (@$scope, WorkspaceState)->
        @widgets = [
            x: 100
            y: 100
            width: 300
            height: 300
            type: 'image'
            href: 'http://lorempixel.com/300/300/technics'
            fill: 'red'
        ,
            x: 200
            y: 50
            width: 250
            height: 200
            fill: 'blue'
        ,
            x: 50
            y: 50
            width: 200
            # height: 200
            type: 'text'
            text: 'Hello World! Some more text goes here.'
            fill: 'green'
            stroke: 'yellow'
        ]
        @handleSize = 10
        @halfHandleSize = @handleSize / 2

        @state = new WorkspaceState()


angular.module('smazbook').controller 'TestSvgCtrl', TestSvgCtrl
