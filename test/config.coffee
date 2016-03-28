require('blanket')
  pattern: 'lib',
  'data-cover-never': ['test', 'src', 'node_modules']
require('chai').should()

u = require 'underscore'
fs = require 'fs'
os = require 'os'
path = require 'path'
crypto = require 'crypto'
config = require '../lib/config'

tmp = os.tmpdir()
randomBase = path.join(tmp, crypto.randomBytes(16).toString('hex'))

configure = answer: 42
yamlCode = "answer: 42"
jsonCode = JSON.stringify configure
jsCode = "module.exports = #{jsonCode}"
csCode = "module.exports = #{yamlCode}"

caseMap =
  '.js': jsCode
  '.coffee': csCode
  '.yaml': yamlCode
  '.json': jsonCode

describe "yabasky.config", () ->
  before () ->
    u.mapObject caseMap, (src, ext) ->
      fs.writeFileSync(randomBase + ext, src)

  describe "", () ->
    for ext in u.keys(caseMap)
      it "should loads #{ext} files", () ->
        config.loadConfigure(randomBase + ext).should.eql configure

  after () ->
    fs.unlinkSync(randomBase + p) for p in u.keys caseMap
