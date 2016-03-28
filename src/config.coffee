require 'coffee-script'
fs = require 'fs'
path = require 'path'
yaml = require 'yaml'

###
  读取配置文件
###
  
loadSource = (srcPath) ->
  return require srcPath

loadML = (parser) -> (srcPath) ->
  return parser fs.readFileSync srcPath

extensionMap =
  '.yaml': loadML yaml.eval
  '.json': loadML JSON.parse
  '.js': loadSource
  '.coffee': loadSource

loadConfigure = (srcPath) ->
  return extensionMap[path.extname srcPath] srcPath

exports.loadConfigure = loadConfigure