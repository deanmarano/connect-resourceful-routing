# Connect Resourceful Routing

Like Rails routing? Like Node more? You're finally in luck. This is a
[Connect]( http://www.senchalabs.org/connect/ ) middleware that allows you to use
Rails-style routing in Node. It's preferably written in Coffeescript to get the
full effect (you're not always writing in Coffee???).

If you're not familiar with how Rails routing works, the best documentation can be found [here]( http://guides.rubyonrails.org/routing.html ).


To use:

1. Add to your package.json dependencies. `"connect-resourceful-routing": "*"`
2. Install dependences `npm install`
3. In any Connect-based app (Express.js, Connect.js, etc) simply use this as a middleware.

```coffeescript
connect = require 'connect'
router = require 'connect-resourceful-routing'

app = connect()
  .use router
    file: 'config/routes' # Optional - will look for config/routes.{coffee/js} by default.
    handle404s: true # Optional - if you want your routes file to be the end of the chain, use this.
    # If you do use this, make sure you put this as the LAST middleware.
    # Otherwise it will eat things like static assets and any other middleware.
  .listen(3000)
```

Example usage:

```ruby
Blog::Application.routes.draw do
  resources :posts do
    member do
      put 'upvote'
    end
    resources :comments
  end

  root :to => 'posts#index'
end
```

becomes


```coffeescript

Application = require '../routing'

Application.routes.draw ->
  @resources 'posts', ->
    @member ->
      @put 'upvote'
    @resources 'comments'
  @root
    to: 'posts#index'

module.exports = Application
```

which will then be sent to

'app/controllers/{resourceName}Controller'


What's working so far -

* Resources
* Singular Resources
* Nested Resources
* Collections
* Members
* Root

Routes will print out at the beginning of every server run.

The above example generates the following routes:

```
get     /                                to: posts#index
PUT     /posts/:id/upvote                to: posts#upvote
GET     /posts/new                       to: posts#new
POST    /posts                           to: posts#create
GET     /posts/:id                       to: posts#show
GET     /posts/:id/edit                  to: posts#edit
PUT     /posts/:id                       to: posts#update
DELETE  /posts/:id                       to: posts#destroy
GET     /posts                           to: posts#index
GET     /posts/:postId/comments/new      to: comments#new
POST    /posts/:postId/comments          to: comments#create
GET     /posts/:postId/comments/:id      to: comments#show
GET     /posts/:postId/comments/:id/edit to: comments#edit
PUT     /posts/:postId/comments/:id      to: comments#update
DELETE  /posts/:postId/comments/:id      to: comments#destroy
GET     /posts/:postId/comments          to: comments#index
```
