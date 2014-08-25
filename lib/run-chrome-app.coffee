RunChromeAppView = require './run-chrome-app-view'

module.exports =
  runChromeAppView: null

  activate: (state) ->

    console.log 'Creating Chrome App Instance...'

    @runChromeAppView = new RunChromeAppView(state.runChromeAppViewState)

  deactivate: ->
    @runChromeAppView.destroy()

  serialize: ->
    runChromeAppViewState: @runChromeAppView.serialize()
