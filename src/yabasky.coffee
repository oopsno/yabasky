require('colorful').toxic()

pkg = require '../package.json'
u = require 'underscore'
process = require 'process'
minimist = require 'minimist'

###
Version & Usage
###

spaces = (count) ->
  padding = ''
  if not u.isNumber count
    return ''
  while count > 0
    padding += ' '
    count--
  return padding
  
maxKeyLength = (obj) ->
  if not obj
    return 0
  keyLengths = u.mapObject obj, (val, key) -> key.length
  if u.isEmpty keyLengths
    return 0
  else 
    return u.max keyLengths

printCommandOptions = (maxLen, name, desc) ->
  console.log "#{spaces maxLen - name.length + 2}--#{name} => #{desc}"

printCommandUsage = (maxLen, name, detail) ->
  if not detail.description then return
  pad = maxLen - name.length
  console.log "#{spaces pad}#{name} [#{detail.alias}] -- #{detail.description}"
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
  console.error 'No Impl Yet'.bold.red
  
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
    commands[detail.alias] = fn: detail.fn
    
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