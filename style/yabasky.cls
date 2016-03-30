\NeedsTeXFormat{LaTeX2e}

% LaTeX3
\RequirePackage{expl3}
\RequirePackage{switch}
\RequirePackage{cover}
\input{yabasky.cfg}
\ProvidesExplClass{yabasky}{2016/3/29}{0.0.2}{YaBAskY Document Class}

% CTeX v2.3
\LoadClass[a4paper,zihao=-4,fontset=adobe]{ctexbook}[2016/02/02]

% 纸张设置
\RequirePackage[
  top=3cm,
  bottom=2cm,
  left=3cm,
  right=2cm
]{geometry}

% 图形文件搜索路径
\graphicspath{{figures/}}

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