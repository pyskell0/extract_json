_ = require('underscore')
print = console.log

extract = (source, path) ->
    path_parts = path.split('.')

    recursive_extract = (source, path_parts) ->
        if path_parts.length == 0 and _.isNumber(source) or _.isString(source) or _.isBoolean(source)
            return source
        else if path_parts.length == 0 or not source?
            return null
        else
            part = source[path_parts[0]]
            result = {}
            if _.isArray(part)
                result[path_parts[0]] = _.map(part, (elem) ->
                    recursive_extract(elem, path_parts[1..])
                )
            else
                result[path_parts[0]] = recursive_extract(part, path_parts[1..])
            return result

    recursive_extract(source, path_parts)

extract_value = (source, path) ->
    path_parts = path.split('.')

    recursive_extract = (source, path_parts) ->
        if path_parts.length == 0 and _.isNumber(source) or _.isString(source) or _.isBoolean(source)
            return source
        else if path_parts.length == 0 or not source?
            return null
        else
            part = source[path_parts[0]]
            if _.isArray(part)
                return _.map(part, (elem) ->
                    recursive_extract(elem, path_parts[1..])
                )
            else
                return recursive_extract(part, path_parts[1..])

    recursive_extract(source, path_parts)

print extract({'name':{'first':'xl', 'last': 'wang'}, mate:[{'name':'zhanglei'}, {name:'luozheng'}]}, 'name.first')
print extract_value({'name':{'first':'xl', 'last': 'wang'}, mate:[{'name':'zhanglei'}, {name:'luozheng'}]}, 'name.first')

print()

print extract({'name':{'first':'xl', 'last': 'wang'}, mate:[{'name':'zhanglei'}, {name:'luozheng'}]}, 'mate.name')
print extract_value({'name':{'first':'xl', 'last': 'wang'}, mate:[{'name':'zhanglei'}, {name:'luozheng'}]}, 'mate.name')

