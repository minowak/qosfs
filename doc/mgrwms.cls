%%====================================================================%
%%                              MgrWMS.cls
%%                         --------------------
%%  Date & ver : 2010/01/03 v1.05
%%  University : AKADEMIA GORNICZO-HUTNICZA W KRAKOWIE
%%               WYDZIAL MATEMATYKI STOSOWANEJ
%%  Author     : Rafa\l{} Czarny
%%--------------------------------------------------------------------%
%%
%% Copyright 2000-2002 by Marcin Woli\'nski <wolinski@gust.org.pl>
%% Copyright 2003-2010 by Rafa\l{} Czarny <rafal_czarny@tlen.pl>
%%--------------------------------------------------------------------%
%%
%% This is file `mgrwms.cls',
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%--------------------------------------------------------------------%
%%
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is Rafa\l{} Czarny.
%%
%% This work consists of all files listed in the file 'ReadMe'.
%%====================================================================%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{mgrwms}
  [2010/01/03 v1.05 Praca magisterska na WMS (AGH, Krakow)]
%
\typeout{=======================================}
\typeout{ AKADEMIA GORNICZO-HUTNICZA W KRAKOWIE }
\typeout{ WYDZIAL MATEMATYKI STOSOWANEJ         }
\typeout{ Class : mgrwms [2010/01/03 v1.05]     }
\typeout{ Author: Rafal Czarny                  }
\typeout{=======================================}
%
\newif\if@restonecol
\newif\if@titlepage\@titlepagetrue
\newif\if@openright\@openrightfalse
\newif\if@mainmatter\@mainmattertrue
\newif\ifHeadingNumbered
\newif\if@authorfirst
\newif\if@wide\@widefalse
\newif\ifMgrWMS@pdftex\MgrWMS@pdftexfalse
\newif\ifMgrWMS@marginpar\MgrWMS@marginparfalse
\newif\ifMgrWMS@smallfont\MgrWMS@smallfontfalse
\newif\ifMgrWMS@draft\MgrWMS@draftfalse
\newif\ifMgrWMS@man\MgrWMS@manfalse
\newif\ifMgrWMS@oldlayout\MgrWMS@oldlayoutfalse
\ifx\l@nohyphenation\@undefined
  \newlanguage\l@nohyphenation
\fi
%
%
% ===============
%   OPCJE KLASY
% ===============
%
\DeclareOption{a4paper}
	{\setlength\paperheight{297mm}%
   \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}
	{\setlength\paperheight{210mm}%
	 \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}
  {\setlength\paperheight{250mm}%
   \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}
  {\setlength\paperheight{11in}%
   \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}
  {\setlength\paperheight {14in}%
   \setlength\paperwidth  {8.5in}}
\DeclareOption{landscape}
  {\setlength\@tempdima{\paperheight}%
   \setlength\paperheight{\paperwidth}%
   \setlength\paperwidth{\@tempdima}}
\DeclareOption{marginpar}{\MgrWMS@marginpartrue}
\DeclareOption{nomarginpar}{\MgrWMS@marginparfalse}
\newcommand\MgrWMS@usedd{%
	\p@=1dd
	\def\@vpt{5dd}%
	\def\@vipt{6dd}%
	\def\@viipt{7dd}%
	\def\@viiipt{8dd}%
	\def\@ixpt{9dd}%
	\def\@xpt{10dd}%
	\def\@xipt{11dd}%
	\def\@xiipt{12dd}%
	\def\@xivpt{14dd}%
	\def\@xviipt{16dd}%
	\def\@xxpt{18dd}%
	\def\@xxvpt{24dd}%
}
\newcommand\@ptsize{2}
\newcommand\MgrWMS@basesize{12}
\newcommand\MgrWMS@sizesymbol{N}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}\renewcommand\MgrWMS@sizesymbol{S}\def\MgrWMS@basesize{10}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}\renewcommand\MgrWMS@sizesymbol{M}\def\MgrWMS@basesize{11}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}\renewcommand\MgrWMS@sizesymbol{N}\def\MgrWMS@basesize{12}}
\DeclareOption{smallsize}{% 10pt
	\renewcommand\@ptsize{0}\def\MgrWMS@basesize{10}\renewcommand\MgrWMS@sizesymbol{S}\MgrWMS@smallfonttrue}
\DeclareOption{normalsize}{% 12pt
	\renewcommand\@ptsize{2}\def\MgrWMS@basesize{12}\renewcommand\MgrWMS@sizesymbol{N}\MgrWMS@smallfontfalse}
\DeclareOption{oneside}{\@twosidefalse\@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue\@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
% Opcje i definicje do tytulariow
% -------------------------------
\newcommand*\wmssectsetup{\bfseries}
\newcommand*\wmscaptionsetup{\small}
\newcommand*\secondarysize{\small}
\DeclareOption{rmheadings}{%
  \def\wmssectsetup{\rmfamily\bfseries}%
}
\DeclareOption{sfheadings}{%
  \def\wmssectsetup{\sffamily\bfseries}%
}
\DeclareOption{floatssmall}{%
  \def\wmsfiguresetup{\small}%
  \def\wmstablesetup{\small}%
}
\DeclareOption{floatsnormalsize}{%
  \def\wmsfiguresetup{\normalsize}%
  \def\wmstablesetup{\normalsize}%
}
\DeclareOption{indentfirst}{\@afterindenttrue}
\DeclareOption{noindentfirst}{\@afterindentfalse}
%
% Opcje i definicje specyficzne dla klasy
% ---------------------------------------
\def\MgrWMS@fomat@output{dvips}
\newif\ifMgrWMS@pdftexexpl\MgrWMS@pdftexexplfalse
\DeclareOption{dvips}{%
	\MgrWMS@pdftexexplfalse\gdef\MgrWMS@fomat@output@expl{X}}
\DeclareOption{pdftex}{%
	\MgrWMS@pdftexexpltrue\gdef\MgrWMS@fomat@output@expl{X}}
\DeclareOption{robocza}{\MgrWMS@drafttrue}
\DeclareOption{woman}{\MgrWMS@manfalse\gdef\MgrWMS@ManWoman@Chck{F}}
\DeclareOption{man}{\MgrWMS@mantrue\gdef\MgrWMS@ManWoman@Chck{M}}
\DeclareOption{sieci}{\gdef\MgrWMS@MathSpecial{SIECI}}
\DeclareOption{bazy}{\gdef\MgrWMS@MathSpecial{BAZY}}
\DeclareOption{oldlayout}{\MgrWMS@oldlayouttrue}
%
\ExecuteOptions{a4paper,oneside,onecolumn,titlepage,%
								final,nomarginpar,indentfirst,floatsnormalsize}
\ProcessOptions
%
% Pakiety
% -------
% Taken from ifpdf.sty (2007/09/09 v1.5, by Heiko Oberdiek)
% Thank you Heiko for this nice package! :)
\ifx\pdfoutput\undefined
	\else
	\ifx\pdfoutput\relax
		\else
		\ifnum\pdfoutput<1
			\MgrWMS@pdftexfalse
		\else
			\MgrWMS@pdftextrue
		\fi
	\fi
\fi
%
\@ifundefined{MgrWMS@fomat@output@expl}{}{%
	\ifMgrWMS@pdftexexpl\MgrWMS@pdftextrue
	\else\MgrWMS@pdftexfalse\fi}%
\ifMgrWMS@pdftex
	\def\MgrWMS@fomat@output{pdftex}
	\ClassInfo{mgrwms}{Kompilacja przy uzyciu pdfLaTeX-a}
\else
	\def\MgrWMS@fomat@output{dvips}
	\ClassInfo{mgrwms}{Kompilacja przy uzyciu LaTeX-a}
\fi
\RequirePackage[unknownkeysallowed]{keyval}
\RequirePackage[\MgrWMS@fomat@output]{graphicx}
\RequirePackage[\MgrWMS@fomat@output]{color}
%
% Dodatkowe definicje
% -------------------
%----- Pomocnicze liczniki i dlugosci -----%
\newcounter{MgrWMS@cnt@a}
\newlength{\MgrWMS@dim@a}
\newlength{\MgrWMS@dim@b}
\newlength{\MgrWMS@dim@c}
\newlength{\MgrWMS@dim@toc}  % dla TOC
\newlength{\MgrWMS@dim@cdbox}% dla Okladki CD
\newbox\MgrWMS@box@a
%
%----- Ostrzezenia i bledy -----%
\newcommand{\MgrWMS@Error}[2]{\ClassError{mgrwms}{#1}{#2}}
\newcommand{\MgrWMS@Warning}[1]{\ClassWarning{mgrwms}{#1}}
\newcommand{\MgrWMS@Info}[1]{\ClassInfo{mgrwms}{#1}}
%----- Linie -----%
\newcommand*{\MgrWMS@GrayLine}[3]{%
	{\definecolor{MgrWMS@grayA}{gray}{#1}{\color{MgrWMS@grayA}\rule{#2}{#3}}}%
}
\def\hrulefillA#1{\leavevmode\leaders\hrule height#1\hfill\kern\z@}
\def\hrulefillGray#1#2{%
	\definecolor{MgrWMS@grayA}{gray}{#1}%
  \leavevmode\leaders{\color{MgrWMS@grayA}\hrule height#2}\hfill\kern\z@
}
%----- Operacje na dlugosciach -----%
\newcommand{\MgrWMS@AddTwoDimOnBoxes}[3]{%
	\setbox\MgrWMS@box@a\hbox{\rule{#1}{1pt}\rule{#2}{1pt}}%
	\expandafter\xdef\csname #3\endcsname{\the\wd\MgrWMS@box@a}%
}
%----- Def4Def -----%
\def\MgrWMSDef#1#2#3{%
	\global\expandafter
	\def\csname #1\endcsname##1{%
		\global\expandafter
		\def\csname #2\endcsname{##1}%
	}\global\expandafter
	\def\csname #2\endcsname{#3}%
}
%----- definicje do KeyVal -----%
% Taken from hyperref.sty (2003/11/30 v6.74m, by Sebastian Rahtz)
% Thank you Sebastian for this nice package! :)
\def\MgrWMS@true{true}
\def\MgrWMS@false{false}
\def\MgrWMS@Expand@Key#1#2#3#4#5{%
	\lowercase{\def\MgrWMS@bool@def{#2}}%
	\lowercase{\def\MgrWMS@bool{#3}}%
	\ifx\MgrWMS@bool\MgrWMS@true
  \else
    \ifx\MgrWMS@bool\MgrWMS@false
    \else
			\MgrWMS@Warning{`#1' should be set to `true' or `false', set to	default: `#2'}%
      \let\MgrWMS@bool\MgrWMS@bool@def
    \fi
  \fi
	\ifx\MgrWMS@bool\MgrWMS@true #4
	  \else
		\ifx\MgrWMS@bool\MgrWMS@false #5
	\else\relax\fi\fi
}
%
\def\MgrWMS@Expand@Key@Boolean#1#2#3#4{%
	\lowercase{\def\MgrWMS@bool@def{#2}}%
	\lowercase{\def\MgrWMS@bool{#3}}%
	\ifx\MgrWMS@bool\MgrWMS@true
  \else
    \ifx\MgrWMS@bool\MgrWMS@false
    \else
			\MgrWMS@Warning{`#1' should be set to `true' or `false', set to	default: `#2'}%
			\let\MgrWMS@bool\MgrWMS@bool@def
    \fi
  \fi
	\csname #4\MgrWMS@bool\endcsname
}
%
\def\MgrWMS@ProcessOptionsWithKV{%
  \let\@tempc\relax
  \let\MgrWMS@tempa\@empty
  \@for\CurrentOption:=\@classoptionslist\do{%
    \@ifundefined{KV@MgrWMS@\CurrentOption}%
    {}%
    {%
      \edef\MgrWMS@tempa{\MgrWMS@tempa,\CurrentOption,}%
      \@expandtwoargs\@removeelement\CurrentOption
        \@unusedoptionlist\@unusedoptionlist
    }%
  }%
  \edef\MgrWMS@tempa{%
    \noexpand\setkeys{MgrWMS}{%
      \MgrWMS@tempa\@ptionlist{\@currname.\@currext}%
    }%
  }%
  \MgrWMS@tempa
}
%
%----- komendy do truncate -----%
% Taken from truncate.sty (ver 3.6, 20-Aug-2001, by Donald Arseneau)
% Thank you Donald for this nice package! :)
\let\MgrWMS@DATrunc@Pre\@empty
\def\MgrWMS@DATrunc@Post{\hyphenpenalty\@M}
\def\MgrWMS@DATrunc@Rebox{%
  \setbox\z@\hbox{\unhbox\z@\unskip\unskip\@tempa}%
  \ifdim\wd\z@>\hsize \hbox to\hsize{\unhbox\z@}\else \box\z@\fi}
\let\MgrWMS@DATrunc@DoSelect\@empty
\newcommand{\MgrWMSTruncate}[3][\,\ldots]{%
  \parbox[b]{#2}{\tolerance9999 \emergencystretch .216\hsize
		\vbadness\maxdimen \vfuzz\vsize
		\hbadness\maxdimen \hfuzz\vsize
		\edef\@tempb{\the\MgrWMS@DATrunc@RestHyph}%
		\global\MgrWMS@DATrunc@RestHyph{}%
		\ifx\MgrWMS@DATrunc@DoSelect\relax
			\let\MgrWMS@DATrunc@DoSelect\selectfont
			\def\selectfont{\MgrWMS@DATrunc@DoSelect\MgrWMS@DATrunc@SaveHChar}%
		\fi
		\MgrWMS@DATrunc@SaveHChar
		\setbox\z@\vbox\bgroup
    \setbox\z@\@@line{\ignorespaces #3\unskip\unskip\hfil}%
    \ifnum\badness>\@M
      \settowidth\rightskip{#1}%
      \advance\rightskip \z@\@plus\p@
      \parfillskip-\@ne\rightskip \@plus\@ne fil
      \parshape \tw@ \z@\hsize \z@\maxdimen \linepenalty60
      \tracinglostchars\z@
      \MgrWMS@DATrunc@Pre
      \noindent \vadjust{\penalty-\@MM}%
      \nobreak\hskip\z@skip
      \ignorespaces #3%
      \pretolerance\hyphenpenalty \MgrWMS@DATrunc@Post
      \@@par
      \ifnum\prevgraf>\@ne
				\egroup \def\@tempa{#1}%
      \else
				\egroup \let\@tempa\@empty%
      \fi
    \else
      \box\z@ \egroup \let\@tempa\@empty%
    \fi
		\setbox\@tempboxa\vsplit\z@ to\z@ \unvbox\@tempboxa
		\unskip\unpenalty\unpenalty
		\setbox\z@\lastbox
		\nointerlineskip
		\hfuzz\p@
		\MgrWMS@DATrunc@Rebox
		\let\MgrWMS@DATrunc@HC\@firstofone \the\MgrWMS@DATrunc@RestHyph
		\global\MgrWMS@DATrunc@RestHyph\expandafter{\@tempb}%
}}%
\newtoks\MgrWMS@DATrunc@RestHyph
\global\MgrWMS@DATrunc@RestHyph{}
\def\MgrWMS@DATrunc@SaveHChar{%
	\begingroup
  \edef\@tempa{%
    \hyphenchar\the\font=\noexpand\MgrWMS@DATrunc@HC{\the\hyphenchar\font}\relax
    \the\MgrWMS@DATrunc@RestHyph}%
  \global\MgrWMS@DATrunc@RestHyph\expandafter{\@tempa}%
  \endgroup
}
\def\MgrWMS@DATrunc@HC#1{%
  \@ifundefined{\f@encoding\string\textcompwordmark}{%
    \@ifundefined{\string\MgrWMS@DATruncHyph\f@encoding}%
			{32}%
			{\csname \string\MgrWMS@DATruncHyph\f@encoding\endcsname}%
  }{\csname\f@encoding\string\textcompwordmark\endcsname}%
}
%----- polecenie do niezerowania danego licznika wraz z innym -----%
% Taken from remreset.sty (1997/09/28, by David Carlisle)
% Thank you David for this nice package! :)
% #1 - jaki licznik bedzie zerowany, #2 - jaki byl nadrzedny
\def\MgrMWS@RemoveFromReset#1#2{{%
	\expandafter\let\csname c@#1\endcsname\MgrMWS@RemoveFromReset
	\def\MgrMWS@elt##1{%
		\expandafter\ifx\csname c@##1\endcsname\MgrMWS@RemoveFromReset
		\else
			\noexpand\MgrMWS@elt{##1}%
    \fi}%
  \expandafter\xdef\csname cl@#2\endcsname{%
    \csname cl@#2\endcsname}}%
}
%
%----- polskie literki -----%
\def\MgrWMS@PLlet@def#1#2{%
  \expandafter\def \csname PL@\string #1\endcsname{#2}}
\MgrWMS@PLlet@def{A}{\char129}\MgrWMS@PLlet@def{a}{\char161}
\MgrWMS@PLlet@def{C}{\char130}\MgrWMS@PLlet@def{c}{\char162}
\MgrWMS@PLlet@def{E}{\char134}\MgrWMS@PLlet@def{e}{\char166}
\MgrWMS@PLlet@def{L}{\char138}\MgrWMS@PLlet@def{l}{\char170}
\MgrWMS@PLlet@def{N}{\char139}\MgrWMS@PLlet@def{n}{\char171}
\MgrWMS@PLlet@def{O}{\char211}\MgrWMS@PLlet@def{o}{\char243}
\MgrWMS@PLlet@def{S}{\char145}\MgrWMS@PLlet@def{s}{\char177}
\MgrWMS@PLlet@def{X}{\char153}\MgrWMS@PLlet@def{x}{\char185}
\MgrWMS@PLlet@def{Z}{\char155}\MgrWMS@PLlet@def{z}{\char187}
%
%----- pojedyncza interlinia -----%
% Taken from setspace.sty (2000/12/01 v6.7, by Geoffrey Tobin)
% Thank you Geoffrey for this nice package! :)
\newcommand{\MgrWMS@SingleSpacing}{%
  \def\baselinestretch{1}%
  \@currsize
}
%
%
% ==============================================
%   WIELKOSC CZCIONKI PODSTAWOWEJ - USTAWIENIA
% ==============================================
%
\newcommand\small{\@empty}
\newcommand\footnotesize{\@empty}
\newcommand\scriptsize{\@empty}
\newcommand\tiny{\@empty}
\newcommand\large{\@empty}
\newcommand\Large{\@empty}
\newcommand\LARGE{\@empty}
\newcommand\huge{\@empty}
\newcommand\Huge{\@empty}
%
% 10pt (SmallSize)
% ----------------
\newcommand{\MgrWMS@SizeDef@S}{%
\renewcommand\normalsize{%
  \@setfontsize\normalsize\@xpt\@xiipt
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
}%
\normalsize
\renewcommand\small{%
  \@setfontsize\small\@ixpt{11}%
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \belowdisplayskip \abovedisplayskip
}%
\renewcommand\footnotesize{%
  \@setfontsize\footnotesize\@viiipt{9.5}%
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \belowdisplayskip \abovedisplayskip
}%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}%
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}%
\renewcommand\large{\@setfontsize\large\@xiipt{14}}%
\renewcommand\Large{\@setfontsize\Large\@xivpt{18}}%
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{22}}%
\renewcommand\huge{\@setfontsize\huge\@xxpt{25}}%
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}%
\setlength\smallskipamount{.25\baselineskip \@plus.125\baselineskip
  \@minus.0625\baselineskip}%
\setlength\medskipamount{.5\baselineskip \@plus.25\baselineskip
  \@minus.125\baselineskip}%
\setlength\bigskipamount{1\baselineskip \@plus.5\baselineskip
  \@minus.25\baselineskip}%
%
\setlength\footnotesep{6.65\p@}%
\setlength{\skip\footins}{9\p@ \@plus 4\p@ \@minus 2\p@}%
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\@fptop{0\p@ \@plus 1fil}%
\setlength\@fpsep{8\p@ \@plus 2fil}%
\setlength\@fpbot{0\p@ \@plus 1fil}%
\setlength\@dblfptop{0\p@ \@plus 1fil}%
\setlength\@dblfpsep{8\p@ \@plus 2fil}%
\setlength\@dblfpbot{0\p@ \@plus 1fil}%
}
%
% 11pt (MediumSize)
% -----------------
\newcommand{\MgrWMS@SizeDef@M}{%
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xipt{13.6}%
   \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
}%
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
}%
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@ixpt{11}%
   \abovedisplayskip 8\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \belowdisplayskip \abovedisplayskip
}%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}%
\renewcommand\tiny{\@setfontsize\tiny\@vipt\@viipt}%
\renewcommand\large{\@setfontsize\large\@xiipt{14}}%
\renewcommand\Large{\@setfontsize\Large\@xivpt{18}}%
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{22}}%
\renewcommand\huge{\@setfontsize\huge\@xxpt{25}}%
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}%
\setlength\smallskipamount{.25\baselineskip \@plus.125\baselineskip
        \@minus.0625\baselineskip}%
\setlength\medskipamount{.5\baselineskip \@plus.25\baselineskip
        \@minus.125\baselineskip}%
\setlength\bigskipamount{1\baselineskip \@plus.5\baselineskip
        \@minus.25\baselineskip}%
%
\setlength\footnotesep{7.7\p@}%
\setlength{\skip\footins}{10\p@ \@plus 4\p@ \@minus 2\p@}%
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}%
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\@fptop{0\p@ \@plus 1fil}%
\setlength\@fpsep{8\p@ \@plus 2fil}%
\setlength\@fpbot{0\p@ \@plus 1fil}%
\setlength\@dblfptop{0\p@ \@plus 1fil}%
\setlength\@dblfpsep{8\p@ \@plus 2fil}%
\setlength\@dblfpbot{0\p@ \@plus 1fil}%
}
%
% 12pt (NormalSize)
% -----------------
\newcommand{\MgrWMS@SizeDef@N}{%
\renewcommand\normalsize{%
  \@setfontsize\normalsize\@xiipt{14.5}%
  \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
}%
\normalsize
\renewcommand\small{%
  \@setfontsize\small\@xipt{13.6}%
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
}%
\renewcommand\footnotesize{%
  \@setfontsize\footnotesize\@xpt\@xiipt
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
}%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}%
\renewcommand\tiny{\@setfontsize\tiny\@vipt\@viipt}%
\renewcommand\large{\@setfontsize\large\@xivpt{18}}%
\renewcommand\Large{\@setfontsize\Large\@xviipt{22}}%
\renewcommand\LARGE{\@setfontsize\LARGE\@xxpt{25}}%
\renewcommand\huge{\@setfontsize\huge\@xxvpt{30}}%
\let\Huge=\huge
\setlength\smallskipamount{.25\baselineskip \@plus.125\baselineskip
	\@minus.0625\baselineskip}%
\setlength\medskipamount{.5\baselineskip \@plus.25\baselineskip
	\@minus.125\baselineskip}%
\setlength\bigskipamount{1\baselineskip \@plus.5\baselineskip
  \@minus.25\baselineskip}%
%
\setlength\footnotesep{8.4\p@}%
\setlength{\skip\footins}{10.8\p@ \@plus 4\p@ \@minus 2\p@}%
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\intextsep   {14\p@ \@plus 4\p@ \@minus 4\p@}%
\setlength\dblfloatsep    {14\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}%
\setlength\@fptop{0\p@ \@plus 1fil}%
\setlength\@fpsep{10\p@ \@plus 2fil}%
\setlength\@fpbot{0\p@ \@plus 1fil}%
\setlength\@dblfptop{0\p@ \@plus 1fil}%
\setlength\@dblfpsep{10\p@ \@plus 2fil}%
\setlength\@dblfpbot{0\p@ \@plus 1fil}%
}
\csname MgrWMS@SizeDef@\MgrWMS@sizesymbol\endcsname
\normalsize
%
%
% ===========================
%   CZESC DO PAKIETU KEYVAL
% ===========================
%
% Marginesy
% ---------
\newlength{\MgrWMSleft}\newlength{\MgrWMSright}
\newlength{\MgrWMStop}\newlength{\MgrWMSbottom}
\setlength{\MgrWMSleft}{3.2cm}
\setlength{\MgrWMSright}{2.5cm}
\setlength{\MgrWMStop}{1.75cm}
\setlength{\MgrWMSbottom}{2.2cm}
\def\MgrWMS@AddToHeadHeight{0pt}
\def\MgrWMS@AddToHeadSep{0pt}
\def\MgrWMS@AddToFootSkip{0pt}
%
\define@key{MgrWMS}{wmsleftmargin}{\setlength{\MgrWMSleft}{#1}}
\define@key{MgrWMS}{wmsrightmargin}{\setlength{\MgrWMSright}{#1}}
\define@key{MgrWMS}{wmslrmargins}{\setlength{\MgrWMSleft}{#1}\setlength{\MgrWMSright}{#1}}
\define@key{MgrWMS}{wmstopmargin}{\setlength{\MgrWMStop}{#1}}
\define@key{MgrWMS}{wmsbottommargin}{\setlength{\MgrWMSbottom}{#1}}
\define@key{MgrWMS}{wmstbmargins}{\setlength{\MgrWMStop}{#1}\setlength{\MgrWMSbottom}{#1}}
\define@key{MgrWMS}{wmsaddtoheadheight}{\def\MgrWMS@AddToHeadHeight{#1}}
\define@key{MgrWMS}{wmsaddtoheadsep}{\def\MgrWMS@AddToHeadSep{#1}}
\define@key{MgrWMS}{wmsaddtofootskip}{\def\MgrWMS@AddToFootSkip{#1}}
%
% Pagina
% ------
\newif\ifMgrWMS@grayline\MgrWMS@graylinefalse
\newif\ifMgrWMS@headtruncate\MgrWMS@headtruncatetrue
\newif\ifMgrWMS@closingfoot\MgrWMS@closingfootfalse
\newif\ifMgrWMS@draftframe\MgrWMS@draftframetrue
\newif\ifMgrWMS@draftauthor\MgrWMS@draftauthorfalse
\newlength{\MgrWMS@HeadToLine}
\newlength{\MgrWMS@LineHeight}
\setlength{\MgrWMS@HeadToLine}{2.5pt}
\setlength{\MgrWMS@LineHeight}{0.5pt}
\def\MgrWMS@HeadStyle{\small\slshape}
\def\MgrWMS@PageNumberStyle{\normalsize}
\def\MgrWMS@DraftFootStyle{\ttfamily\small}
\def\MgrWMS@MyHeaderTextStyle{\rmfamily\small}
\def\MgrWMS@MyHeaderText{\@empty}
\def\MgrWMS@GrayLineColor{0.7}
\def\MgrWMS@HeadTruncateSize{0.75}
% symbole dla paginy - HeadLeft, HeadCenter itp. (strony nieparzyste)
% oraz domyslne elementy dla elementow paginy
\def\MgrWMS@HFPos@HL{a}\def\MgrWMS@HFPos@HC{b}\def\MgrWMS@HFPos@HR{c}
\def\MgrWMS@HFPos@FL{d}\def\MgrWMS@HFPos@FC{e}\def\MgrWMS@HFPos@FR{f}
\def\MgrWMS@Head@Symbol{p}
\def\MgrWMS@PageNumber@Symbol{n}
\def\MgrWMS@Draft@Symbol{v}
\def\MgrWMS@MyHeader@Symbol{m}
\def\MgrWMS@Empty@Symbol{e}
%
\def\MgrWMS@Draft@Pos{\MgrWMS@HFPos@FL}
\def\MgrWMS@Head@Pos{\MgrWMS@HFPos@HL}
\def\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@HR}
\def\MgrWMS@MyHeader@Pos{\@empty}
%
\define@key{MgrWMS}{wmsheadlineskip}{\setlength{\MgrWMS@HeadToLine}{#1}}% odstep od naglowka do linii
\define@key{MgrWMS}{wmsheadlineheight}{\setlength{\MgrWMS@LineHeight}{#1}}% szerokosc linii w naglowku
\define@key{MgrWMS}{wmsheadgrayline}{%
	\MgrWMS@Expand@Key@Boolean{wmsheadgrayline}{false}{#1}{MgrWMS@grayline}}% szara linia
\define@key{MgrWMS}{wmsheadgraylinecolor}{\def\MgrWMS@GrayLineColor{#1}}% stopien szarosci linii
\define@key{MgrWMS}{wmsheadtruncate}{\MgrWMS@Expand@Key@Boolean{wmsheadtruncate}{true}{#1}{MgrWMS@headtruncate}}% obcinanie naglowkow
\define@key{MgrWMS}{wmsheadtruncatesize}{\def\MgrWMS@HeadTruncateSize{#1}}% stopien obciecia (z przedzialu [0,1])
\define@key{MgrWMS}{wmsclosingfoot}{\MgrWMS@Expand@Key@Boolean{wmsclosingfoot}{false}{#1}{MgrWMS@closingfoot}}% drukowanie stopki na str. zamykajacej
\define@key{MgrWMS}{wmsdraftfoot}{\MgrWMS@Expand@Key@Boolean{wmsdraftfoot}{false}{#1}{MgrWMS@draft}}% drukowanie stopki roboczej (ogolnie)
\define@key{MgrWMS}{wmsdraftframe}{\MgrWMS@Expand@Key@Boolean{wmsdraftframe}{true}{#1}{MgrWMS@draftframe}}% drukowanie obramowania
\define@key{MgrWMS}{wmsdraftauthor}{\MgrWMS@Expand@Key@Boolean{wmsdraftauthor}{false}{#1}{MgrWMS@draftauthor}}% drukowanie autora w ramce
%
\def\MgrWMS@OddHead@Left{{\MgrWMS@HeadStyle\rightmark}}
\def\MgrWMS@OddHead@Center{}
\def\MgrWMS@OddHead@Right{{\MgrWMS@PageNumberStyle\thepage}}
\def\MgrWMS@EvenHead@Left{{\MgrWMS@PageNumberStyle\thepage}}
\def\MgrWMS@EvenHead@Center{}
\def\MgrWMS@EvenHead@Right{{\MgrWMS@HeadStyle\leftmark}}
\def\MgrWMS@OddFoot@Left{\MgrWMS@Draft@Foot{l}}
\def\MgrWMS@OddFoot@Center{}
\def\MgrWMS@OddFoot@Right{}
\def\MgrWMS@EvenFoot@Left{}
\def\MgrWMS@EvenFoot@Center{}
\def\MgrWMS@EvenFoot@Right{\MgrWMS@Draft@Foot{r}}
%----- Old layout - pagina -----%
\ifMgrWMS@oldlayout
	\def\MgrWMS@HeadStyle{\sffamily\small}%
	\def\MgrWMS@PageNumberStyle{\sffamily\normalsize}%
	\def\MgrWMS@Head@Pos{\MgrWMS@HFPos@HR}%
	\def\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@FR}%
	\def\MgrWMS@OddHead@Left{}%
	\def\MgrWMS@OddHead@Right{{\MgrWMS@HeadStyle\rightmark}}%
	\def\MgrWMS@EvenHead@Left{{\MgrWMS@HeadStyle\leftmark}}%
	\def\MgrWMS@EvenHead@Right{}%
	\def\MgrWMS@OddFoot@Right{{\MgrWMS@PageNumberStyle\thepage}}%
	\def\MgrWMS@EvenFoot@Left{{\MgrWMS@PageNumberStyle\thepage}}%
\else\relax\fi
%
\define@key{MgrWMS}{wmsheadleft}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@HL}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@HL}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@Draft@Foot{l}}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@Draft@Foot{r}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@HL}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@HL}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddHead@Left{}%
		\gdef\MgrWMS@EvenHead@Right{}\fi
}
\define@key{MgrWMS}{wmsheadcenter}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@HC}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@HC}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@Draft@Foot{c}}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@Draft@Foot{c}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@HC}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@HC}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddHead@Center{}%
		\gdef\MgrWMS@EvenHead@Center{}\fi
}
\define@key{MgrWMS}{wmsheadright}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@HR}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@HR}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@Draft@Foot{r}}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@Draft@Foot{l}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@HR}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@HR}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddHead@Right{}%
		\gdef\MgrWMS@EvenHead@Left{}\fi
}
\define@key{MgrWMS}{wmsfootleft}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@FL}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@FL}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@Draft@Foot{l}}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@Draft@Foot{r}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@FL}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@FL}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddFoot@Left{}%
		\gdef\MgrWMS@EvenFoot@Right{}\fi
}
\define@key{MgrWMS}{wmsfootcenter}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@FC}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@FC}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@Draft@Foot{c}}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@Draft@Foot{c}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@FC}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@FC}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddFoot@Center{}%
		\gdef\MgrWMS@EvenFoot@Center{}\fi
}
\define@key{MgrWMS}{wmsfootright}{%
	\if#1\MgrWMS@Head@Symbol
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@HeadStyle\leftmark}}%
		\gdef\MgrWMS@Head@Pos{\MgrWMS@HFPos@FR}\fi
	\if#1\MgrWMS@PageNumber@Symbol
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@PageNumber@Pos{\MgrWMS@HFPos@FR}\fi
	\if#1\MgrWMS@Draft@Symbol
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@Draft@Foot{r}}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@Draft@Foot{l}}}%
		\gdef\MgrWMS@Draft@Pos{\MgrWMS@HFPos@FR}\fi
	\if#1\MgrWMS@MyHeader@Symbol
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@MyHeaderTextStyle\MgrWMS@MyHeaderText}}%
		\gdef\MgrWMS@MyHeader@Pos{\MgrWMS@HFPos@FR}\fi
	\if#1\MgrWMS@Empty@Symbol
		\gdef\MgrWMS@OddFoot@Right{}%
		\gdef\MgrWMS@EvenFoot@Left{}\fi
}
\define@key{MgrWMS}{wmshfclear}{%
	\MgrWMS@Expand@Key{wmshfclear}{false}{#1}{%
		\gdef\MgrWMS@OddHead@Left{}%
		\gdef\MgrWMS@OddHead@Center{}%
		\gdef\MgrWMS@OddHead@Right{}%
		\gdef\MgrWMS@EvenHead@Left{}%
		\gdef\MgrWMS@EvenHead@Center{}%
		\gdef\MgrWMS@EvenHead@Right{}%
		\gdef\MgrWMS@OddFoot@Left{}%
		\gdef\MgrWMS@OddFoot@Center{}%
		\gdef\MgrWMS@OddFoot@Right{}%
		\gdef\MgrWMS@EvenFoot@Left{}%
		\gdef\MgrWMS@EvenFoot@Center{}%
		\gdef\MgrWMS@EvenFoot@Right{}%
	}{}%
}
%
%----- Defincje dla uzytkownika -----%
\newcommand*{\MyHeaderText}[1]{\def\MgrWMS@MyHeaderText{#1}}
\newcommand*{\MyHeaderTextStyle}[1]{\def\MgrWMS@MyHeaderTextStyle{#1}}
\newcommand*{\PageHeadStyle}[1]{\def\MgrWMS@HeadStyle{#1}}
\newcommand*{\PageNumberStyle}[1]{\def\MgrWMS@PageNumberStyle{#1}}
\newcommand*{\DraftFootStyle}[1]{\def\MgrWMS@DraftFootStyle{#1}}
%
% Tytularia
% ----------
\ifMgrWMS@oldlayout
	\def\MgrWMS@Part@type{b}
	\def\MgrWMS@Chapter@type{b}
\else
	\def\MgrWMS@Part@type{a}% naglowek czesci
	\def\MgrWMS@Chapter@type{a}% naglowek rozdzialu
\fi
\def\MgrWMS@Section@type{Hang}% naglowek sekcji
\define@key{MgrWMS}{wmspart}{\def\MgrWMS@Part@type{#1}}
\define@key{MgrWMS}{wmschapter}{\def\MgrWMS@Chapter@type{#1}}
\define@key{MgrWMS}{wmssectionhang}{% tytuly sekcji zawieszone pod numerem
	\MgrWMS@Expand@Key{MgrWMS}{true}{#1}{\def\MgrWMS@Section@type{Hang}}{\def\MgrWMS@Section@type{NoHang}}%
}
%
% Strona tytulowa
% ---------------
\newif\ifMgrWMS@PageOswiad\MgrWMS@PageOswiadtrue
\define@key{MgrWMS}{wmsoswiadczenie}{%
	\MgrWMS@Expand@Key@Boolean{wmsoswiadczenie}{true}{#1}{MgrWMS@PageOswiad}}
%
% Parametry list
% --------------
\def\MgrWMS@AddToLabelSep{0pt}
\def\MgrWMS@AddToItemIndent{0pt}
\def\MgrWMS@AddToListTBSpace{0pt}
\define@key{MgrWMS}{wmsaddtolabelsep}{\def\MgrWMS@AddToLabelSep{#1}}
\define@key{MgrWMS}{wmsaddtolistindent}{\def\MgrWMS@AddToItemIndent{#1}}
\define@key{MgrWMS}{wmsaddtolisttbspace}{\def\MgrWMS@AddToListTBSpace{#1}}
%
% Spis tresci
% --------------
\setlength\MgrWMS@dim@toc{-1pt}
\newif\ifMgrWMS@TOCPartChapter\MgrWMS@TOCPartChapterfalse
\define@key{MgrWMS}{wmstocindent}{\setlength\MgrWMS@dim@toc{#1}}
\define@key{MgrWMS}{wmstocpartchaptername}{%
	\MgrWMS@Expand@Key@Boolean{wmstocpartchaptername}{false}{#1}{MgrWMS@TOCPartChapter}}
%
% Podpisy, przypisy i inne
% ------------------------
\def\MgrWMS@CaptionSpaceRate{0.9}
\newif\ifMgrWMS@CaptionHang\MgrWMS@CaptionHangfalse
\newif\ifMgrWMS@Footnote\MgrWMS@Footnotetrue
\newif\ifMgrWMS@FootnoteResetbyCh\MgrWMS@FootnoteResetbyChtrue
\define@key{MgrWMS}{wmscaptionspace}{\def\MgrWMS@CaptionSpaceRate{#1}}
\define@key{MgrWMS}{wmscaptionhang}{%
	\MgrWMS@Expand@Key@Boolean{wmscaptionhang}{false}{#1}{MgrWMS@CaptionHang}}
\define@key{MgrWMS}{wmsfootnote}{%
	\MgrWMS@Expand@Key@Boolean{wmsfootnote}{true}{#1}{MgrWMS@Footnote}}
\define@key{MgrWMS}{wmsfootnoteresetbychapter}{%
	\MgrWMS@Expand@Key@Boolean{wmsfootnoteresetbychapter}{true}{#1}{MgrWMS@FootnoteResetbyCh}}
%
\MgrWMS@ProcessOptionsWithKV
%
%
% =============
%   MARGINESY
% =============
%
\setlength\headheight{\baselineskip}
\setlength\headsep{\baselineskip}
\setlength\topskip{\MgrWMS@basesize\p@}
\setlength\footskip{2\baselineskip}
\setlength\maxdepth{.5\topskip}
\addtolength\headheight{\MgrWMS@AddToHeadHeight}
\addtolength\headsep{\MgrWMS@HeadToLine}
\addtolength\headsep{\MgrWMS@LineHeight}
\addtolength\headsep{\MgrWMS@AddToHeadSep}
\addtolength\footskip{\MgrWMS@AddToFootSkip}
%
\ifMgrWMS@marginpar
	\setlength\marginparsep{1cc}
	\setlength\marginparwidth{4cc}
	\setlength\marginparpush{.5\baselineskip}
\else
	\setlength\marginparsep{0\p@}
	\setlength\marginparwidth{0\p@}
	\setlength\marginparpush{0\p@}
	\def\marginpar{\MgrWMS@Error{Notatki na marginesach zostaly domyslnie wylaczone w klasie 'mgrwms'.\MessageBreak
	  Uzyj opcji `marginpar' dla ich uaktywnienia}{}\global\let\marginpar\@gobble}
\fi
\setlength\columnsep{2cc}
\setlength\columnseprule{0\p@}
%
\setlength\oddsidemargin{\MgrWMSleft}
\addtolength\oddsidemargin{-1in}
\setlength\evensidemargin{\MgrWMSright}
\addtolength\evensidemargin{-1in}
\setlength\@tempdima{\paperwidth}
\addtolength\@tempdima{-\MgrWMSleft}
\addtolength\@tempdima{-\MgrWMSright}
\addtolength\@tempdima{-\marginparsep}
\addtolength\@tempdima{-\marginparwidth}
\setlength\textwidth{\@tempdima}
%% \if@twocolumn
%% \addtolength\@tempdimb{\@tempdimb}
%% \addtolength\@tempdimb{\columnsep}
%% \fi
\@settopoint\textwidth
%
\setlength\@tempdima{\paperheight}
\setlength\topmargin{\MgrWMStop}
\addtolength\topmargin{-1in}
\addtolength\@tempdima{-\MgrWMStop}
\addtolength\@tempdima{-\MgrWMSbottom}
\addtolength\@tempdima{-\headheight}
\addtolength\@tempdima{-\headsep}
\addtolength\@tempdima{-\footskip}
  \advance\@tempdima-.5\baselineskip
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
  \addtolength\textheight{\topskip}
%%\if@twoside
%%  \addtolength\oddsidemargin{-.1\@tempdima}
%%  \addtolength\evensidemargin{.1\@tempdima}
%%\fi
%%\MgrWMS@SetupMargins
%
%
% =====================
%   USTAWIENIA PAGINY
% =====================
%
% Ustawienia parametrow dla ukladu strony
% ---------------------------------------
\newdimen\@parindent
\@parindent\parindent
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\hyphenpenalty=0
\exhyphenpenalty=0
\widowpenalty 10000
\clubpenalty  5000
	\displaywidowpenalty 5000
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or **\or *{*}*
	\else\@ctrerr\fi}}
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{4}%% bylo 3... RCz
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
%
% Definicje dla 'markboth' i 'markright'
% --------------------------------------
\def\markboth#1#2{%
  \begingroup
    \let\label\relax \let\index\relax \let\glossary\relax
    \unrestored@protected@xdef\@themark {{#1}{#2}}%
    \@temptokena \expandafter{\@themark}%
    \mark{\the\@temptokena}%
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}
\def\markright#1{%
  \begingroup
    \let\label\relax \let\index\relax \let\glossary\relax
    \expandafter\@markright\@themark {#1}%
    \@temptokena \expandafter{\@themark}%
    \mark{\the\@temptokena}%
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}
\def\@markright#1#2#3{\@temptokena {#1}%
  \unrestored@protected@xdef\@themark{{\the\@temptokena}{#3}}}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{1.5}
\setlength\parskip{\z@}
\if@twocolumn
  \setlength\parindent{1em}
\else
  \setlength\parindent{1.5em}
\fi
%
% Elementy pomocnicze do paginy
% -----------------------------
\ifMgrWMS@grayline
	\definecolor{MgrWMS@DefaultGrayLine}{gray}{\MgrWMS@GrayLineColor}
\else\relax\fi
%
\newcommand{\MgrWMS@PageHeadLine}{{% linia w naglowku
	\ifMgrWMS@grayline\color{MgrWMS@DefaultGrayLine}\else\fi
		\hrule height\MgrWMS@LineHeight
}}
%
\newcommand{\MgrWMS@HT}[1]{% naglowek obciety do maksymalnej dlugosci
	\ifMgrWMS@headtruncate
		\MgrWMSTruncate{\MgrWMS@HeadTruncateSize\linewidth}{#1}%
	\else
		{#1}%
	\fi
}
%
% Sklad czesci roboczej paginy
% ----------------------------
\newcommand{\MgrMWS@Date@Sep}{.}
\newcommand{\MgrMWS@Time@Sep}{:}
% Taken from uiucthesis.cls (2005/03/25 v2.25, by Peter Czoschke, David Hull)
% Thank you Peter and David for this nice idea! :)
%\ifMgrWMS@draft
\newcount\MgrWMS@timehh\newcount\MgrWMS@timemm
\MgrWMS@timehh=\time\MgrWMS@timemm=\time
\divide\MgrWMS@timehh by 60
\count255=\MgrWMS@timehh\multiply\count255 by -60
\advance\MgrWMS@timemm by\count255
%\else\relax\fi
%
\newcommand{\MgrWMSDate}{% drukuje date
  \ifnum\day<10 0\fi\number\day\MgrMWS@Date@Sep
  \ifnum\month<10 0\fi\number\month\MgrMWS@Date@Sep\number\year
}
\newcommand{\MgrWMSTime}{% drukuje czas
	\ifnum\MgrWMS@timehh<10 0\fi\number\MgrWMS@timehh\MgrMWS@Time@Sep
	\ifnum\MgrWMS@timemm<10 0\fi\number\MgrWMS@timemm
}
\newcommand{\MgrWMSDraft}{%
	\MgrWMSDate,\,\MgrWMSTime\ifMgrWMS@draftauthor\ : \@author\else\fi
}
\newcommand{\MgrWMS@Draft@Box}[1]%  odd --- l, even --- r
{{\addtolength{\fboxsep}{-1pt}%
  \addtolength{\fboxrule}{0.2pt}%
  \makebox[0pt][#1]{%
		\ifMgrWMS@draftframe\framebox{\MgrWMS@DraftFootStyle\MgrWMSDraft}%
		\else{\MgrWMS@DraftFootStyle\MgrWMSDraft}\fi}%
}}
\newcommand{\MgrWMS@Draft@Foot}[1]{%
	{\ifMgrWMS@draft\MgrWMS@Draft@Box{#1}\else\relax\fi}}
%
% Naglowki definiowane przez uzytkownika
% ---------------------------------------
% \StartMyLeftHeader & \StopMyLeftHeader uzywane dla naglowkow
% bibliografii, indeksu itp (nieudokumentowane dla uzytkownika)
\newcommand{\StartMyLeftHeader}[1]{% sprawdzamy gdzie jest zywa pagina
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HL
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddHead@Left
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenHead@Right
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@HeadStyle#1}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HC
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddHead@Center
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenHead@Center
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@HeadStyle#1}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HR
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddHead@Right
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenHead@Left
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@HeadStyle#1}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FL
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddFoot@Left
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenFoot@Right
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@HeadStyle#1}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FC
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddFoot@Center
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenFoot@Center
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@HeadStyle#1}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FR
		\let\MgrWMS@OldOdd@HeadFoot\MgrWMS@OddFoot@Right
		\let\MgrWMS@OldEven@HeadFoot\MgrWMS@EvenFoot@Left
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@HeadStyle#1}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@HeadStyle#1}}%
	\else\fi
}
\newcommand{\StopMyLeftHeader}{%
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HL
		\let\MgrWMS@OddHead@Left\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenHead@Right\MgrWMS@OldEven@HeadFoot
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HC
		\let\MgrWMS@OddHead@Center\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenHead@Center\MgrWMS@OldEven@HeadFoot
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HR
		\let\MgrWMS@OddHead@Right\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenHead@Left\MgrWMS@OldEven@HeadFoot
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FL
		\let\MgrWMS@OddFoot@Left\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenFoot@Right\MgrWMS@OldEven@HeadFoot
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FC
		\let\MgrWMS@OddFoot@Center\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenFoot@Center\MgrWMS@OldEven@HeadFoot
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FR
		\let\MgrWMS@OddFoot@Right\MgrWMS@OldOdd@HeadFoot
		\let\MgrWMS@EvenFoot@Left\MgrWMS@OldEven@HeadFoot
	\else\fi
}
\newcommand{\MgrMWS@RestoreHeaderDef}{% przywrocenie domyslnej zywej paginy
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HL
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HC
		\gdef\MgrWMS@OddHead@Center{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Center{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@HR
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FL
		\gdef\MgrWMS@OddFoot@Left{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Right{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FC
		\gdef\MgrWMS@OddFoot@Center{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Center{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@Head@Pos\MgrWMS@HFPos@FR
		\gdef\MgrWMS@OddFoot@Right{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenFoot@Left{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
}
\newcommand{\RemoveMyHeaderText}{% usuniecie wlasnej dodatkowego tekstu
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@HL
		\gdef\MgrWMS@OddHead@Left{{\MgrWMS@HeadStyle\rightmark}}%
		\gdef\MgrWMS@EvenHead@Right{{\MgrWMS@HeadStyle\leftmark}}%
	\else\fi
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@HC
		\gdef\MgrWMS@OddHead@Center{}%
		\gdef\MgrWMS@EvenHead@Center{}%
	\else\fi
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@HR
		\gdef\MgrWMS@OddHead@Right{{\MgrWMS@PageNumberStyle\thepage}}%
		\gdef\MgrWMS@EvenHead@Left{{\MgrWMS@PageNumberStyle\thepage}}%
	\else\fi
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@FL
		\gdef\MgrWMS@OddFoot@Left{\MgrWMS@Draft@Foot{l}}%
		\gdef\MgrWMS@EvenFoot@Right{\MgrWMS@Draft@Foot{l}}%
	\else\fi
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@FC
		\gdef\MgrWMS@OddFoot@Center{}%
		\gdef\MgrWMS@EvenFoot@Center{}%
	\else\fi
	\if\MgrWMS@MyHeader@Pos\MgrWMS@HFPos@FR
		\gdef\MgrWMS@OddFoot@Right{}%
		\gdef\MgrWMS@EvenFoot@Left{}%
	\else\fi
	\gdef\MgrWMS@MyHeader@Pos{\@empty}%
}
%
% Sklad stylow-cegielek
% ---------------------
% empty i plain jak poprzednio
\newcommand\hf@empty{%
  \let\@oddhead\@empty
	\def\@oddfoot{\MgrWMS@Draft@Foot{l}\hfill}%
  \let\@evenhead\@empty
	\def\@evenfoot{\MgrWMS@Draft@Foot{l}\hfill}%
}
\newcommand\hf@plain{%
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font\hfil{\MgrWMS@PageNumberStyle\thepage}\hfil}%
  \let\@evenhead\@empty
  \def\@evenfoot{\reset@font\hfil{\MgrWMS@PageNumberStyle\thepage}\hfil}%
}
% plain/opening zgodnie z wmsheadings
\let\MgrWMS@Plain@OddFoot@Left\MgrWMS@OddFoot@Left
\let\MgrWMS@Plain@OddFoot@Right\MgrWMS@OddFoot@Right
\let\MgrWMS@Plain@EvenFoot@Left\MgrWMS@EvenFoot@Left
\let\MgrWMS@Plain@EvenFoot@Right\MgrWMS@EvenFoot@Right
\def\MgrWMS@Plain@OddFoot@Center{{\MgrWMS@PageNumberStyle\thepage}}
\def\MgrWMS@Plain@EvenFoot@Center{{\MgrWMS@PageNumberStyle\thepage}}
\if\MgrWMS@PageNumber@Pos\MgrWMS@HFPos@FL
	\let\MgrWMS@Plain@OddFoot@Center\MgrWMS@OddFoot@Center
	\let\MgrWMS@Plain@EvenFoot@Center\MgrWMS@EvenFoot@Center
\else\fi
\if\MgrWMS@PageNumber@Pos\MgrWMS@HFPos@FR
	\let\MgrWMS@Plain@OddFoot@Center\MgrWMS@OddFoot@Center
	\let\MgrWMS@Plain@EvenFoot@Center\MgrWMS@EvenFoot@Center
\else\fi
\newcommand\hf@wmsplain{%
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font\MgrWMS@HT{\MgrWMS@Plain@OddFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Plain@OddFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Plain@OddFoot@Right}}%
  \let\@evenhead\@empty
  \def\@evenfoot{\reset@font\MgrWMS@HT{\MgrWMS@Plain@EvenFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Plain@EvenFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Plain@EvenFoot@Right}}%
}
\newcommand\hf@wmsheadings{%
  \def\@oddhead{\vtop{%
    \hb@xt@\textwidth{%
    \reset@font\MgrWMS@HT{\MgrWMS@OddHead@Left}\hfil\MgrWMS@HT{\MgrWMS@OddHead@Center}\hfil\MgrWMS@HT{\MgrWMS@OddHead@Right\unskip}}%
    \vskip\MgrWMS@HeadToLine\MgrWMS@PageHeadLine
		\vskip-\MgrWMS@LineHeight\vskip-\MgrWMS@HeadToLine}}%
  \def\@oddfoot{\reset@font\MgrWMS@HT{\MgrWMS@OddFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@OddFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@OddFoot@Right}}%
  \def\@evenhead{\vtop{%
    \hb@xt@\textwidth{%
    \reset@font\MgrWMS@HT{\MgrWMS@EvenHead@Left}\hfil\MgrWMS@HT{\MgrWMS@EvenHead@Center}\hfil\MgrWMS@HT{\MgrWMS@EvenHead@Right}}%
		\vskip\MgrWMS@HeadToLine\MgrWMS@PageHeadLine
		\vskip-\MgrWMS@LineHeight\vskip-\MgrWMS@HeadToLine}}%
  \def\@evenfoot{\reset@font\MgrWMS@HT{\MgrWMS@EvenFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@EvenFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@EvenFoot@Right}}%
}
% closing zgodnie z wmsheadings
\def\MgrWMS@Close@OddFoot@Left{}
\def\MgrWMS@Close@OddFoot@Center{}
\def\MgrWMS@Close@OddFoot@Right{}
\def\MgrWMS@Close@EvenFoot@Left{}
\def\MgrWMS@Close@EvenFoot@Center{}
\def\MgrWMS@Close@EvenFoot@Right{}
\if\MgrWMS@Draft@Pos\MgrWMS@HFPos@FL
	\def\MgrWMS@Close@OddFoot@Left{\MgrWMS@Draft@Foot{l}}
	\def\MgrWMS@Close@EvenFoot@Right{\MgrWMS@Draft@Foot{r}}
\else\fi
\if\MgrWMS@Draft@Pos\MgrWMS@HFPos@FC
	\def\MgrWMS@Close@OddFoot@Center{\MgrWMS@Draft@Foot{c}}
	\def\MgrWMS@Close@EvenFoot@Center{\MgrWMS@Draft@Foot{c}}
\else\fi
\if\MgrWMS@Draft@Pos\MgrWMS@HFPos@FR
	\def\MgrWMS@Close@OddFoot@Right{\MgrWMS@Draft@Foot{r}}
	\def\MgrWMS@Close@EvenFoot@Left{\MgrWMS@Draft@Foot{l}}
\else\fi
\ifMgrWMS@closingfoot
	\let\MgrWMS@Close@OddFoot@Left\MgrWMS@OddFoot@Left
	\let\MgrWMS@Close@OddFoot@Center\MgrWMS@OddFoot@Center
	\let\MgrWMS@Close@OddFoot@Right\MgrWMS@OddFoot@Right
	\let\MgrWMS@Close@EvenFoot@Left\MgrWMS@EvenFoot@Left
	\let\MgrWMS@Close@EvenFoot@Center\MgrWMS@EvenFoot@Center
	\let\MgrWMS@Close@EvenFoot@Right\MgrWMS@EvenFoot@Right
\else\fi
%
% Sklad uzywanych stylow stron
% ------------------------------
\def\ps@empty{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@empty
  \let\ps@opening\hf@empty
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@plain
  \let\ps@opening\hf@plain
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
\def\ps@wmsplain{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@wmsplain
  \let\ps@opening\hf@wmsplain
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
%
\if@twoside
  \def\ps@wmsheadings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@wmsheadings
    \let\ps@opening\hf@wmsplain
    \def\ps@closing{\hf@wmsheadings
			\def\@oddfoot{\reset@font\MgrWMS@HT{\MgrWMS@Close@OddFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Close@OddFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Close@OddFoot@Right}}%
			\def\@evenfoot{\reset@font\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Right}}}%
    \let\ps@blank\hf@empty
    \ps@normal
    \def\chaptermark##1{%
      \markboth{%
				\ifHeadingNumbered
				\if@mainmatter
					\@chapapp\ \thechapter.\enspace \fi\fi ##1}%
			 {\ifHeadingNumbered
				\if@mainmatter
					\@chapapp\ \thechapter.\enspace \fi\fi ##1}}%
		\def\sectionmark##1{%
      \markright{\ifHeadingNumbered \thesection.\enspace \fi ##1}}%
}
\else
  \def\ps@wmsheadings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@wmsheadings
    \let\ps@opening\hf@wmsplain
    \def\ps@closing{\hf@wmsheadings
			\def\@oddfoot{\reset@font\MgrWMS@HT{\MgrWMS@Close@OddFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Close@OddFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Close@OddFoot@Right}}%
			\def\@evenfoot{\reset@font\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Left}\hfil\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Center}\hfil\MgrWMS@HT{\MgrWMS@Close@EvenFoot@Right}}}%
    \let\ps@blank\hf@empty
    \ps@normal
		\def\chaptermark##1{\markboth{%
			\ifHeadingNumbered
				\@chapapp\ \thechapter.\enspace\else\fi ##1}%
		 {\ifHeadingNumbered
				\@chapapp\ \thechapter.\enspace\else\fi ##1}}%
    \def\sectionmark##1{%
      \markright{\ifHeadingNumbered \thesection.\enspace \fi ##1}}%
}
\fi
%
%
% ===================
%   STRONA TYTULOWA
% ===================
%
% Pomocnicze elementy strony
% ------------------------------
\newcommand{\MgrWMS@Page@TitleFnt}{\huge\sffamily\bfseries}
\newcommand{\MgrWMS@Page@AuthorFnt}{\LARGE}
\newcommand{\MgrWMS@Page@BasicAFnt}{\large}
\newcommand{\MgrWMS@Page@BasicBFnt}{\normalsize}
\newcommand{\wmstitlesetup}{\rmfamily}
%
\newcommand{\tytul}[1]{\gdef\@title{#1}}
\newcommand{\autor}[1]{\gdef\@author{#1}}
\newcommand{\promotor}[1]{\gdef\MgrWMS@Promotor{#1}\gdef\@promotor{#1}}
\def\MgrWMS@Promotor{\MgrWMS@Error{Nazwisko promotora nie zostalo podane, to pole zostanie puste!}{}}
\newcommand{\nralbumu}[1]{\gdef\MgrWMS@NrAlbumu{#1}\gdef\@nralbumu{#1}}
\def\MgrWMS@NrAlbumu{\MgrWMS@Error{\protect\nralbumu jest niezdefiniowane!}{}}
\newcommand{\slowakluczowe}[1]{\gdef\MgrWMS@SlowaKluczowe{#1}\gdef\@slowakluczowe{#1}}
\def\MgrWMS@SlowaKluczowe{\MgrWMS@Error{Polskie slowa kluczowe (\protect\slowakluczowe) nie zostaly zdefiniowane!}{}}
\newcommand{\keywords}[1]{\gdef\MgrWMS@Keywords{#1}\gdef\@keywords{#1}}
\def\MgrWMS@Keywords{\MgrWMS@Error{English keywords (\protect\keywords) are undefined!}{}}
\@ifundefined{MgrWMS@ManWoman@Chck}{%
	\MgrWMS@Error{Zadna z opcji man/woman nie zostala zadeklarowana! Opcja 'woman' zostanie uzyta!}{}%
	\gdef\MgrWMS@ManWoman@Chck{F}}{}%
\ifMgrWMS@man
	\gdef\MgrWMS@Page@K{y}\else\gdef\MgrWMS@Page@K{a}\fi
%----- Polecenia dla specjalnosci -----%
\newcommand{\MgrWMS@SetMathSpecial@SIECI}{%
	\def\MgrWMS@Page@MathSpecial{%
		\MgrWMS@Page@BasicBFnt Systemy rozproszone \\ &\MgrWMS@Page@BasicBFnt i sieci komputerowe}%
}
\newcommand{\MgrWMS@SetMathSpecial@BAZY}{%
	\def\MgrWMS@Page@MathSpecial{%
		\MgrWMS@Page@BasicBFnt In{\PL@z}ynieria system{\PL@o}w \\ &\MgrWMS@Page@BasicBFnt informatycznych i baz danych}%
}
\@ifundefined{MgrWMS@MathSpecial}{%
	\MgrWMS@Error{Zadna ze specjalnosci nie zostala zadeklarowana! Systemy rozproszone i sieci komputerowe zostanie uzyta!}{}%
	\gdef\MgrWMS@MathSpecial{SIECI}}{}%
\csname MgrWMS@SetMathSpecial@\MgrWMS@MathSpecial\endcsname
%----- Polecenia dla emblematow uczelni i wydzialu  -----%
\ifMgrWMS@pdftex
	\def\MgrWMS@LogoAGH{mgrwmsgr/logoAGH.pdf}
	\def\MgrWMS@LogoWMS{mgrwmsgr/logoWIET.pdf}
\else
	\def\MgrWMS@LogoAGH{mgrwmsgr/logoAGH.eps}
	\def\MgrWMS@LogoWMS{mgrwmsgr/logoEAIE.eps}
\fi
%----- Sklad oswiadczenia -----%
\newcommand{\MgrWMS@Page@Oswiadczenie}{%
  \newpage\thispagestyle{empty}%
  \vspace*{2\baselineskip}%
  \begin{center}%
		{\large\sffamily\bfseries O{\PL@s}wiadczenie autora}\par\bigskip
  \end{center}%
	\hyphenpenalty=0%
  {\itshape O{\PL@s}wiadczam, {\PL@s}wiadomy odpowiedzialno{\PL@s}ci karnej za po{\PL@s}wiadczenie nieprawdy, {\PL@z}e ni\-niej\-sz{\PL@a} prac{\PL@e} dyplomow{\PL@a} wykona{\PL@l}em osobi{\PL@s}cie i samodzielnie, i {\PL@z}e nie korzysta{\PL@l}em ze {\PL@x}r{\PL@o}de{\PL@l} innych ni{\PL@z} wymienione w pracy.}
	\par\vspace{3\baselineskip}%
	\hfill\parbox{15em}{{\small\dotfill}\\[-.3ex]\centerline{\footnotesize (Podpis autora)}}\par
%  \vspace{4\baselineskip}%
%	\begin{center}%
%    {\large\sffamily\bfseries O{\PL@s}wiadczenie promotora}\par\bigskip
%	\end{center}%
%	  {\itshape O{\PL@s}wiadczam, {\PL@z}e praca spe{\PL@l}nia wymogi stawiane pracom magisterskim.}%
%	\par\vspace{3\baselineskip}%
%	\hfill\parbox{15em}{{\small\dotfill}\\[-.3ex]\centerline{\footnotesize (Podpis promotora)}}\par
	\addtocounter{page}{-1}%
}
%
% Wlasciwy sklad strony tytulowej
% -------------------------------
\let\@date\@empty
\if@titlepage
\newcommand\maketitle{\begin{titlepage}%
	\let\footnotesize\small %??
  \let\footnoterule\relax
  \let\footnote\thanks
	\def\MgrWMS@Temp@Symb{N}%
  \if\MgrWMS@sizesymbol\MgrWMS@Temp@Symb\relax
			\else\MgrWMS@SizeDef@N\fi
	\settowidth{\MgrWMS@dim@a}{\MgrWMS@Page@BasicAFnt Nr albumu: }%
	\MgrWMS@SingleSpacing\wmstitlesetup
  \hyphenpenalty=10000
	\begin{center}%
    \vspace*{-4.25\baselineskip}%
    \includegraphics[height=6.0\baselineskip]{\MgrWMS@LogoAGH}\par
		\vspace*{0.75\baselineskip}%
    \begin{tabular}{c}%
      \MgrWMS@Page@BasicAFnt Akademia G{\PL@o}rniczo-Hutnicza \\[\smallskipamount]
      \MgrWMS@Page@BasicAFnt im. Stanis{\PL@l}awa Staszica \\[\smallskipamount]
      \MgrWMS@Page@BasicAFnt w Krakowie
		\end{tabular}\par
  \vspace*{\smallskipamount}%
  \noindent\rule{\textwidth}{1.75pt}\\[-10.655pt]
  \noindent\rule{\textwidth}{1pt}\par
    \vspace*{2\baselineskip}%
   {\MgrWMS@Page@AuthorFnt Praca magisterska\par}%
    \vspace*{2\baselineskip}%
   {\MgrWMS@Page@TitleFnt\@title\par}%
    \vspace{3\baselineskip}%
   {\MgrWMS@Page@AuthorFnt\@author\par}%
		\vfill
		\noindent\begin{tabular}[b]{@{}p{\MgrWMS@dim@a}@{\ }l@{}}
      {\MgrWMS@Page@BasicBFnt\hfill {\sffamily\bfseries Kierunek:}} & {\MgrWMS@Page@BasicBFnt Informatyka} \\
			{\MgrWMS@Page@BasicBFnt\hfill {\sffamily\bfseries Specjalno\PL@s\PL@c:}} & \MgrWMS@Page@MathSpecial
    \end{tabular}\hfill\mbox{}\par
		\vspace*{\baselineskip}%
		\noindent\begin{tabular}[b]{@{}p{\MgrWMS@dim@a}@{\ }l@{}}
      {\MgrWMS@Page@BasicBFnt\hfill {\sffamily\bfseries Nr albumu:}} & {\MgrWMS@Page@BasicBFnt\MgrWMS@NrAlbumu}%
    \end{tabular}\hfill
    \begin{tabular}[b]{@{}l@{}}%
      {\sffamily\bfseries Promotor:} \\[\smallskipamount]
      {\MgrWMS@Page@BasicAFnt\MgrWMS@Promotor}%
    \end{tabular}\par
	 	\vspace*{2.5\baselineskip}%
  \par\vskip5mm
 {\MgrWMS@Page@BasicAFnt Wydzia{\PL@l} Informatyki, Elektroniki i Telekomunikacji\\[\smallskipamount]
 Katedra Informatyki}\par\vspace{-\smallskipamount}%
	\noindent\rule{\textwidth}{1pt}\\[-9.905pt]
	\noindent\rule{\textwidth}{1.75pt}\\[\smallskipamount]
				\raisebox{3pt}
 {\MgrWMS@Page@BasicAFnt Krak{\PL@o}w \number\year}\par
	\vspace{-1.5\baselineskip}%
	\end{center}%
	\if\MgrWMS@sizesymbol\MgrWMS@Temp@Symb\relax
		\else\csname MgrWMS@SizeDef@\MgrWMS@sizesymbol\endcsname\fi
	\ifMgrWMS@PageOswiad
		\MgrWMS@Page@Oswiadczenie
	\fi
  \end{titlepage}%
  \setcounter{footnote}{0}%
	\global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\and{\\\Large\strut}
\else
	\newcommand\maketitle{\@maketitle}
	\def\@maketitle{\@empty}
	\def\and{\@empty}
\fi
%
%
% ====================
%   SKLAD TYTULARIOW
% ====================
%
% Tytularia z mwbk (I)
% --------------------
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      \normalfont\wmssectsetup#6{%
        \language\l@nohyphenation \raggedright
        \interlinepenalty \@M
        \leftskip #3\noindent
        \@svsec\ignorespaces
        #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname.}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      \normalfont\wmssectsetup#6{\hskip #3\relax
      \@svsec\ignorespaces #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname.}%
        \fi
        #8}}%
  \fi
  \@xsect{#5}}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      \normalfont\wmssectsetup#4{%
        \language\l@nohyphenation \raggedright
        \interlinepenalty \@M
        \leftskip #1\noindent\ignorespaces
        #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{\normalfont\wmssectsetup#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newcommand*\partmark[1]{\markboth{}{}}
\newcommand*\chaptermark[1]{}
%
% Definicje licznikow i czesci pracy
% ----------------------------------
\setcounter{secnumdepth}{2}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand\thepart {\@Roman\c@part}
\renewcommand\thechapter {\@arabic\c@chapter}
\renewcommand\thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\def\part@level{-1}
\def\chapter@level{0}
\def\section@level{1}
\def\subsection@level{2}
\def\subsubsection@level{3}
\def\paragraph@level{4}
\def\subparagraph@level{5}
\newcommand\@chapapp{\chaptername}
\renewcommand*\@seccntformat[1]{\csname the#1\endcsname.\enspace}
\def\MgrWMS@TOC@PartName{Cz\PL@e\PL@s\PL@c}
\def\MgrWMS@TOC@ChapterName{Rozdzia\PL@l}
%
\def\cleardoublepage{\clearpage
  \if@twoside
    \ifodd\c@page\else
      \hbox{}\thispagestyle{blank}\newpage
      \if@twocolumn\hbox{}\newpage\fi
    \fi
  \fi}
\newcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}}
\newcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse}
%
% Tytularia z mwbk (II)
% ---------------------
\newcommand*\mw@getflags[1]{%
  \expandafter\expandafter\expandafter
  \mw@getflagsx\csname#1@flags\endcsname}
\newcommand*\mw@getflagsx[4]{%
  \def\mw@HeadingRunIn{1#1}%
  \def\mw@HeadingBreakBefore{1#2}%
  \def\mw@HeadingBreakAfter{1#3}%
  \def\mw@HeadingWholeWidth{1#4}%
}
\newcommand*\mw@setflags[1]{%
  \expandafter\edef\csname#1@flags\endcsname{%
    \if\mw@HeadingRunIn 1\else 0\fi
    \if\mw@HeadingBreakBefore 1\else 0\fi
    \if\mw@HeadingBreakAfter 1\else 0\fi
    \if\mw@HeadingWholeWidth 1\else 0\fi
  }
 }
\newcommand*\mw@section[1]{%
  \mw@getflags{#1}%
  \if@noskipsec \leavevmode \fi
  \par
  \if@nobreak \everypar{}\fi
  \@ifstar
    {\HeadingNumberedfalse\@dblarg{\mw@sectionx{#1}}}%
    {\HeadingNumberedtrue\@dblarg{\mw@sectionx{#1}}}}
\def\mw@sectionx#1[#2]{%
  \@dblarg{\mw@sectionxx{#1}{#2}}}
\def\mw@sectionxx#1#2[#3]#4{%
	\if\mw@HeadingBreakBefore
		\if@specialpage\else\thispagestyle{closing}\fi
	\if@openright\cleardoublepage\else
    \clearpage
	\fi
	\if\mw@HeadingBreakAfter
    \thispagestyle{blank}\else
    \thispagestyle{opening}\fi
    \global\@topnum\z@
	\fi
  \edef\mw@HeadingLevel{\csname #1@level\endcsname
        \space}% space delimits level number!
  \ifHeadingNumbered
    \ifnum \mw@HeadingLevel>\c@secnumdepth \HeadingNumberedfalse \fi
		\if@mainmatter\else \HeadingNumberedfalse \fi
  \fi
  \ifHeadingNumbered
    \refstepcounter{#1}%
    \protected@edef\HeadingNumber{\expandafter\noexpand\csname the#1\endcsname\relax}%
  \else
		\mw@hyperref@phantom{#1}%
		\let\HeadingNumber\@empty
  \fi
  \def\HeadingRHeadText{#2}%
  \def\HeadingTOCText{#3}%
  \def\HeadingText{#4}%
  \def\mw@HeadingType{#1}%
  \if\mw@HeadingRunIn
		\mw@runinheading
  \else
    \if\mw@HeadingWholeWidth
      \if@twocolumn
        \if\mw@HeadingBreakAfter
        \onecolumn
        \mw@normalheading
        \pagebreak\relax
              \if@twoside
                \null
                \thispagestyle{blank}%
                \newpage
              \fi
        \twocolumn
        \else
          \@topnewpage[\mw@normalheading]%
          \mw@markandtoc
        \fi
      \else
        \mw@normalheading
        \if\mw@HeadingBreakAfter\pagebreak\relax\fi
      \fi
    \else
      \mw@normalheading
      \if\mw@HeadingBreakAfter\pagebreak\relax\fi
    \fi
  \fi
}
%----- Zmiana polecenia \mw@markandtoc -----%
\def\MgrWMS@SecTOC@OptionalHeaderName{}
\newcommand*{\MgrWMS@SecTOC@CheckOptionalName}[1]{%
	\ifMgrWMS@TOCPartChapter
		\ifnum #1<1
			\ifnum #1=-1
				\def\MgrWMS@SecTOC@OptionalHeaderName{\partname\space}\else\fi
			\ifnum #1=0
				\def\MgrWMS@TOC@ChapTemp{\@chapapp\space}%
				\def\MgrWMS@SecTOC@OptionalHeaderName{\@chapapp\space}\else\fi
		\else
			\def\MgrWMS@SecTOC@OptionalHeaderName{}\fi
	\else\fi
}
\newcommand*\mw@markandtoc{%
  \csname \mw@HeadingType mark\endcsname{\HeadingRHeadText}%
  \ifnum \mw@HeadingLevel>\c@tocdepth \else
		\expandafter\ifx\csname \mw@HeadingType @toc\endcsname\relax
		\MgrWMS@SecTOC@CheckOptionalName{\mw@HeadingLevel}%
    \addcontentsline{toc}{\mw@HeadingType}{%
			\ifHeadingNumbered
				\protect\numberline{\MgrWMS@SecTOC@OptionalHeaderName\MgrWMS@SecCnt@Format{\HeadingNumber}}\fi
				\HeadingTOCText}%
		\else
      \csname \mw@HeadingType @toc\endcsname
    \fi
	\fi
}%
\def\MgrWMS@SecCnt@Format#1{#1.\enspace}% zmiana z \mw@seccntformat (!)
%
\newcommand*\mw@normalheading{%
  \if\mw@HeadingBreakBefore \hrule\@height\z@\nobreak
     \else \addpenalty\@secpenalty \fi
  \addvspace{\csname \mw@HeadingType @preskip\endcsname}%
  \bgroup\language\l@nohyphenation
   \raggedright
   \interlinepenalty\@M
   \normalfont\wmssectsetup
   \csname \mw@HeadingType @head\endcsname
   \@@par
  \egroup
  \ifnum0<%
    \if@twocolumn0\else1\fi
    \if\mw@HeadingWholeWidth0\else1\fi
    \if\mw@HeadingBreakAfter1\else0\fi
  \mw@markandtoc\fi
  \nobreak
  \vskip\csname\mw@HeadingType @postskip\endcsname
  \@afterheading
}
\newcommand*\mw@runinheading{%
    \addvspace{\csname \mw@HeadingType @preskip\endcsname}%
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \bgroup\language\l@nohyphenation
           \normalfont\wmssectsetup
           \csname \mw@HeadingType @head\endcsname
        \egroup
        \mw@markandtoc
        \hspace{\csname\mw@HeadingType @postskip\endcsname}%
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}
}
\let\@titleindent\z@
%
\newcommand*\SetSectionFormatting[5][default]{%
 \def\mw@HeadingRunIn{10}\def\mw@HeadingBreakBefore{10}%
 \def\mw@HeadingBreakAfter{10}\def\mw@HeadingWholeWidth{10}%
 \mw@processflags#1,\relax
 \expandafter\def\csname #2\endcsname{\mw@section{#2}}%
 \expandafter\def\csname #2@preskip\endcsname{#3}%
 \expandafter\def\csname #2@head\endcsname{#4}%
 \expandafter\def\csname #2@postskip\endcsname{#5}%
 \mw@setflags{#2}%
 }
\newcommand*\DeclareSectioningCommand[3][default]{%
  \SetSectionFormatting[#1]{#2}}
\def\mw@processflags#1,#2\relax{%
  \expandafter\ifx\csname sec@@flag@#1\endcsname\relax
        \MgrWMS@Error{Unknown sectioning flag `#1'}{}\else
  \csname sec@@flag@#1\endcsname\fi
  \if,#2,\else \mw@processflags#2\relax \fi
  }
\def\sec@@flag@default{}
\def\sec@@flag@runin{\def\mw@HeadingRunIn{11}}
\def\sec@@flag@breakbefore{\def\mw@HeadingBreakBefore{11}}
\def\sec@@flag@breakafter{\def\mw@HeadingBreakAfter{11}}
\def\sec@@flag@wholewidth{\def\mw@HeadingWholeWidth{11}}
%
% Sklad wlasciwych tytulariow
%----------------------------
%----- podstawowe parametry -----%
\def\MgrWMS@Part@Number{\LARGE\bfseries}
\def\MgrWMS@Part@Name{\huge\bfseries}
\def\MgrWMS@Part@Middle{\@empty}
%
\def\MgrWMS@Chapter@Number{\Large\sffamily\slshape}
\def\MgrWMS@Chapter@Name{\LARGE\sffamily\bfseries}
\def\MgrWMS@Chapter@Middle{\@empty}
%
\def\MgrWMS@Sec@Format{\large}
\def\MgrWMS@SubSec@Format{\normalsize}
\def\MgrWMS@SubSubSec@Format{\normalsize}
\def\MgrWMS@Par@Format{\normalsize}
%
\newcommand*{\SectionStyle}[1]{\renewcommand*\wmssectsetup{#1}}
%----- odstepy w tytulariach  -----%
\newskip\MgrWMS@Part@Before      \newskip\MgrWMS@Part@After
\newskip\MgrWMS@Chapter@Before   \newskip\MgrWMS@Chapter@After
\newskip\MgrWMS@Sec@Before       \newskip\MgrWMS@Sec@After
\newskip\MgrWMS@SubSec@Before    \newskip\MgrWMS@SubSec@After
\newskip\MgrWMS@SubSubSec@Before \newskip\MgrWMS@SubSubSec@After
%
\MgrWMS@Sec@Before=2.95ex plus.3ex minus.2ex       \MgrWMS@Sec@After=1.95ex plus.2ex
\MgrWMS@SubSec@Before=2.35ex plus.2ex minus.1ex    \MgrWMS@SubSec@After=1.35ex plus.15ex
\MgrWMS@SubSubSec@Before=1.75ex plus.1ex minus.1ex \MgrWMS@SubSubSec@After=0.95ex plus.1ex
%
%----- szablony do skladu poszczegolnych tytulariow -----%
% dla czesci
\newcommand{\MgrWMS@Part@Temp@a}{%
	\MgrWMS@Part@Before=0\p@ plus1fil
	\MgrWMS@Part@After=0\p@ plus1fil
	\def\MgrWMS@Part@Middle{\baselineskip}%
	\let\MgrWMS@Part@tempA=\raggedleft
	\def\MgrWMS@Part@tempB{0.7}%
}
\newcommand{\MgrWMS@Part@Header@a}[3]{%
 {\MgrWMS@SingleSpacing
	\if@twoside
		\ifodd\c@page\def\MgrWMS@Part@tempA{\raggedleft}%
		\else\def\MgrWMS@Part@tempA{\raggedright}\fi
	\else\def\MgrWMS@Part@tempA{\raggedleft}\fi
	\MgrWMS@Part@tempA
	\ifHeadingNumbered
		\noindent\normalfont #2\partname\space\HeadingNumber\ignorespaces
		\par%%\vspace{\baselineskip}%
		\noindent\MgrWMS@GrayLine{0.7}{.25\textwidth}{5pt}%
		\par\vspace{#1}%
	\else\fi
	\normalfont #3\HeadingText\par\nobreak
}}
%
\newcommand{\MgrWMS@Part@Temp@b}{%
	\MgrWMS@Part@Before=0\p@ plus1fil
	\MgrWMS@Part@After=0\p@ plus1fil
	\def\MgrWMS@Part@Middle{20\p@}%
}
\newcommand{\MgrWMS@Part@Header@b}[3]{%
 {\MgrWMS@SingleSpacing
	\ifHeadingNumbered
		\centering #2\partname\space\HeadingNumber\par\nobreak
		\vspace{#1}%
  \fi
  \centering #3\HeadingText\par\nobreak
}}
\@ifundefined{MgrWMS@Part@Header@\MgrWMS@Part@type}{%
	\MgrWMS@Error{Naglowek czesci '\MgrWMS@Part@type' nie jest zdefiniowany, 'a' zostanie uzyte!}{}%
	\def\MgrWMS@Part@type{a}}{}%
%
% dla rozdzialow
\newcommand{\MgrWMS@Chapter@FindHalf}[3]{%
	\settoheight{\MgrWMS@dim@a}{#1}%
	\setlength{\MgrWMS@dim@b}{\MgrWMS@dim@a}%
	\addtolength{\MgrWMS@dim@b}{-#2}\divide\MgrWMS@dim@b by 2
	\setlength{#3}{\MgrWMS@dim@b}%
}
\let\mw@hyperref@phantom\@gobble
\newcommand{\MgrWMSChapterFixHyperrefBug}{\@empty}
% chapter a
\newcommand{\MgrWMS@Chapter@Temp@a}{%
	\MgrWMS@Chapter@Before=0pt
	\MgrWMS@Chapter@After=5\baselineskip % bylo 6
	\def\MgrWMS@Chapter@Number{\Large\sffamily\bfseries}%
	\def\MgrWMS@Chapter@Height{8\baselineskip}% bylo 10
	\def\MgrWMS@Chapter@Middle{3\baselineskip}%
	\def\MgrWMS@Chapter@tempA{.5pt}% grubosc linii
	\def\MgrWMS@Chapter@tempB{\rule{.25\linewidth}{\MgrWMS@Chapter@tempA}}%
}
\newcommand{\MgrWMS@Chapter@Header@a}[3]{%
	\MgrWMS@Chapter@FindHalf{#2 RD}{\MgrWMS@Chapter@tempA}{\MgrWMS@dim@c}%
  {\MgrWMS@SingleSpacing
	\parbox[b][\MgrWMS@Chapter@Height][b]{\linewidth}{%
		\vfill
		\ifHeadingNumbered
		\begin{center}%
		\begin{tabular}{@{}c@{}}%
			\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempB}\hspace{.5em}%
			{\normalfont #2\@chapapp\space\HeadingNumber}\ignorespaces%
			\hspace{.5em}\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempB} \\[-.5ex]%
			\hrulefillA{\MgrWMS@Chapter@tempA}%
		\end{tabular}%
		\end{center}\par\nobreak
		\vspace{#1}\fi
		\centering\normalfont #3\HeadingText\par\nobreak}%
}}
% chapter b
\newcommand{\MgrWMS@Chapter@Temp@b}{%
	\MgrWMS@Chapter@Before=-2\baselineskip plus 0.1ex
	\MgrWMS@Chapter@After=5\baselineskip plus 0.5ex
	\def\MgrWMS@Chapter@Middle{10\baselineskip}% bylo 11
	\def\MgrWMS@Chapter@tempA{1.5pt}%
	\def\MgrWMS@Chapter@tempB{0.7}%
	\def\MgrWMS@Chapter@tempC{\MgrWMS@GrayLine{\MgrWMS@Chapter@tempB}{.2\linewidth}{\MgrWMS@Chapter@tempA}}%
}
\newcommand{\MgrWMS@Chapter@Header@b}[3]{%
	\MgrWMS@Chapter@FindHalf{#2 RD}{\MgrWMS@Chapter@tempA}{\MgrWMS@dim@c}%
	\settoheight{\MgrWMS@dim@a}{#2 RD}%
	\settowidth{\MgrWMS@dim@b}{%
		\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempC}%
		\hspace{.5em}{\normalfont #2\@chapapp\space\HeadingNumber}\ignorespaces\hspace{.5em}%
		\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempC}}%
	{\MgrWMS@SingleSpacing
	 \parbox[c][\MgrWMS@Chapter@Middle][b]{\linewidth}{%
   \begin{center}%
		\ifHeadingNumbered
			\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempC}%
			\hspace{.5em}{\normalfont #2\@chapapp\space\HeadingNumber}\ignorespaces\hspace{.5em}%
			\raisebox{\MgrWMS@dim@c}{\MgrWMS@Chapter@tempC}\par
		\vfill\else
			\MgrWMS@GrayLine{\MgrWMS@Chapter@tempB}{\MgrWMS@dim@b}{\MgrWMS@Chapter@tempA}\par
			\vspace{1.75\baselineskip}\vspace{-\MgrWMS@dim@a}\vspace{\MgrWMS@Chapter@tempA}%
		\fi
	{\normalfont #3\HeadingText\par}\nobreak\vspace{0.75\baselineskip}%
	 \MgrWMS@GrayLine{\MgrWMS@Chapter@tempB}{\MgrWMS@dim@b}{\MgrWMS@Chapter@tempA}%
	\end{center}}%
}}
% chapter c
\newcommand{\MgrWMS@Chapter@Temp@c}{%
	\MgrWMS@Chapter@Before=0pt
	\MgrWMS@Chapter@After=5\baselineskip
	\def\MgrWMS@Chapter@Number{\Large\bfseries}%
	\def\MgrWMS@Chapter@Middle{6.4\baselineskip}%
}
\newcommand{\MgrWMS@Chapter@Header@c}[3]{%
  {\MgrWMS@SingleSpacing
	\nointerlineskip
  \vbox to#1{\color@begingroup
    \vfil
    \ifHeadingNumbered
			\normalfont #2\@chapapp\space\HeadingNumber\par\nobreak
			\vspace{\baselineskip}%
    \fi
    \normalfont #3\HeadingText\par\nobreak
    \color@endgroup
  }}%
}
%
%\newcommand{\MgrWMS@Chapter@Temp@<x>}{%
%	\MgrWMS@Chapter@Before=
%	\MgrWMS@Chapter@After=
%	\def\MgrWMS@Chapter@Middle{<X>\baselineskip}
%	\def\MgrWMS@Chapter@tempA{<abc>}
%}
%\newcommand{\MgrWMS@Chapter@Header@<x>}[3]{%
%
%}
\@ifundefined{MgrWMS@Chapter@Header@\MgrWMS@Chapter@type}{%
	\MgrWMS@Error{Naglowek rozdzialu '\MgrWMS@Chapter@type' nie jest zdefiniowany, 'a' zostanie uzyte!}{}%
	\def\MgrWMS@Chapter@type{a}}{}%
%
% dla sekcji
\newcommand{\MgrWMS@Section@Template@Hang}[1]{%
  #1{\@hangfrom{\hskip\@titleindent
     \ifHeadingNumbered\MgrWMS@SecCnt@Format{\HeadingNumber}\fi}%
     \ignorespaces\HeadingText\@@par}%
}
\newcommand{\MgrWMS@Section@Template@NoHang}[1]{%
  \leftskip\@titleindent
  #1{\noindent
  \ifHeadingNumbered\MgrWMS@SecCnt@Format{\HeadingNumber}\fi
  \ignorespaces\HeadingText\@@par}%
}
\newcommand*{\MgrWMS@Section@Template@RunIn}[1]{%
  \hskip\@titleindent
  #1{\ifHeadingNumbered\MgrWMS@SecCnt@Format{\HeadingNumber}\fi
		 \ignorespaces\HeadingText\unskip}%
}
%----- podstawowe parametry  -----%
% part
\csname MgrWMS@Part@Temp@\MgrWMS@Part@type\endcsname
\SetSectionFormatting[breakbefore,breakafter,wholewidth]{part}
  {\MgrWMS@Part@Before}
	{\csname MgrWMS@Part@Header@\MgrWMS@Part@type\endcsname{\MgrWMS@Part@Middle}{\MgrWMS@Part@Number}{\MgrWMS@Part@Name}}
  {\MgrWMS@Part@After}
% chapters
\csname MgrWMS@Chapter@Temp@\MgrWMS@Chapter@type\endcsname
\SetSectionFormatting[breakbefore,wholewidth]{chapter}
  {\MgrWMS@Chapter@Before}
  {\csname MgrWMS@Chapter@Header@\MgrWMS@Chapter@type\endcsname{\MgrWMS@Chapter@Middle}{\MgrWMS@Chapter@Number}{\MgrWMS@Chapter@Name}}
  {\MgrWMS@Chapter@After}
%
\newcommand*\MgrWMS@Chapter@TOC{%
  \ifHeadingNumbered\typeout{\@chapapp\space\thechapter.}\fi
  \addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
			\MgrWMS@SecCnt@Format{\@chapapp\ \HeadingNumber}%
    \fi
    \HeadingTOCText}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
}
% section
\SetSectionFormatting{section}
	{\MgrWMS@Sec@Before}
	{\csname MgrWMS@Section@Template@\MgrWMS@Section@type\endcsname{\MgrWMS@Sec@Format}}
	{\MgrWMS@Sec@After}
% subsection
\SetSectionFormatting{subsection}
	{\MgrWMS@SubSec@Before}
	{\csname MgrWMS@Section@Template@\MgrWMS@Section@type\endcsname{\MgrWMS@SubSec@Format}}
	{\MgrWMS@SubSec@After}
% subsubsection
\SetSectionFormatting{subsubsection}
	{\MgrWMS@SubSubSec@Before}
	{\csname MgrWMS@Section@Template@\MgrWMS@Section@type\endcsname{\MgrWMS@SubSubSec@Format}}
	{\MgrWMS@SubSubSec@After}
% paragraph
\SetSectionFormatting[runin]{paragraph}
  {\bigskipamount}
  {\MgrWMS@Section@Template@RunIn{\MgrWMS@Par@Format}}
  {.5em}
% subparagraph
\SetSectionFormatting[runin]{subparagraph}
  {\medskipamount}
  {\MgrWMS@Section@Template@RunIn{\MgrWMS@Par@Format}}
  {.5em}
%
%
% ==============
%   SKLAD LIST
% ==============
%
% Ustawienia parametrow dla list
% ------------------------------
\newcommand{\MgrWMS@List@SetLeftMarginItem}[1]{%
	\settowidth\MgrWMS@dim@a{#1}%
	\setlength\labelwidth{\MgrWMS@dim@a}%
	\addtolength\labelwidth{\MgrWMS@AddToLabelSep}%
	\setlength\leftmargin{\labelwidth}%
	\addtolength\leftmargin{\labelsep}%
	\ifnum\@itemdepth >1\else
		\ifnum\@enumdepth >0\else
		\addtolength\topsep{\MgrWMS@AddToListTBSpace}%
		\addtolength\leftmargin{\MgrWMS@AddToItemIndent}\fi\fi
}
\newcommand{\MgrWMS@List@SetLeftMarginEnum}{%
	\addtolength\labelwidth{\MgrWMS@AddToLabelSep}%
	\addtolength\leftmargin{\MgrWMS@AddToLabelSep}%
	\ifnum\@enumdepth >1\else
		\ifnum\@itemdepth >0\else
			\addtolength\topsep{\MgrWMS@AddToListTBSpace}%
			\addtolength\leftmargin{\MgrWMS@AddToItemIndent}\fi\fi
}
\setlength\leftmargini{\parindent}
\leftmargin\leftmargini
\setlength\leftmarginii  {\parindent}
\setlength\leftmarginiii {\parindent}
\setlength\leftmarginiv  {\parindent}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{0\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listi{%
	\leftmargin\leftmargini
  \parsep  \z@
  \topsep  .5\baselineskip plus .25\baselineskip minus
           .125\baselineskip
  \itemsep \z@}
\@listi
\def\@listii{%
	\leftmargin\leftmarginii
	\labelwidth\leftmarginii
	\advance\labelwidth-\labelsep
	\topsep  \z@
	\parsep  \z@
	\itemsep \z@}
\def\@listiii{%
	\leftmargin\leftmarginiii
	\labelwidth\leftmarginiii
	\advance\labelwidth-\labelsep
	\itemsep   \z@}
\def\@listiv{%
	\leftmargin\leftmarginiv
	\labelwidth\leftmarginiv
	\advance\labelwidth-\labelsep}
\def\@listv{%
	\leftmargin\leftmarginv
	\labelwidth\leftmarginv
	\advance\labelwidth-\labelsep}
\def\@listvi{%
	\leftmargin\leftmarginvi
	\labelwidth\leftmarginvi
	\advance\labelwidth-\labelsep}
%
% Srodowisko "enumerate"
% -----------------------
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\partopsep\z@ \topsep\z@ %MW, RCz
         \usecounter\@enumctr\def\makelabel##1{##1\hfil}%
				 \MgrWMS@List@SetLeftMarginEnum}%
  \fi}
\newenvironment*{enumerate*}{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\partopsep\topsep \topsep\z@ %MW
         \leftmargin\z@ \labelwidth\z@
         \itemindent\@parindent \advance\itemindent\labelsep
         \usecounter\@enumctr\def\makelabel##1{##1\hfil}}%
  \fi}
{\endlist}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
%
% Srodowisko "itemize"
% ---------------------
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\partopsep\z@ \topsep\z@ %MW, RCz
       \def\makelabel##1{##1\hfil}%
			 \MgrWMS@List@SetLeftMarginItem{\csname\@itemitem\endcsname}}%
  \fi}
\newenvironment*{itemize*}{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\partopsep\topsep \topsep\z@ %MW
      \leftmargin\z@ \labelwidth\z@
      \itemindent\@parindent \advance\itemindent\labelsep
      \def\makelabel##1{##1\hfil}}%
  \fi}
{\endlist}
\newcommand{\labelitemi}{\textbullet}% powrot do kropki w wyliczeniu
\newcommand\labelitemii{\textemdash}
\newcommand\labelitemiii{\textemdash}
\newcommand\labelitemiv{\textemdash}
%
% Pozostale srodowiska listowe
% ----------------------------
%----- description -----%
\newenvironment{description}
{\list{}{\partopsep\topsep \topsep\z@ %MW
  \labelwidth\z@ \itemindent-\leftmargin
  \let\makelabel\descriptionlabel}}
{\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont\bfseries #1}
%----- verse -----%
\newenvironment{verse}{%
	\let\\\@centercr
  \list{}{\itemsep      \z@
    \parsep \medskipamount
    \itemindent   -1.5em%
    \listparindent\itemindent
    \rightmargin  \leftmargin
    \advance\leftmargin 1.5em}%
  \item\relax}
{\endlist}
%----- quotation -----%
\newenvironment{quotation}{%
	\list{}{\listparindent 1.5em%
  \itemindent    \listparindent
  \rightmargin   \leftmargin
  \parsep        \z@ \@plus\p@}%
  \item\relax}
{\endlist}
\newenvironment{quote}{%
	\list{}{\rightmargin\leftmargin}%
	\item\relax}
{\endlist}
%----- kropka po numerze twierdzenia  -----%
\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2.}]\itshape}
\def\@opargbegintheorem#1#2#3{\trivlist
      \item[\hskip \labelsep{\bfseries #1\ #2\ (#3).}]\itshape}
%
%
% ======================================
%   POZOSTALE SRODOWISKA i SPIS TRESCI
% ======================================
%
% 'titlepage', 'appendix', parametry
% -----------------------------------
%----- titlepage -----%
\newenvironment{titlepage}{%
	\cleardoublepage
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse\newpage
  \fi
  \thispagestyle{blank}%
  \setcounter{page}\@ne
}{%
	\if@restonecol\twocolumn \else \newpage \fi
  \if@twoside\else
		\setcounter{page}\@ne
	\fi
}
%----- appendix -----%
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\def\@floatboxreset{%
  \reset@font
  \normalsize
  \@setminipage
  \csname wms\@captype setup\endcsname
}
%
% Srodowiska figure i table
% -------------------------
%----- figure -----%
\newcounter{figure}[chapter]
\renewcommand\thefigure{%
	\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}%
  {\@float{figure}}
  {\end@float}
\newenvironment{figure*}
  {\@dblfloat{figure}}
  {\end@dblfloat}
%
%----- table -----%
\newcounter{table}[chapter]
\renewcommand\thetable{%
	\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
  {\@float{table}}
  {\end@float}
\newenvironment{table*}
  {\@dblfloat{table}}
  {\end@dblfloat}
\def\centeredlast{%
  \let\\\@centercr
  \rightskip\z@\@plus-.5fil
  \leftskip\z@\@plus.5fil
  \parindent\z@
  \parfillskip\@flushglue
}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{.5\baselineskip}
\setlength\belowcaptionskip{.5\baselineskip}
%----- Definicja 'caption' -----%
\newif\ifMgrWMS@CaptionInBox\MgrWMS@CaptionInBoxfalse % czy caption za dlugi...
\newsavebox{\MgrWMS@Caption@Box}
\newcommand{\MgrWMS@Caption@HangText}[1]{%
	\settowidth{\MgrWMS@dim@a}{\wmscaptionsetup #1.\enspace}%
	\setlength{\MgrWMS@dim@b}{\MgrWMS@CaptionSpaceRate\linewidth}%
	\addtolength{\MgrWMS@dim@b}{-\MgrWMS@dim@a}%
}
\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname the#1\endcsname.}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \wmscaptionsetup
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup
}
\long\def\@makecaption#1#2{%
	\settowidth{\MgrWMS@dim@c}{{\wmscaptionsetup\begin{tabular}{@{}l@{}}#1.\enspace#2\end{tabular}}}%
	\ifdim\MgrWMS@dim@c>\MgrWMS@CaptionSpaceRate\linewidth\MgrWMS@CaptionInBoxtrue\else\fi
	\ifMgrWMS@CaptionHang
		\MgrWMS@Caption@HangText{#1}%
	\else\fi
  \addvspace\abovecaptionskip
  \bgroup\centeredlast
		\makebox[0pt][c]{%
			\ifMgrWMS@CaptionInBox
				\parbox[t]{\MgrWMS@CaptionSpaceRate\linewidth}{%
					{\sffamily\bfseries #1:}\enspace
					\ifMgrWMS@CaptionHang
						\parbox[t]{\MgrWMS@dim@b}{#2}%
					\else #2\fi}%
				\else\parbox[t]{\MgrWMS@dim@c}{#1.\enspace#2}\fi
			}\par
  \egroup
  \vskip\belowcaptionskip
}
%
% Definicje fontow w stylu LaTeX-a 2.09
% --------------------------------------
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
%
% Spis tresci
% -----------
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em plus 2cm}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
	{\@tempcnta=\c@tocdepth
   \c@tocdepth=-1
	 \chapter*{\contentsname}%
   \protect\@mkboth{\contentsname}{\contentsname}%
   \c@tocdepth=\@tempcnta
   \secondarysize
   \gdef\previous@toc@level{-1000}%
   \@starttoc{toc}}%
  \if@restonecol\twocolumn\fi
}
\def\mw@tocskip#1#2{%
  \ifnum#1>\previous@toc@level
    \nobreak
  \else\ifnum#1<\previous@toc@level
    \addpenalty\@secpenalty
  \fi\fi
  \gdef\previous@toc@level{#1}%
  \vskip #2\relax
}
\def\mw@tocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \mw@tocskip{#1}{\z@ \@plus.2\p@}%
    {\leftskip #3\relax
     \@tempdima #3\relax
     \advance\@tempdima -#2\relax
     \rightskip \@tocrmarg \parfillskip -\rightskip
     \interlinepenalty\@M
     \noindent\kern-\@tempdima{\ignorespaces #4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont\normalcolor #5}%
     \par}%
  \fi
}
\newcommand*\MgrWMS@SetTOCLabels[1]{%
	\bgroup
		\reset@font\secondarysize
		\setbox\@tempboxa\hbox{}%
		\MgrWMS@SetTOCLabelsX{}#1\relax
  \egroup
}
\def\MgrWMS@SetTOCLabelsX#1#2{%
  \ifx\relax#2\expandafter\@gobble
	\else
		\setbox\@tempboxa\hbox{#2}%
		\expandafter\xdef\csname MgrWMS@TOCLabel#1\endcsname{\the\wd\@tempboxa}%
		\expandafter\MgrWMS@SetTOCLabelsX
  \fi
  {#1I}%
}
\newcommand*\SetTOCIndents[1]{%
	\bgroup
		\reset@font\secondarysize
		\setbox\@tempboxa\hbox{}%
		\set@tocindentsX{}#1\relax
  \egroup
}
\def\set@tocindentsX#1#2{%
  \ifx\relax#2\expandafter\@gobble
	\else
		\setbox\@tempboxa\hbox{\unhbox\@tempboxa#2}%
		\expandafter\xdef\csname @tocindent#1\endcsname{\the\wd\@tempboxa}%
		\expandafter\set@tocindentsX
  \fi
  {#1i}%
}
%
\def\MgrWMS@TOC@PartName@Wd{0pt}
\def\MgrWMS@TOC@ChapterName@Wd{0pt}
\newcommand{\MgrWMS@TOC@DefNameWd}{%
	\reset@font\secondarysize
	\setbox\MgrWMS@box@a\hbox{\MgrWMS@TOC@PartName\space}%
	\def\MgrWMS@TOC@PartName@Wd{\the\wd\MgrWMS@box@a}%
	\setbox\MgrWMS@box@a\hbox{\MgrWMS@TOC@ChapterName A.\enspace}%
	\def\MgrWMS@TOC@ChapterName@Wd{\the\wd\MgrWMS@box@a}%
}
\ifdim\MgrWMS@dim@toc<0\p@
	\SetTOCIndents{{}{A.\enspace}{9.10.\enspace}{9.9.10.\enspace}{9.9.9.10.\enspace}{\quad}{\quad}}%%pierwszy \quad --> wyrzucony [RCz]
	\ifMgrWMS@TOCPartChapter\MgrWMS@TOC@DefNameWd\else\fi
	\def\MgrWMS@TOCIndent@z{\@tocindent}
	\MgrWMS@AddTwoDimOnBoxes{\@tocindenti}{\MgrWMS@TOC@ChapterName@Wd}{MgrWMS@TOCIndent@w}
	\def\MgrWMS@TOCIndent@Iz{\@tocindenti}					\def\MgrWMS@TOCIndent@Iw{\@tocindentii}
	\def\MgrWMS@TOCIndent@IIz{\@tocindentii}				\def\MgrWMS@TOCIndent@IIw{\@tocindentiii}
	\def\MgrWMS@TOCIndent@IIIz{\@tocindentiii}			\def\MgrWMS@TOCIndent@IIIw{\@tocindentiiii}
	\def\MgrWMS@TOCIndent@IVz{\@tocindentiiii}		\def\MgrWMS@TOCIndent@IVw{\@tocindentiiiii}
	\def\MgrWMS@TOCIndent@Vz{\@tocindentiiiii}	\def\MgrWMS@TOCIndent@Vw{\@tocindentiiiiii}
\else
	\MgrWMS@SetTOCLabels{{}{A.\enspace}{9.10.\enspace}{9.9.10.\enspace}{9.9.9.10.\enspace}{\quad}{\quad}}%
	\ifMgrWMS@TOCPartChapter\MgrWMS@TOC@DefNameWd\else\fi
	\def\MgrWMS@TOCIndent@z{0pt}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOC@ChapterName@Wd}{\MgrWMS@TOCLabelI}{MgrWMS@TOCIndent@w}
	\def\MgrWMS@TOCIndent@Iz{\MgrWMS@dim@toc}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@Iz}{\MgrWMS@TOCLabelII}{MgrWMS@TOCIndent@Iw}
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@Iz}{\MgrWMS@dim@toc}{MgrWMS@TOCIndent@IIz}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IIz}{\MgrWMS@TOCLabelIII}{MgrWMS@TOCIndent@IIw}
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IIz}{\MgrWMS@dim@toc}{MgrWMS@TOCIndent@IIIz}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IIIz}{\MgrWMS@TOCLabelIIII}{MgrWMS@TOCIndent@IIIw}
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IIIz}{\MgrWMS@dim@toc}{MgrWMS@TOCIndent@IVz}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IVz}{\MgrWMS@TOCLabelIIIII}{MgrWMS@TOCIndent@IVw}
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@IVz}{\MgrWMS@dim@toc}{MgrWMS@TOCIndent@Vz}
		\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@TOCIndent@Vz}{\MgrWMS@TOCLabelIIIIII}{MgrWMS@TOCIndent@Vw}
\fi
%
\def\numberline#1{\hb@xt@\@tempdima{#1\hfil}\ignorespaces}
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \mw@tocskip{-1}{.6\baselineskip}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode\normalsize
        \def\numberline##1{##1\enspace}%
        \hfil\bfseries #1\hfil\null %\hb@xt@\@pnumwidth{\hss #2}%
			}\par
      \nobreak
      \global\@nobreaktrue
      \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
	\addvspace{.4\baselineskip}%
	\fi
}
\newcommand*\l@chapter[2]{%
	\addvspace{.3\baselineskip}%
  \mw@tocline{0}{\MgrWMS@TOCIndent@z}{\MgrWMS@TOCIndent@w}{\textbf{#1}}{#2}%
  \addvspace{.2\baselineskip}%
}
\newcommand*\l@section{\mw@tocline{1}{\MgrWMS@TOCIndent@Iz}{\MgrWMS@TOCIndent@Iw}}
\newcommand*\l@subsection{\mw@tocline{2}{\MgrWMS@TOCIndent@IIz}{\MgrWMS@TOCIndent@IIw}}
\newcommand*\l@subsubsection{\mw@tocline{3}{\MgrWMS@TOCIndent@IIIz}{\MgrWMS@TOCIndent@IIIw}}
\newcommand*\l@paragraph{\mw@tocline{4}{\MgrWMS@TOCIndent@IVz}{\MgrWMS@TOCIndent@IVw}}
\newcommand*\l@subparagraph{\mw@tocline{5}{\MgrWMS@TOCIndent@Vz}{\MgrWMS@TOCIndent@Vw}}
%
% streszczenie, abstract i wstep
% ------------------------------
\def\MgrWMS@Abs@Headers{\wmssectsetup\MgrWMS@Sec@Format}
\def\MgrWMS@Abs@Keyword{\normalfont\normalsize}
\newcommand{\MgrWMS@Abs@Wciecie}[3]{%
	\begin{list}{}{%
		\setlength{\leftmargin}{#1}\setlength{\rightmargin}{#2}\item[]\relax}%
		#3%
	\end{list}}
\newenvironment{MgrMWS@Abstract}[3]{%
	\chapter*{#1}%
  \renewcommand\thesection{\@arabic\c@section}%
	\def\MgrMWS@AbstractName{#2}%
	\def\MgrMWS@AbstractContent{\noindent #3}%
}{%
	\par\bigskip
  \noindent{\MgrWMS@Abs@Headers\MgrMWS@AbstractName}%
  \nopagebreak\par\smallskip\nopagebreak%
  \ifMgrWMS@oldlayout
		\MgrWMS@Abs@Wciecie{0pt}{0pt}{\MgrWMS@Abs@Keyword\MgrMWS@AbstractContent}%
  \else
		{\MgrWMS@Abs@Keyword\MgrMWS@AbstractContent}%
	\fi
	\setcounter{section}{0}%
	\renewcommand\thesection{\thechapter.\@arabic\c@section}%
}
\newenvironment{streszczenie}{\begin{MgrMWS@Abstract}{Streszczenie}{S{\PL@l}owa kluczowe}{\MgrWMS@SlowaKluczowe}}{\end{MgrMWS@Abstract}}
\newenvironment{abstract}{\begin{MgrMWS@Abstract}{Abstract}{Keywords}{\MgrWMS@Keywords}}{\end{MgrMWS@Abstract}}
%
\newenvironment{MgrWMS@wstep}[1]{%
	\chapter*{#1}%
	\renewcommand\thesection{\@arabic\c@section}%
}{%
	\setcounter{section}{0}%
  \renewcommand\thesection{\thechapter.\@arabic\c@section}%
}
%
\newenvironment{wstep}[1][Wst{\PL@e}p]{\begin{MgrWMS@wstep}{#1}}{\end{MgrWMS@wstep}}
\newenvironment{zakonczenie}[1][Zako{\PL@n}czenie]{\begin{MgrWMS@wstep}{#1}}{\end{MgrWMS@wstep}}
%
% Spis rysunkow
% --------------
\newcommand\listoffigures{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\listfigurename}{%
		\secondarysize
    \gdef\previous@toc@level{-1000}%
    \@starttoc{lof}}%
  \if@restonecol\twocolumn\fi
}
\newcommand*\l@figure{\mw@tocline{1}{0pt}{2.5em}}
%
% Spis tabel
% -----------
\newcommand\listoftables{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\listtablename}{%
		\secondarysize
    \gdef\previous@toc@level{-1000}%
    \@starttoc{lot}}%
  \if@restonecol\twocolumn\fi
}
\let\l@table\l@figure
%
% Bibliografia
% -------------
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]{%
	\def\chaptermark##1{\@mkboth{##1}{##1}}%
	\chapter*{\bibname}%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
		\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
    \secondarysize}%
	\sloppy
	\sfcode`\.\@m
}{%
	\def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
%
% Indeks/Skorowidz
% ----------------
\newenvironment{theindex}{%
	\if@twocolumn
		\@restonecolfalse
	\else
		\@restonecoltrue
  \fi
  \columnseprule \z@
  \columnsep 35\p@
  \twocolumn
	\chapter*{\indexname}%
	\StartMyLeftHeader{\indexname}%
  \thispagestyle{wmsplain}\parindent\z@%
	\parskip\z@ \@plus .3\p@\relax
  \let\item\@idxitem
  \secondarysize
}{%
	\if@restonecol\onecolumn\else
		\clearpage
	\fi\MgrMWS@RestoreHeaderDef
}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
%
% Sklad przypisow
% ----------------
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@height.3\p@\@width60\p@
  \kern2.6\p@}
\ifMgrWMS@FootnoteResetbyCh
	\@addtoreset{footnote}{chapter}
\else
	\MgrMWS@RemoveFromReset{footnote}{chapter}
\fi
\ifMgrWMS@Footnote
	\newcommand{\MgrWMS@Footnote@Mark}{\@thefnmark.}
\else
	\newcommand{\MgrWMS@Footnote@Mark}{\@makefnmark}
\fi
\newcommand\@makefntext[1]{%
	\parindent\@parindent
	\noindent\hb@xt@\@parindent{\hss\MgrWMS@Footnote@Mark\enspace}#1}
%
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
%
%
% ===================
%   SUPLEMENT KLASY
% ===================
%
% Okladka plyt CD
% ----------------
%----- Pomocnicze komendy -----%
\newsavebox{\MgrWMS@CD@CoverBox}
\newsavebox{\MgrWMS@CD@HeadBox}
\newif\ifMgrWMS@CD@Frame\MgrWMS@CD@Frametrue
%----- Wymiary Okladki -----%
\def\MgrWMS@CD@OuterHeight{12cm}
\def\MgrWMS@CD@OuterWidth{12cm}
\def\MgrWMS@CD@TBMargin{0cm} % top + bottom margins (!)
\def\MgrWMS@CD@LRMargin{1cm} % left + right margins (!)
%----- Rozmiary i definicje fontow -----%
\def\MgrWMS@CD@TitleFnt{\Large\sffamily\bfseries}
\def\MgrWMS@CD@AuthorFnt{\large}
\def\MgrWMS@CD@HeadFnt{\small}
\def\MgrWMS@CD@NormalFnt{\normalsize}
\def\MgrWMS@CD@SmallFnt{\small}
%
\def\MgrWMS@CD@Text{Wersja elektroniczna}
\def\MgrWMS@CD@FrameRule{.4\p@}
\define@key{MgrWMSCD}{cdtext}{\def\MgrWMS@CD@Text{#1}}
\define@key{MgrWMSCD}{cdframe}{\MgrWMS@Expand@Key@Boolean{cdframe}{true}{#1}{MgrWMS@CD@Frame}}
\define@key{MgrWMSCD}{cdframerule}{\def\MgrWMS@CD@FrameRule{#1}}
\define@key{MgrWMSCD}{cdheight}{\def\MgrWMS@CD@OuterHeight{#1}}
\define@key{MgrWMSCD}{cdwidth}{\def\MgrWMS@CD@OuterWidth{#1}}
\define@key{MgrWMSCD}{cdtbmargin}{\def\MgrWMS@CD@TBMargin{#1}}
\define@key{MgrWMSCD}{cdlrmargin}{\def\MgrWMS@CD@LRMargin{#1}}
\define@key{MgrWMSCD}{cdnormalfnt}{\def\MgrWMS@CD@NormalFnt{#1}}
\define@key{MgrWMSCD}{cdsmallfnt}{\def\MgrWMS@CD@SmallFnt{#1}}
\define@key{MgrWMSCD}{cdtitlefnt}{\def\MgrWMS@CD@TitleFnt{#1}}
\define@key{MgrWMSCD}{cdauthorfnt}{\def\MgrWMS@CD@AuthorFnt{#1}}
\define@key{MgrWMSCD}{cdheadfnt}{\def\MgrWMS@CD@HeadFnt{#1}}
%----- Naglowek w okladce CD -----%
\begin{lrbox}{\MgrWMS@CD@HeadBox}{%
	\MgrWMS@CD@HeadFnt
	\begin{tabular}[b]{@{}c@{}}%
		Akademia Gorniczo-Hutnicza \\
	  im. Stanislawa Staszica w Krakowie \\[\smallskipamount]
	  Wydzial Matematyki Stosowanej
	\end{tabular}}%
\end{lrbox}%
\settoheight{\MgrWMS@dim@cdbox}{\usebox{\MgrWMS@CD@HeadBox}}
%
\newcommand{\MgrMWSOkladkaCD}[1][]{{%
	\setkeys{MgrWMSCD}{#1}%
	\def\MgrWMS@Temp@Symb{N}%
  \if\MgrWMS@sizesymbol\MgrWMS@Temp@Symb\relax
	\else\MgrWMS@SizeDef@N\fi
	\MgrWMS@SingleSpacing
  \hyphenpenalty=10000
	\ifMgrWMS@CD@Frame\relax\else
		\def\MgrWMS@CD@OuterHeight{12.5cm}%
		\def\MgrWMS@CD@OuterWidth{12.5cm}%
		\def\MgrWMS@CD@TBMargin{0.5cm}% top + bottom margins (!)
		\def\MgrWMS@CD@LRMargin{1cm}% left + right margins (!)
	\fi
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@CD@OuterHeight}{-\MgrWMS@CD@TBMargin}{MgrWMS@CD@InnerHeight}%
	\MgrWMS@AddTwoDimOnBoxes{\MgrWMS@CD@OuterWidth}{-\MgrWMS@CD@LRMargin}{MgrWMS@CD@InnerWidth}%
	\begin{lrbox}{\MgrWMS@CD@CoverBox}%
		\begin{minipage}[c][\MgrWMS@CD@OuterHeight][c]{\MgrWMS@CD@OuterWidth}%
		\begin{center}%
			\begin{minipage}[c][\MgrWMS@CD@InnerHeight][c]{\MgrWMS@CD@InnerWidth}%
			\begin{center}%
			\setlength{\parindent}{0pt}%
			\vspace{0.6\baselineskip}%
			\raisebox{-1pt}[\MgrWMS@dim@cdbox][0pt]{\includegraphics[height=1.1\MgrWMS@dim@cdbox]{\MgrWMS@LogoAGH}}\quad
			{\MgrWMS@CD@HeadFnt
			 \begin{tabular}[b]{@{}c@{}}%
				Akademia G{\PL@o}rniczo-Hutnicza \\
				im. Stanis{\PL@l}awa Staszica w Krakowie \\[\smallskipamount]
				Wydzia{\PL@l} Matematyki Stosowanej
			 \end{tabular}}\quad
			\raisebox{3pt}{\includegraphics[height=.7\MgrWMS@dim@cdbox]{\MgrWMS@LogoWMS}}\par
			\vspace{-1.3\smallskipamount}%
			\noindent\rule{\MgrWMS@CD@InnerWidth}{1.75pt}\\[-11.366pt]
			\noindent\MgrWMS@GrayLine{0.4}{\MgrWMS@CD@InnerWidth}{1pt}\par
			 \vspace{1.25\baselineskip}%
			{\MgrWMS@CD@NormalFnt Praca magisterska\par\smallskip}%
			{\MgrWMS@CD@SmallFnt \MgrWMS@CD@Text\par}%
			 \vspace*{1.5\baselineskip}%
			{\MgrWMS@CD@TitleFnt\@title\par}%
			 \vspace{1.5\baselineskip}%
			{\MgrWMS@CD@AuthorFnt\@author\par}%
			\vfill
			{\MgrWMS@CD@NormalFnt Nr albumu: \MgrWMS@NrAlbumu}\hfill
				 \begin{tabular}[b]{@{}l@{}}%
	     {\MgrWMS@CD@SmallFnt Promotor} \\
			 {\MgrWMS@CD@NormalFnt\MgrWMS@Promotor}%
	    \end{tabular}\par
			\noindent\MgrWMS@GrayLine{0.4}{\MgrWMS@CD@InnerWidth}{1pt}\\[-10.616pt]
			\noindent\rule{\MgrWMS@CD@InnerWidth}{1.75pt}\\[.5\smallskipamount]
			{\MgrWMS@CD@NormalFnt Krak{\PL@o}w \number\year}\par\vspace*{\bigskipamount}%
			\end{center}\end{minipage}%
		\end{center}\end{minipage}%
	\end{lrbox}%
	\ifMgrWMS@CD@Frame{%
		\setlength{\fboxsep}{0pt}%
		\setlength{\fboxrule}{\MgrWMS@CD@FrameRule}%
		\fbox{\usebox{\MgrWMS@CD@CoverBox}}}%
	\else
		\usebox{\MgrWMS@CD@CoverBox}%
	\fi
}}
%
% Pozostale polecenia
% --------------------
% dla kompatybilnosci z poprzednimi wersjami
\newcommand*\mgrclosechapter{\@empty}
%
% Czesc koncowa klasy
% --------------------
\pagestyle{wmsheadings}%
\pagenumbering{arabic}%
\flushbottom
\if@twocolumn
  \twocolumn
  \sloppy
\else
  \onecolumn
\fi
\AtBeginDocument{%
%----- Patch dla natbib.sty -----%
\@ifpackageloaded{natbib}{%
\renewcommand\bibsection{\chapter*{\bibname}%
  \@mkboth{\bibname}{\bibname}}%
}{}%
%----- Patch dla hyperref.sty -----%
\@ifpackageloaded{hyperref}{%
	\def\mw@hyperref@phantom#1{%
		\Hy@GlobalStepCount\Hy@linkcounter
		\xdef\@currentHref{#1*.\the\Hy@linkcounter}%
    \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
	}%
	\long\def\@caption#1[#2]#3{%
		\hyper@makecurrent{\@captype}%
		\def\@currentlabelname{#2}%
		\par\addcontentsline{\csname ext@#1\endcsname}{#1}{%
			\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
		\begingroup
			\@parboxrestore
			\if@minipage
				\@setminipage
			\fi
			\wmscaptionsetup
			\@makecaption{\csname fnum@#1\endcsname}{%
				\ignorespaces
				\makebox[0pt][l]{\ifHy@nesting
					\hyper@@anchor{\@currentHref}{#3}%
				\else
					\Hy@raisedlink{\hyper@@anchor{\@currentHref}{\relax}}}#3%
				\fi}%
			\par
		\endgroup
	}%
	\renewcommand{\MgrWMSChapterFixHyperrefBug}{\clearpage\phantomsection}%
}{}%
}
\def\@doendpe{\@endpetrue
  \clubpenalty\@clubpenalty
  \def\par{\@restorepar\everypar{}\par\@endpefalse}%
  \everypar{{\setbox\z@\lastbox}\everypar{}\@endpefalse}%
}
%%
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\endinput
%%
%%====================================================================%
%% End of file `mgrwms.cls'.
%% (c) 2008-2010 by Rafal Czarny
