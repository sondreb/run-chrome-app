{Task} = require 'atom'

module.exports =
  startTask: (callback) ->
    projectPaths = []
    taskPath = require.resolve('./load-paths-handler')
    traverseIntoSymlinkDirectories = atom.config.get 'fuzzy-finder.traverseIntoSymlinkDirectories'
    ignoredNames = atom.config.get('fuzzy-finder.ignoredNames') ? []
    ignoredNames = ignoredNames.concat(atom.config.get('core.ignoredNames') ? [])
    ignoreVcsIgnores = atom.config.get('core.excludeVcsIgnoredPaths') and atom.project?.getRepo()?.isProjectAtRoot()

    task = Task.once taskPath, atom.project.getPath(), traverseIntoSymlinkDirectories, ignoreVcsIgnores, ignoredNames, ->
      callback(projectPaths)

    task.on 'load-paths:paths-found', (paths) ->

      for filename in paths
        do (filename) ->
          if (filename.indexOf('manifest.json') > -1)
            console.log "Found a manifest.json"
            projectPaths.push(filename)

      #console.dir paths
      #projectPaths.push(paths...)

    task
