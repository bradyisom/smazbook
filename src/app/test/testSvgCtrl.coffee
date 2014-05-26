class TestSvgCtrl
    @$inject = ['$scope']
    constructor: (@$scope)->
        @rects = [
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
            x: 10
            y: 10
            width: 150
            height: 150
            type: 'text'
            text: 'Hello World! Some more text goes here.'
            fill: 'green'
        ]
        @handleSize = 10
        @halfHandleSize = @handleSize / 2


angular.module('smazbook').controller 'TestSvgCtrl', TestSvgCtrl
