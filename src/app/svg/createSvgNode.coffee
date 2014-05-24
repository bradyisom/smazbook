angular.module('smazbook')
.value('createSVGNode', (name, element, settings) ->
    namespace = 'http://www.w3.org/2000/svg'
    node = document.createElementNS(namespace, name)
    for attribute,value of settings
        if (value != null && !attribute.match(/\$/) && (typeof value != 'string' || value != ''))
            node.setAttribute(attribute, value)

    angular.element(node).append(element[0].childNodes)
    element.replaceWith(node)

    node
)
