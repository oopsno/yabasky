# YaBAskY

> Yet Another BAchelor thesiS Kit, YaBAskY 为了更好的排版体验

YaBAskY是专为西安电子科技大学准备的论文排版解决方案，
旨在同时为LaTeX和Word用户提供更佳的排版体验。

## TODO

- [x] 文档类[oopsno/XDUThesis][cls]
- [ ] Word排版辅助

## LaTeX

yabasky包含一个以[xdlinux/xdba-thesis][xdba]为蓝本打造的一个尽可能轻巧的宏包，YaBAskY基本上没办法与XDBA-thesis兼容，稍早版本的CTeX发行版用户请往[xdlinux/xdba-thesis][xdba]。

开发&测试环境

+ TexLive  2015
+ ctex-kit 2.3
+ OS X 10.11.3
+ ArchLinux

## Word 2016

COMMING SOON...

## 致谢

感谢Github上的众多项目，为YaBAskY的实现提供了极大的帮助，特别是：

### LaTeX文档类部分

+ 强大的CTeX宏集[TeX-org/ctex-kit][ctex-kit]
+ 封面部分引用了[xdlinux/xdba-thesis][xdba]提供的EPS格式的校徽校标和测量数据
+ 参考文献格式设置直接使用了[Haixing-Hu/GBT7714-2005-BibTeX-Style][gbt]项目

## License

既然用了`xdba-thesis` 就只能 GNU LGPL 了呢...我感受到了来自大胡子叔叔的recurse...

[xdba]: https://github.com/xdlinux/xdba-thesis
[cls]: https://github.com/oopsno/XDUThesis
[ctex-kit]: https://github.com/CTeX-org/ctex-kit
[gbt]: https://github.com/Haixing-Hu/GBT7714-2005-BibTeX-Style
