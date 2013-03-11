String.prototype.pluralize = ->
  if @charAt(@length - 1) != 's'
    @ + 's'
  else
    @

String.prototype.singularize = ->
  if @.match /ies$/
    @replace('ies', 'y')
  else if @charAt(@length - 1) == 's'
    @substring(0, @length - 1)
  else
    @
