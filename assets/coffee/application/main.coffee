#
#     main.js.coffee
#

# load modules
requirejs(
  [
    "application/routers/application_router"
    "backbone"
    "bootstrap"
  ]
  (
    ApplicationRouter
    Backbone
  )->
    router = new ApplicationRouter
    Backbone.history.start
      pushState: true
)

