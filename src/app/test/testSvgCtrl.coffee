class TestSvgCtrl
    @$inject: ['$scope', 'WorkspaceState']
    constructor: (@$scope, WorkspaceState)->
        @widgets = [
            id: '1'
            x: 200
            y: 50
            width: 250
            height: 200
            fill: 'blue'
        ,
            id: '2'
            x: 50
            y: 50
            width: 200
            # height: 200
            type: 'text'
            text: 'Hello World! Some more text goes here.'
            fill: 'green'
            stroke: 'yellow'
        ,
            id: '3'
            x: 100
            y: 100
            width: 300
            height: 300
            type: 'image'
            href: 'http://lorempixel.com/300/300/technics'
            fill: 'red'
            # rotate: 45
        ]

        @state = new WorkspaceState(@widgets)


angular.module('smazbook').controller 'TestSvgCtrl', TestSvgCtrl
