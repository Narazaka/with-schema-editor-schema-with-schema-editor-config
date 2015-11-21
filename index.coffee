fs = require 'fs'
jsyaml = require 'js-yaml'

module.exports =
  name: 'WithSchemaEditor config schema plugin'
  read_type: 'file'
  filters: ->
    [
      {name: 'JSON/YAML', extensions: ['json', 'yaml', 'yml']}
      {name: 'すべてのファイル', extensions: ['*']}
    ]
  load: (app) ->
    app.editor().setValue jsyaml.safeLoad fs.readFileSync app.target()
  save: (app) ->
    fs.writeFileSync app.target(), jsyaml.safeDump app.editor().getValue()
  schema: ->
    title: 'config'
    type: 'object'
    format: 'grid'
    properties:
      target:
        title: '対象ファイル/フォルダ'
        type: 'string'
      schema:
        title: 'スキーマプラグイン名'
        type: 'string'
