# YaBAskY

> Yet Another BAchelor thesiS Kit, YaBAskY

## TODO

- [ ] :beer:CLI
- [ ] :beer:样式定制
- [ ] Kramdown集成
- [ ] Pandoc集成
- [ ] PhantomJS集成
- [ ] and so on...

## 宏包

yabasky将拥有一个以[xdlinux/xdba-thesis][xdba]为蓝本打造的一个尽可能轻巧的宏包,
施以若干微调以期使之脱离CTeX软件包, 而仅依赖于[CTeX-org/ctex-kit][ctex-kit].

YaBAskY基本上没办法与XDBA-thesis兼容, CTeX软件包用户请往[xdlinux/xdba-thesis][xdba].

开发&测试环境
+ TexLive  2015
+ ctex-kit 2.3
+ OS X 10.11.3
+ ArchLinux

如果你只是想淡淡地写完了事, 那么到这里故事已经结束了;
直接使用`style/`里的`.cls`和`.cfg`就好;
但如果你比平均水平更懒(zuo), 那么, yabasky还包括了一些可能有用的工具. (万物基于Node.js)

## kit

### 配置

你可以使用一个`thesis.yaml`文件来配置构建

```yaml
# 骨架文件, 充满了定义和include的那个
skeleton: thesis.tex

# TeX
tex: xelatex

# 编译次数, 某些奇怪的包可能需要多次编译呢
times: 1

# 渲染引擎: Pandoc, 或者一个函数, compile(srcPath, destPath, callback)
# callback(err, success), 其中success是一个标示处理是否成功的Boolean
engine: Pandoc

# Markdown风格, Origin | GFM | Pandoc
markdown: GFM

# Pandoc
pandoc:
  # 命令行, 或者null(可省略) 或者一个函数 hock(callback), callback同上
  hock:
    setup:
    atfer:
  outdir: . # 输出目录
  files:
    abs.tex: abs.md
    ch0.tex: ch0.tex
    ch1.tex: ch1.html

# PhantomJS
phantom:
  hock:
    setup:
    after:
  outdir: figure # 输出目录
  files:
    - name: login.pdf
      href: http://localhost:8080/login
      selector: '#id' # CSS selector
    - name: logout.png
      href: http://localhost:8080/logout
      selector: .klass # CSS selector
    - name: seq_init.png
      href: ./seq/init.html
      selector: body #0 CSS selector

# 后续处理,命令行, 命令行, 或者null(可省略) 或者一个函数 hock(callback), callback同上
script:
```

## License

既然用了`xdba-thesis` 就只能 GNU LGPL 了呢...我感受到了来自大胡子叔叔的recurse...

[xdba]: https://github.com/xdlinux/xdba-thesis
[ctex-kit]: https://github.com/CTeX-org/ctex-kit
