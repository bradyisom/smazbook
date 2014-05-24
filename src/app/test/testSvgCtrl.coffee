class TestSvgCtrl
    @$inject = ['$scope']
    constructor: (@$scope)->
        @rects = [
            x: 100
            y: 100
            width: 300
            height: 300
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
            fill: 'green'
        ]
        @handleSize = 10
        @halfHandleSize = @handleSize / 2


angular.module('smazbook').controller 'TestSvgCtrl', TestSvgCtrl
