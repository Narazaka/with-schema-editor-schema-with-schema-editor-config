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
  read: (file, editor) ->
    @file = file
    jsyaml.safeLoad fs.readFileSync file
  oneditor: (editor) ->
    editor.on 'change', =>
      fs.writeFileSync @file, jsyaml.safeDump editor.getValue()
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
