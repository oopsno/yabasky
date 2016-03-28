require('colorful').toxic()

pkg = require '../package.json'
u = require 'underscore'
fs = require 'fs-extra'
path = require 'path'
yatil = require './yatil'
process = require 'process'
minimist = require 'minimist'

yabaskyRoot = path.resolve __dirname, '..'

###
  Constants
###

defualts =
  config: 'thesis.yaml'
  skeleton: 'skeleton.tex'

###
  Version & Usage
###
maxKeyLength = (obj) ->
  if not obj
    return 0
  keyLengths = u.mapObject obj, (val, key) -> key.length
  if u.isEmpty keyLengths
    return 0
  else
    return u.max keyLengths

printCommandOptions = (maxLen, name, desc) ->
  console.log "#{yatil.spaces maxLen - name.length + 2}--#{name} => #{desc}"

printCommandUsage = (maxLen, name, detail) ->
  if not detail.description then return
  pad = maxLen - name.length
  console.log "#{yatil.spaces pad}#{name} [#{detail.alias}] -- #{detail.description}"
  if detail.options
    printCommandOptions maxLen, name, desc for name, desc of detail.options;

fnUsage = ->
  maxLen = u.max u.mapObject commands, (val, key) ->
    maxOptLen = maxKeyLength val.options
    if key.length > maxOptLen then key.length else maxOptLen
  console.log "#{pkg.name} #{pkg.version}\n\nUsage:\n"
  printCommandUsage maxLen, cmd, detail for cmd, detail of commands

###
  Init
###

fnInit = (opts) ->
  cwd = path.resolve process.cwd()
  templateDir = path.join yabaskyRoot, 'template'
  console.log "Initializing #{cwd}"
  try
    fs.readdirSync(templateDir, encoding: 'utf-8').forEach (file) ->
      console.log "Copying #{file}..."
      target = path.join cwd, file
      if yatil.exists target, fs.F_OK | fs.W_OK
        console.warn "#{file} exists. Terminating...".yellow
        process.exit 255
      fs.copySync(path.join(templateDir, file), path.join(cwd,file))
  catch err
    console.error "Error occurred".red.bold
    console.error err

###
  Clean
###

fnClean = ->
  console.log "Cleaning $PWD (#{process.cwd()})...".green
  console.error 'No Impl Yet'.bold.red

###
  Build
###

fnBuild = (opts) ->
  console.log 'Building current thesis...'.green
  if opts.shtf
    console.log 'Building in SHTF mode'.blink.bold.yellow
  console.error 'No Impl Yet'.bold.red

###
  Command list
###

commands =
  init:
    fn: fnInit
    alias: 'n'
    description: "create a empty thesis"
  usage:
    fn: fnUsage
    alias: 'h'
    description: "print this usage message"
  build:
    fn: fnBuild
    alias: 'm'
    description: "build current thesis"
    options:
      shtf: 'set to build for ' + 'blind trial'.bold.white
  clean:
    fn: fnClean
    alias: 'c'
    description: "do clean up"

u.mapObject commands, (detail) ->
  if detail.alias
    commands[detail.alias] =
      fn: detail.fn

###
  Command-line arguments processing
###

parseArguments = ->
  minimist process.argv[2..], boolean: yes


###
  entry
###

main = ->
  argv = parseArguments()
  cmd = argv._[0]
  fn = (commands[cmd] || commands.usage).fn
  fn argv

exports.main = main