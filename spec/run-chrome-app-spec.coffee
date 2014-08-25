{WorkspaceView} = require 'atom'
RunChromeApp = require '../lib/run-chrome-app'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "RunChromeApp", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('run-chrome-app')

  describe "when the run-chrome-app:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.run-chrome-app')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'run-chrome-app:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.run-chrome-app')).toExist()
        atom.workspaceView.trigger 'run-chrome-app:toggle'
        expect(atom.workspaceView.find('.run-chrome-app')).not.toExist()
