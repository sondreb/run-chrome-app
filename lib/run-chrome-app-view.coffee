{View} = require 'atom'



module.exports =
class RunChromeAppView extends View
  @content: ->
    @div class: 'run-chrome-app overlay from-top', =>
      @div "Run Chrome App allows you to run directly from Atom Editor.", class: "message"

  initialize: (serializeState) ->

    console.log "run-chrome-app: initialize"

    atom.workspaceView.command "run-chrome-app:run", => @run()
    atom.workspaceView.command "run-chrome-app:open", => @open()
    atom.workspaceView.command "run-chrome-app:toggle", => @toggle()
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  open: ->
    console.log "Chrome App: Open Manifest Executed"

    exec = require('child_process').execFile

    if atom.project.getPath()?
        PathLoader = require './path-loader'
        @loadPathsTask = PathLoader.startTask (paths) =>
          @projectPaths = paths

          if (@projectPaths.length == 0)
            console.debug "Found no manifest.json"
          else
            # In the future, we could add a dialog and let the user pick the correct manifest.json file,
            # and that file could become the "default" until another one is right-clicked and selected
            # as the startup-manifest.
            path = @projectPaths[0]

            # Open the manifest file in the editor.
            atom.workspace.open path

  run: ->
    console.log "Chrome App: Run Command Executed"

    #  '.*/[^/]*love[^/]*$'
    #  ".*\.\(json\)"

    exec = require('child_process').execFile

    if atom.project.getPath()?
        PathLoader = require './path-loader'
        @loadPathsTask = PathLoader.startTask (paths) =>
          @projectPaths = paths

          if (@projectPaths.length == 0)
            console.debug "Found no manifest.json"
          else
            #console.dir @projectPaths

            # In the future, we could add a dialog and let the user pick the correct manifest.json file,
            # and that file could become the "default" until another one is right-clicked and selected
            # as the startup-manifest.
            path = @projectPaths[0]

            # Currently only supports Windows.
            if process.platform is 'win32'

              # HACK: We should do proper file handling, quick-fix:
              path = path.replace "manifest.json", ""

              # Path to the Chrome.exe, this varies depending on OS and other factors.
              # FIX: Find a good way to find the right path.
              chromePath = process.env['LOCALAPPDATA'] + '\\Google\\Chrome SxS\\Application\\chrome.exe'

              # Execute the Chrome.exe with the launch command of the path where we found the manifest.json.
              exec chromePath , ['--load-and-launch-app=' + path]

              console.debug chromePath + ", ['--load-and-launch-app=" + path + "']"

              #exec "C:\\Temp\\Data.pptx"
              #exec 'C:\\Program Files\\Internet Explorer\\iexplore.exe'
              # --load-and-launch-app=/path/to/app/
              #exec '%LOCALAPPDATA%\\Google\\Chrome SxS\\Application\\chrome.exe'
              #exec 'C:\\Users\\Sondre\\AppData\\Local\\Google\\Chrome SxS\\Application\\chrome.exe', ['--load-and-launch-app=C:\\Users\\Sondre\\Documents\\GitHub\\Downloadr\\app']
              #console.log 'C:\\Users\\Sondre\\AppData\\Local\\Google\\Chrome SxS\\Application\\chrome.exe'
              #process.execPath

  toggle: ->
    console.log "RunChromeAppView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
