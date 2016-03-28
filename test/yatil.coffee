require('blanket')
  pattern: 'lib',
  'data-cover-never': ['test', 'src', 'node_modules']
require('chai').should()

fs = require 'fs-extra'
os = require 'os'
async = require 'async'
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
    genRandomPath = (callback) ->
      async.map (16 for i in [1..16]), crypto.randomBytes, (err, rbs) ->
        if err
          callback err, null
        paths = rbs.map (bytes) -> path.join(tmp, bytes.toString('hex'))
        callback null, paths
    writeFiles = (paths, callback) ->
      try
        for p in paths
          fs.writeFileSync p, p
        callback null, paths
      catch err
        callback err, null
    cleanup = (paths, callback) ->
      async.map paths, fs.removeSync, (err) ->
        if err then callback err, null
        else callback null, paths
          
    it "should return yes on existing paths", (done) ->
      doTests = (paths, callback) ->
        try
          for p in paths
            yatil.exists(p).should.equal yes, "#{p} exists"
          callback null, null
        catch err
          callback err, err
      async.waterfall [genRandomPath, writeFiles, doTests, cleanup], done
      
    it "should return no on not existing paths", (done) ->
      doTests = (paths, callback) ->
        try
          for p in paths
            yatil.exists(p).should.equal no, "#{p} not exists"
          callback null, null
        catch err
          callback err, err
      async.waterfall [genRandomPath, doTests], done
