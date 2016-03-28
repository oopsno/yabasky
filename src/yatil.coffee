# yatil, 讳util
fs = require 'fs'
u = require 'underscore'

# 组装一个包含`max(floor(count), 0)`个空格的字符串
# count不是Number时返回空字符串
#
# @param count [Number] 
# @return [String]
spaces = (count) ->
  padding = ''
  if not u.isNumber count
    return ''
  count = Math.floor count
  while count > 0
    padding += ' '
    count--
  return padding

# 检测文件是否存在
#
# @param path [String] 
# @param flag [Number] 默认fs.F_OK
# @return [Boolean]
exists = (path, flag = fs.F_OK) ->
  try
    fs.accessSync(path, flag)
    return yes
  catch err
    return no
    
exports.exists = exists
exports.spaces = spaces