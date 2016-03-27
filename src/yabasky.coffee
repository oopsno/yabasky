require('colorful').toxic()

pkg = require '../package.json'
u = require 'underscore'
process = require 'process'
minimist = require 'minimist'

spaces = (count) ->
  padding = ''
  while count
    padding += ' '
    count--
  return padding
  
maxKeyLength = (obj) -> u.max(u.map(u.keys(obj), (s) -> s.length))

printCommandOptions = (maxLen, name, desc) ->
  console.log "  #{name} => #{desc}"

printCommandUsage = (maxLen, name, detail) ->
  if not detail.description then return
  pad = maxLen - name.length
  console.log "#{name} [#{detail.alias}]#{spaces pad} -- #{detail.description}"
  if detail.options
    maxOptLen = maxKeyLength(detail.options)
    printCommandOptions maxOptLen, name, desc for name, desc of detail.options
    
fnUsage = ->
  maxLen = maxKeyLength commands
  console.log "#{pkg.name} #{pkg.version}\n\nUsage:\n"
  printCommandUsage maxLen, cmd, detail for cmd, detail of commands
  
fnClean = ->
  console.log "Cleaning $PWD (#{process.cwd()})...".green
  console.error 'No Impl Yet'.bold.red
  
fnBuild = (opts) ->
  console.log 'Building current thesis...'.green
  if opts.shtf
    console.log 'Building in SHTF mode'.blink.bold.yellow
  console.error 'No Impl Yet'.bold.red

commands =
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

parseArguments = ->
  minimist process.argv[2..], boolean: yes

main = ->
  argv = parseArguments()
  cmd = argv._[0]
  fn = (commands[cmd] || commands.usage).fn
  fn argv
  
exports.main = main
  
