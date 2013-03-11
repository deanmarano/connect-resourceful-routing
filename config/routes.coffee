Application = require '../routing'

Application.routes.draw ->
  @resources 'posts', ->
    @member ->
      @get 'upvote'
    @resources 'replies', ->
      @resources 'users'
  @root
    to: 'posts#index'

module.exports = Application
