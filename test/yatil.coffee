require('blanket')
  pattern: 'lib',
  'data-cover-never': ['test', 'src', 'node_modules']
require('chai').should()

fs = require 'fs-extra'
os = require 'os'
crypto = require 'crypto'
path = require 'path'
yatil = require '../lib/yatil'

describe "yabasky.yatil", () ->
  describe "spaces", () ->
    testOn = (count, expectedLength = Math.max(0, Math.floor(count))) ->
      padding = yatil.spaces count
      padding.length.should.equal expectedLength
      if expectedLength > 0
        for i in [0..expectedLength - 1]
          padding.charAt(i).should.equal ' '
    it "should return correct result on valid arguments", () ->
      testOn 42
      testOn 4.2

    it "should return empty string on strange values", () ->
      testOn -7, 0
      testOn null, 0
      testOn undefined, 0
      testOn "42", 0

  describe "exists", () ->
    tmp = os.tmpdir()
    genRandomPath = (len) ->
      path.join tmp, crypto.randomBytes(len).toString('hex')
    writeFiles = (paths) -> fs.writeFileSync p, p for p in paths
    removeFiles = (paths) -> fs.removeSync for p in paths

    it "should return 'yes' on existing paths", () ->
      doTest = (p) -> yatil.exists(p).should.equal yes, "#{p} exists"

      randomPaths = (genRandomPath 16 for i in [1..16])
      writeFiles randomPaths
      doTest for p in randomPaths
      removeFiles randomPaths

    it "should return 'no' on not existing paths", () ->
      doTest = (p) -> yatil.exists(p).should.equal no, "#{p} not exists"
        
      randomPaths = (genRandomPath 16 for i in [1..16])
      doTest for p in  randomPaths
