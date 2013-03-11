class Route
  constructor: (options)->
    @method = options.method
    @path = options.path
    @controller = options.controller
    @action = options.action
    @makeRegex()

  makeRegex: ->

    idsRegex = /(:[a-zA-Z0-9-_]*[iI]d)/g
    @params = @path.match(idsRegex) || []
    @pathRegexStr = @path
    if @params.length > 0
      @pathRegexStr = @pathRegexStr.replace(idsRegex, "([a-zA-Z0-9-_]+)")

    # Make all slashes regex friendly
    @pathRegexStr = "^#{@pathRegexStr.replace(new RegExp('\/', 'g'), '\\/')}\\/?$"
    @pathRegex = new RegExp @pathRegexStr

  matches: (path, method) ->
    path.match(@pathRegex) && @method == method

  paramsHash: (url) ->
    matches = url.pathname.match(@pathRegex).slice(1) || []
    params = {}
    for i in [0...@params.length]
      params[@params[i].replace(':', '')] = matches[i]
    params

  toString: (max = 50)->
    methodPad = Array(8 - @method.length).join(" ")
    pathPad = Array(max - @path.length + 1).join(" ")
    "#{@method}#{methodPad} #{@path}#{pathPad} to: #{@controller}##{@action}"

module.exports = Route
