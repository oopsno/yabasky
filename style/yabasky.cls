\NeedsTeXFormat{LaTeX2e}

% LaTeX3
\RequirePackage{expl3}
\RequirePackage{switch}
\RequirePackage{cover}
\input{yabasky.cfg}
\ProvidesExplClass{yabasky}{2016/3/29}{0.0.2}{YaBAskY Document Class}

% CTeX v2.3
\LoadClass[a4paper,zihao=-4,fontset=adobe]{ctexbook}[2016/02/02]

% 图形文件搜索路径
\graphicspath{{figures/}}

% 纸张设置
\oddsidemargin 1.46 true cm
\evensidemargin -0.54 true cm
\topmargin -0.54 true cm
\headheight 12.9pt
\headsep 17.3527pt
\textheight 24.7 true cm
\textwidth 15 true cm
\footskip 0 cm
\parskip 0.5ex plus 0.25ex minus 0.25ex

% 定义开关
\switch_group_new:nn { compile }           { 编译选项 }
\switch_new:nnn      { compile } { debug } { 调试模式 }
\switch_new:nnn      { compile } { SHTF  } { 盲审模式 }

% 标题设置
\NewDocumentCommand \SetCompileOptions { m }
  { \switch_group_set:nn { compile } { #1 } }

\NewDocumentCommand \SetCoverItems { m }
  { \cover_set:n { #1 } }

\RenewDocumentCommand \maketitle { }
  { \cover_make: }

% 打印调试信息
\NewDocumentCommand \MakeDebugPage { }
  {
    \switch_if:nnTF { compile } { debug }
      {
        \msg_term:n { 正在以调试模式编译 }
        \chapter { 调试信息 }
        \switch_debuginfo:
        \cover_debuginfo:
      }
      {
        \msg_term:n { 正在以发布模式编译 }
      }
  }