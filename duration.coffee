Number.prototype.seconds = ->
  @valueOf() * 1000

Number.prototype.minutes = ->
  @valueOf() * (60).seconds()

Number.prototype.hours = ->
  @valueOf() * (60).minutes()

Number.prototype.days = ->
  @valueOf() * (24).hours()

Number.prototype.months = ->
  @valueOf() * (30).days()

Number.prototype.years = ->
  @valueOf() * (365).days()

Number.prototype.ago = ->
  new Date(new Date().valueOf() - @valueOf())

Number.prototype.since = ->
  new Date(new Date().valueOf() + @valueOf())

Number.prototype.second = Number.prototype.seconds
Number.prototype.minute = Number.prototype.minutes
Number.prototype.hour = Number.prototype.hours
Number.prototype.day = Number.prototype.days
Number.prototype.month = Number.prototype.months
Number.prototype.year = Number.prototype.years
Number.prototype.fromNow = Number.prototype.since
