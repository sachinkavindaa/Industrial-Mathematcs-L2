% -*- compile-command: "texify --pdf --quiet AAVL_abstract.tex" -*-
% The above must be the first line
%------------------------------------------------------------------------------
% A A V L --   LaTeX2e class for AAVL, 2009 onwards
%------------------------------------------------------------------------------
% REVISION HISTORY
% 0.00 2007-03-29  Adrian F. Clark <alien/at/essex.ac.uk>
%      Original version.
% 0.01 2007-05-01  Adrian F. Clark <alien/at/essex.ac.uk>
%      Increase \headsep and tweak headline following comments from Roy Davies.
% 0.02 2008-10-01  Andrew Fitzgibbon <awf/at/microsoft.com>
%      Changes for BMVC
% 0.03 2009-06-19  Andrew Fitzgibbon <awf/at/microsoft.com>
%      Added extended abstract for BMVC
% 0.04 2009-06-22  Andrew Fitzgibbon <awf/at/microsoft.com>
%      Remove ``References'' from before bibliography
% 0.05 2009-06-22  Andrew Fitzgibbon <awf/at/microsoft.com>
%      Add pdfcatalog entry to display 2-up
% 0.06 2010-01-29  Alan Woodland <ajw/at/aber.ac.uk>
%      Bump year to 2010
% 0.07 2010-07-06  Andrew Fitzgibbon <awf/at/microsoft.com>
%      Add DOI
% 0.08 2011-03-01 Stephen McKenna <stephen/at/computing.dundee.ac.uk>
%      Change year to 2011
% 0.09 2011-04-07 Oliver Woodford <o.j.woodford.98/at/cantab.net>
%      Changed to use default mathcal font
%      Change year to 2011
% 0.10 2012-04-17 John Collomosse <j.collomosse/at/surrey.ac.uk>
%      Change year to 2012
% 0.10 2016-04-25 Dinesh Jayaraman <dineshj/at/cs.utexas.edu>
%      Adapting for AAVL workshop, ECCV 2016
%------------------------------------------------------------------------------
% Copyright 2007 Adrian F. Clark <alien/at/essex.ac.uk>.  All rights reserved.
%------------------------------------------------------------------------------

% Notes on reading this file:
%
% 1.
% Private identifiers begin with AAVL@, identifiers intended for use by
% the authors are of two kinds: identifiers typically exported by
% ``article'' classes such as \addauthor, \maketitle, or \addinstitution;
% additional useful tools such as \AAVLOneDot, \AAVLHangBox, etc.
%
% 2.
% Lines ending with apparently innocuous comments are common in TeX
% source, because without them, spaces are inserted into the output.
% In this file I've tried to make these ``important'' comments begin
% with %^, to indicate that they have a structural purpose.  We use
% ^ because it's easy to type shift-56, and the ^ looks like an
% ``insert'' marker.
%
% 3.
% Debugging tips:
% \tracingmacros=1 % xx check this is unset before release...
%\def\AAVL@pdfcompresslevel{\global\pdfcompresslevel=0}  % xx this should also be unset for release
\let\AAVL@pdfcompresslevel=\relax  % xx this should also be unset for release

\newif\ifAAVL@pdf
\AAVL@pdffalse
\ifx\pdfoutput\undefined
\else
  \ifx\pdfoutput\relax
  \else
    \ifcase\pdfoutput
    \else
      \AAVL@pdftrue
    \fi
  \fi
\fi


%% Change the year...
\def\AAVL@year{2016}

%% -- CLASS FILE BOILERPLATE --

\def\fileversion{0.01}
\def\filedate{2016/04/25}

\newif\ifAAVL@extabs
\AAVL@extabsfalse

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{AAVL}[\filedate\space AAVL Proceedings. v\fileversion]
\DeclareOption{extendedabs}{\AAVL@extabstrue}

\newif\ifAAVL@review
\AAVL@reviewfalse

\def\AAVL@papernumber{??}
\def\AAVLreviewcopy#1{\AAVL@reviewtrue\global\def\AAVL@papernumber{#1}}

% We're based on the article class.
\ProcessOptions
\ifAAVL@extabs
% Extended abstract: one page,
\LoadClass[a4paper,twoside]{article}
\renewcommand{\normalsize}{\fontsize{9}{11pt}\selectfont}
\renewcommand{\small}{\fontsize{8}{9pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize{7}{8pt}\selectfont}
\renewcommand{\scriptsize}{\fontsize{6}{8.5pt}\selectfont}
\renewcommand{\tiny}{\fontsize{5.5}{6.5pt}\selectfont}
\renewcommand{\large}{\fontsize{10}{12pt}\selectfont}
\renewcommand{\Large}{\fontsize{11}{12.5pt}\selectfont}
\renewcommand{\LARGE}{\fontsize{12}{14pt}\selectfont}
\renewcommand{\huge}{\fontsize{14}{16pt}\selectfont}
\renewcommand{\Huge}{\fontsize{16}{18pt}\selectfont}

\newcommand{\AAVL@titlesize}{\fontsize{11.5}{12.5pt}\selectfont}
\twocolumn

\else
\LoadClass[10pt,twoside]{article}
\newcommand{\AAVL@titlesize}{\LARGE}
\fi

%% -- USEFUL PACKAGES --
\RequirePackage{color}
\RequirePackage{graphicx,subfigure}
\RequirePackage{xspace}
\RequirePackage{eso-pic}
\ifAAVL@extabs
% no need for hyperref in a 1-pager, but we do want urlstyle
\RequirePackage{url}
\else
\RequirePackage[colorlinks,urlcolor=blue,citecolor=red,bookmarks=false]{hyperref}
\AAVL@pdfcompresslevel % reset as hyperref mucks it (of course..)
\fi

\DeclareUrlCommand\AAVLUrl{\urlstyle{sf}}

\usepackage{amsmath}

%% -- USER-VISIBLE MACROS --

%% \AAVLOneDot{e.g}
% Add a period to the end of an abbreviation unless there's one
% already, then \xspace.
\DeclareRobustCommand\AAVLOneDot{\futurelet\@let@token\AAVL@onedotaux}
\def\AAVL@onedotaux{\ifx\@let@token.\else.\null\fi\xspace}

%% \AAVLCenterBox{Line 1\\Line 2}
% Center lines in a box.  This expands its argument twice, so any side
% effects (e.g. incrementing a counter) will be observed twice
\newbox\AAVL@CenterBoxtmp
\def\AAVLCenterBox#1{%^
 % First measure the width
 \setbox\AAVL@CenterBoxtmp\hbox{%^
   \begin{minipage}{2\textwidth}%^
     \begin{tabbing}#1\end{tabbing}%^
   \end{minipage}}%^
 % And then make the minipage
 \begin{minipage}[t]{\wd\AAVL@CenterBoxtmp}%^
   \begin{center}#1\end{center}%^
 \end{minipage}}

%% \AAVLHangBox{Text}
% Proper hanging from top o f first line, not bottom.  i.e.
%   \AAVL@hang{\epsfbox{pic1.ps}}\AAVL@hang{\epsfbox{pic2.ps}}
% will produce
%   -----  -----
%   | 1 |  | 2 |
%   -----  |   |
%          -----
%
%

\def\AAVLHangBox#1{%^
\begin{minipage}[t]{\textwidth}% Top-hanging minipage, will align on
			       % bottom of first line
\begin{tabbing} % tabbing so that minipage shrinks to fit
~\\[-\baselineskip] % Make first line zero-height
#1 % Include user's text
\end{tabbing}%^
\end{minipage}} % can't allow } onto next line, as {WIDEBOX}~x will not tie.


\def\AAVLBaselineHangBox#1{%^
\begin{minipage}[t]{\textwidth}% Top-hanging minipage, will align on
			       % bottom of first line
\begin{tabbing} % tabbing so that minipage shrinks to fit
#1 % Include user's text
\end{tabbing}
\end{minipage}} % can't allow } onto next line, as {WIDEBOX}~x will not tie.

%%  --  PAGE LAYOUT  --
\ifAAVL@extabs
% Extended abstract:
% A single A4 page, for printed abstract booklet. Pages are centered
% horizontally, as they will be shifted left and right at print time.
\RequirePackage[twoside,headsep=3mm,a4paper,inner=11mm,outer=11mm,top=3mm,includehead,bottom=8mm,heightrounded]{geometry}
\columnsep=3mm
\else
% Proceedings:
% This format is designed with on-screen reading in mind.  This means that
% a single-column format is required, to avoid panning between text and
% figures.  However, a single-column format with very long lines wastes
% space and is hard to read, so this format uses a narrow page which is
% readable either 1-up on a low res monitor, or 2-up on a high-resolution
% display.
%
% For printing, setting the PDF reader to an appropriate combination of
% centering, scaling, and number of pages yields a variety of useful
% formats, for example:
%   1-up, centred:  A format very like the old BMVC or Springer LNCS (ECCV).
%   1-up, scaled:   A large-print format, for the visually impaired.
%   2-up, scaled:   A compact paper-saving format without loss of font size.
% If we had kept the old margins, only the first of these is possible.

% Page width is 70 characters, i.e. about 70 * 6pt,
% Page height is 3/2 times the width, so two can fit side-by-side on a 4x3 monitor
% 16/9 monitors can use the space to the sides for notes.
% xx talk about notes
\RequirePackage[twoside,headsep=3mm,papersize={410pt,620pt},inner=9mm,outer=6mm,top=3mm,includehead,bottom=5mm,heightrounded]{geometry}
\ifAAVL@pdf
% Default view is 2-up to emphasize that this is the intended view
% for on-screen reading
\pdfcatalog{/PageLayout /TwoColumnLeft}
\fi
\fi

% Set up the fonts.

\RequirePackage[T1]{fontenc}
\RequirePackage{mathptmx}
\RequirePackage{helvet,courier}
\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INTERNALS

% xx
% pdfTeX warning (ext4): destination with the same identifier
% (name{}) has been already used, duplicate ignored
%

% Debug flag: set to 1 to see boxes around authors/insts
\let\AAVLdebug=0
\newif\ifAAVLdebug
\ifx\AAVLdebug 1
\AAVLdebugtrue
\else
\AAVLdebugfalse
\fi

% Colours for debugging
\ifAAVLdebug
\definecolor{AAVL@PaleBlue}{rgb}{.7,.7,1}
\definecolor{AAVL@PalePink}{rgb}{1,.7,.7}
\else
\definecolor{AAVL@PaleBlue}{rgb}{1,1,1}
\definecolor{AAVL@PalePink}{rgb}{1,1,1}
\fi

\definecolor{AAVL@sectioncolor}{rgb}{0,.1,.4}
\definecolor{AAVL@captioncolor}{rgb}{0,0,.4}

\ifAAVLdebug
\message{AAVL style file debugging on}
\fi

%% AAVL@edefappend -- expand token list and append to macro #1
\newtoks\AAVL@toks
\def\AAVL@edefappend#1#2{%^
  \AAVL@toks = \expandafter{#1}%^
  \xdef#1{\the\AAVL@toks #2}%^
}

%% Useful macros for named boxes and counters

% named boxes
\def\AAVL@newbox#1{\expandafter \newbox \csname AAVL@box #1 \endcsname}
\def\AAVL@sbox#1#2{\expandafter \sbox \csname AAVL@box #1 \endcsname {#2}}
\def\AAVL@savenewbox#1#2{\AAVL@newbox{#1}\AAVL@sbox{#1}{#2}}
\def\AAVL@unhbox#1{\expandafter\unhbox \csname AAVL@box #1 \endcsname}
\def\AAVL@usebox#1{\expandafter\usebox \csname AAVL@box #1 \endcsname}

% named counters
\def\AAVL@newcount#1{\expandafter \newcount \csname AAVL@cnt #1 \endcsname}
\def\AAVL@setcountaux#1#2{#1=#2}
\def\AAVL@setcount#1#2{\expandafter \AAVL@setcountaux \csname AAVL@cnt #1 \endcsname {#2}}
\def\AAVL@thecount#1{\expandafter \the \csname AAVL@cnt #1 \endcsname}

% struts
% These are visible in debug mode
\ifAAVLdebug
\def\AAVL@strut{\rule{0.1pt}{1ex}\hspace{-0.1pt}}
\else
\def\AAVL@strut{\rule{0pt}{1ex}}
\fi

%% Generic List Map
\let\AAVL@endstop=\relax

% AAVL@maplistaux -- macro \AAVL@action is called with each token in list up to
% next \AAVL@endstop, calling macro \AAVL@between between items.
\def\AAVL@maplistaux#1{%^
 \AAVL@action{#1}%^
 \@ifnextchar\AAVL@endstop{\@gobble}{\AAVL@between\AAVL@maplistaux}%^
}

% executing \between between each

% e.g. \AAVL@maplist\fbox{-o-}{{fred}{una}{conor}}

% reminder of ~ catcodes
% \catcode`\~=12  \def~{\char`~}  % code is ``7E

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR AND INSTITUTION HANDLING

%% AAVLResetAuthors -- Empty author/institution lists for testing
\def\AAVLResetAuthors{
  \AAVL@nauthors=0
  \AAVL@ninsts=0
  \edef\AAVL@auths{}
  \edef\AAVL@insts{}
  \gdef\maketitle{\AAVL@maketitle}
}

% We will explictly count the authors in AAVL@nauthors
% just to keep the code a bit clearer
\newcount\AAVL@nauthors
\AAVL@nauthors=0

% AAVL@ninsts -- Number of institutions
\newcount\AAVL@ninsts
\AAVL@ninsts=0

% AAVL@auths -- stores the author ids as a list of length n
\edef\AAVL@auths{}

% AAVL@insts -- stores the institutions as a list of length n
\edef\AAVL@insts{}

% \AAVL@RenderAuthorName -- Place the author's name in a box
\def\AAVL@RenderAuthorName#1{%^
  \sffamily\normalsize #1}

% \AAVL@RenderAuthorNameFN -- Place the author's name in a box with a footnotemark
\def\AAVL@RenderAuthorNameFN#1#2{%^
  \sffamily\normalsize #1$^{\mbox{\sffamily\scriptsize #2}}$}

% \AAVL@RenderAuthorMail -- Place the author's mail/www in a box
\def\AAVL@RenderAuthorMail#1{%^
  \small\textcolor{AAVL@sectioncolor}{\AAVLUrl{#1}}}

% \addauthor{Name}{email/homepage}{INSTITUTION_CODE}
\def\addauthor#1#2#3{%^
  \advance\AAVL@nauthors1
  \AAVL@savenewbox{authname\the\AAVL@nauthors}{\AAVL@RenderAuthorName{#1}}
  \AAVL@savenewbox{authnameFN\the\AAVL@nauthors}{\AAVL@RenderAuthorNameFN{#1}{#3}}
  \AAVL@savenewbox{authmail\the\AAVL@nauthors}{\AAVL@RenderAuthorMail{#2}}
  \AAVL@newcount{authinst\the\AAVL@nauthors}
  \AAVL@setcount{authinst\the\AAVL@nauthors}{#3}
  \AAVL@edefappend{\AAVL@auths}{\the\AAVL@nauthors}
}

% \AAVL@RenderInst{Name\\Address}
% Display an institution address
\def\AAVL@RenderInst#1{%^
   \begin{minipage}[t]{0.48\textwidth}
    \sffamily
    \begin{raggedright}
     #1
    \end{raggedright}
   \end{minipage}}

% \addinstitution{Name\\Address}
% This creates two display boxes: one with footnotemark,
% and one without. We make the boxes now so that we can
% deal with them without worrying about subsequent macro
% expansion.
\long\def\addinstitution#1{
  \advance\AAVL@ninsts1
  \AAVL@savenewbox{inst\the\AAVL@ninsts}{\AAVL@RenderInst{#1}}
  \AAVL@savenewbox{instFN\the\AAVL@ninsts}{%^
    \sffamily$\rule{0pt}{1ex}^{\mbox{\scriptsize \the\AAVL@ninsts}}\,$%^
    \hbox{\AAVL@RenderInst{#1}}}
  \AAVL@edefappend{\AAVL@insts}{\the\AAVL@ninsts}
}

\ifAAVL@extabs
\def\AAVL@RAIspace{\hspace*{4pt}}
\else
\def\AAVL@RAIspace{}
\fi

% \AAVL@RenderAuthInstTwoColumn
% Display authors on left and institutions on right
% Add footnotes if
\def\AAVL@RenderAuthInstTwoColumn{
% Use footnotes if more than one institution
% In future, one might be cleverer if the author order and
% institution order are both ascending
\ifnum\AAVL@ninsts>1
 \def\AAVL@FN{FN}
\else
 \def\AAVL@FN{}
\fi
% A minipage for the authors, on the left
\begin{minipage}[t]{0.49\textwidth}
 \def\AAVL@action##1{%^
  \AAVL@unhbox{authname\AAVL@FN##1}\\
  \AAVL@unhbox{authmail##1}}
 \def\AAVL@between{\\[3pt]}
 \expandafter\AAVL@maplistaux\AAVL@auths\AAVL@endstop
\end{minipage}
\AAVL@RAIspace\hfill%^
% A minipage for the institutions, on the right
\begin{minipage}[t]{0.48\textwidth}
 \def\AAVL@action##1{%^
  \AAVL@unhbox{inst\AAVL@FN##1}}
 \def\AAVL@between{\\[4pt]}
 \expandafter\AAVL@maplistaux\AAVL@insts\AAVL@endstop
\end{minipage}
}

% \AAVL@RenderAuthInstTable
% Display authors on left and institutions on right,
% but look up the institution for each author
\def\AAVL@RenderAuthInstTable{
\def\AAVL@FN{}
\let\AAVL@action=\AAVL@RAITableAction
\def\AAVL@between{\\[4pt]}
\expandafter\AAVL@maplistaux\AAVL@auths\AAVL@endstop
}

\def\AAVL@RAITableAction#1{
\begin{minipage}[t]{0.49\textwidth}
\AAVL@unhbox{authname#1}\\
\AAVL@unhbox{authmail#1}
\end{minipage}
\AAVL@RAIspace~
\begin{minipage}[t]{0.48\textwidth}
\AAVL@usebox{inst\AAVL@thecount{authinst#1}}
\end{minipage}
}

%% AAVL@RenderAuthorsAndInstitutions
% Make author list, but not in ``review'' mode...
\def\AAVL@RenderAuthorsAndInstitutions{
\ifAAVL@review
\begin{center}
\sffamily\normalsize AAVL \AAVL@year\ Submission \# \AAVL@papernumber
\end{center}
\else
% Send them to the page
\ifnum\AAVL@ninsts=1
\AAVL@RenderAuthInstTwoColumn
\else
% more than one institution.
%  if equal to number of authors, then there's one each, so
%  render one each..
\ifnum\AAVL@ninsts=\AAVL@nauthors
\AAVL@RenderAuthInstTable
\else
\AAVL@RenderAuthInstTwoColumn
\fi
\fi
\fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Email addresses are enclosed in angle brackets.  (The \<...> macro
% can also be used independently, though it works only outside maths mode.)

%\def\<#1>{$\langle$#1$\rangle$}
%\def\email#1{\<\texttt{#1}>}

% A macro for producing the title, which also puts the copyright notice
% in an unnumbered footnote on the first page.  The \maketitle macro
% was derived from a (probably very old) version of the article class
% and is probably not as elegant as it could be.

\newcounter{AAVL@shortyear}
\setcounter{AAVL@shortyear}\AAVL@year
\addtocounter{AAVL@shortyear}{-1986}

\def\AAVL@maketitle{\newpage\global\@topnum\z@%^
  \AAVL@strut\\[-4pt]% vglue produces inconsistent results
  \begin{raggedright}%^
    {\AAVL@titlesize\bfseries\sffamily\textcolor{AAVL@sectioncolor} \@title\par}%^
    \vskip 1.5em%^
    {\AAVL@RenderAuthorsAndInstitutions}%^
  \end{raggedright}%^
  \vskip\baselineskip
  \hrule
  \vskip\baselineskip
  \def\AAVL@blfootnote{\xdef\@thefnmark{}\@footnotetext}%^
  \AAVL@blfootnote{\null\hspace{-1.9em}\copyright{} \AAVL@year.
    The copyright of this document resides with its authors.
%\hfill doi:10.5244/C.\arabic{AAVL@shortyear}.NNN % DOI will be inserted directly on the PDF
\\
    It may be distributed unchanged freely in print or electronic forms.}%^
  \setcounter{footnote}{0}%^
  \thispagestyle{AAVL@c}\pagestyle{AAVL@c}%^
  \gdef\maketitle{\message{Cannot use maketitle twice}}%^
}
\ifAAVL@extabs
\def\maketitle{\twocolumn[\AAVL@maketitle]}
\else
\let\maketitle=\AAVL@maketitle
\fi

% The running head contains the author(s) and paper title, perhaps
% abbreviated so that the overall length of the headline is not too long.

\def\runninghead#1#2{\gdef\AAVL@author{\MakeUppercase{#1}}%^
  \gdef\AAVL@title{\MakeUppercase{#2}}}

% The et al macro allows for a lowercase ``et al.'' in the running head.
% It is called using \protect\etal
\def\AAVL@EtAl{\em et al.}
\def\AAVLEtAl{\protect\AAVL@EtAl}


% A macro that saves out the number of the last page of the document
% in the macro \AAVL@LastPage, for use in the headline.

\AtEndDocument{\immediate\write\@auxout{\gdef\string\AAVL@LastPage{\thepage}}}
\def\AAVL@LastPage{??}

% The headline itself, which comprises two lines of text:
%   -- The first contains the paper's authors and title and is a
%      hypertext reference to the master version on the Annals website.
%   -- The second gives citation information, with the journal name
%      being a hypertext reference to the Annals website.
% This has to be set explicitly by the author (or editor) via the \papernumber
% macro (see above).

\def\AAVL@authorOrAnon{\ifAAVL@review{AUTHOR(S)}\else\AAVL@author\fi}

\ifAAVL@extabs
\newcommand*{\ps@AAVL@c}{%^
\renewcommand*{\@oddhead}{}%^
\renewcommand*{\@evenhead}{}%^
\renewcommand*{\@oddfoot}{}%^
\renewcommand*{\@evenfoot}{}%^
}
\else
\newcommand*{\ps@AAVL@c}{%^
  \renewcommand*{\@oddhead}{\begin{minipage}{\textwidth}\small
      \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        \textsl{\AAVL@authorOrAnon: \AAVL@title}
          & \bfseries\thepage
      \end{tabular*}\par\smallskip\hrule
    \end{minipage}}
  \renewcommand*{\@evenhead}{%^
    \begin{minipage}{\textwidth}\small
      \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        \bfseries\thepage &\textsl{\AAVL@authorOrAnon: \AAVL@title}
      \end{tabular*}\par\smallskip\hrule
    \end{minipage}}
  \renewcommand*{\@oddfoot}{}%^
  \renewcommand*{\@evenfoot}{}%^
}
\fi

% Ensure section titles are set ragged-right.   These definitions are
% adapted from those in article.cls v1.4f of 2004/02/16.

\renewcommand\section{\@startsection {section}{1}{\z@}%^
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%^
                                   {2.3ex \@plus.2ex}%^
                                   {\normalfont\Large\bfseries\flushleft\textcolor{AAVL@sectioncolor}}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%^
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%^
                                     {1.5ex \@plus .2ex}%^
                                     {\normalfont\large\bfseries\flushleft\textcolor{AAVL@sectioncolor}}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%^
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%^
                                     {1.5ex \@plus .2ex}%^
                                     {\normalfont\normalsize\bfseries\flushleft\textcolor{AAVL@sectioncolor}}}

% Footnote rules go right across the page (definition adapted from
% article.cls v1.4f of 2004/02/16).

\renewcommand\footnoterule{\kern-3\p@
  \hrule\@width\columnwidth
  \kern2.6\p@}

% Make the space above figure captions more compact
\setlength\abovecaptionskip{-5pt}

% Set captions in blue
\let\AAVL@makecaption=\@makecaption
\def\@makecaption#1#2{\textcolor{AAVL@captioncolor}{\AAVL@makecaption{#1}{#2}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RULER
%% --------- Page background marks: Ruler and confidentiality

% ----- define vruler
\newbox\AAVL@rulerbox
\newcount\AAVL@rulercount
\newdimen\AAVL@ruleroffset
\newdimen\AAVL@rulerlineheight
\newdimen\AAVL@rulerboxheight
\newbox\AAVL@rulertmpbox
\newcount\AAVL@rulerrefno
\newcount\AAVL@rulertot

\font\AAVL@ruler@tenhv = phvb at 8pt % *** If this fails, see the lines after this one in AAVL.sty ***
% If the above lines give an error message, try to comment them and
% uncomment these:
%\font\AAVL@ruler@tenhv = phvb7t at 8pt

%% \fillzeros[<WIDTH>]<NUMBER>
% NUMBER with left flushed zeros
\newcount\AAVL@rulertmpc@
\newcount\AAVL@rulertmpc
\def\AAVL@fillzeros[#1]#2{
  \AAVL@rulertmpc@=#2\relax\ifnum\AAVL@rulertmpc@<0\AAVL@rulertmpc@=-\AAVL@rulertmpc@\fi
\AAVL@rulertmpc=1 %^
\loop\ifnum\AAVL@rulertmpc@<10 \else \divide\AAVL@rulertmpc@ by 10 \advance\AAVL@rulertmpc by 1 \fi
   \ifnum\AAVL@rulertmpc@=10\relax\AAVL@rulertmpc@=11\relax\fi \ifnum\AAVL@rulertmpc@>10 \repeat
\ifnum#2<0\advance\AAVL@rulertmpc1\relax-\fi
\loop\ifnum\AAVL@rulertmpc<#1\relax0\advance\AAVL@rulertmpc1\relax\fi \ifnum\AAVL@rulertmpc<#1 \repeat
\AAVL@rulertmpc@=#2\relax\ifnum\AAVL@rulertmpc@<0\AAVL@rulertmpc@=-\AAVL@rulertmpc@\fi
\relax\the\AAVL@rulertmpc@}

% \makevruler[<SCALE>][<INITIAL_COUNT>][<STEP>][<DIGITS>][<HEIGHT>]
\def\makevruler[#1][#2][#3][#4][#5]{\begingroup\offinterlineskip
\textheight=#5\vbadness=10000\vfuzz=120ex\overfullrule=0pt%^
\global\setbox\AAVL@rulerbox=\vbox to \textheight{%^
{\parskip=0pt\hfuzz=150em\AAVL@rulerboxheight=\textheight
\AAVL@rulerlineheight=#1\global\AAVL@rulercount=#2%^
\AAVL@rulertot\AAVL@rulerboxheight\divide\AAVL@rulertot\AAVL@rulerlineheight\advance\AAVL@rulertot2%^
\AAVL@rulerrefno1\vskip-\AAVL@rulerlineheight\vskip1ex%^
\loop\setbox\AAVL@rulertmpbox=\hbox to0cm{{\AAVL@ruler@tenhv\hfil\AAVL@fillzeros[#4]\AAVL@rulercount}}%^
\ht\AAVL@rulertmpbox\AAVL@rulerlineheight\dp\AAVL@rulertmpbox0pt\box\AAVL@rulertmpbox\break
\advance\AAVL@rulerrefno1\global\advance\AAVL@rulercount#3\relax
\ifnum\AAVL@rulerrefno<\AAVL@rulertot\repeat}}\endgroup}%^
% ----- end of vruler

% \makevruler[<SCALE>][<INITIAL_COUNT>][<STEP>][<DIGITS>][<HEIGHT>]
\def\AAVL@ruler#1{\makevruler[12.5pt][#1][1][3][0.993\textheight]\usebox{\AAVL@rulerbox}}
\AddToShipoutPicture{%^
  %\AtTextLowerLeft{%^
  % \color[gray]{.15}\framebox(\LenToUnit{\textwidth},\LenToUnit{\textheight}){}
  %}
  \ifAAVL@review
  \AAVL@ruleroffset=\textheight
  \advance\AAVL@ruleroffset by 1pt
  \color[rgb]{.7,.7,1}
  \AtTextUpperLeft{%^
    \ifodd\c@page
    \put(\LenToUnit{-21pt},\LenToUnit{-\AAVL@ruleroffset}){%left ruler
      \AAVL@ruler{\AAVL@rulercount}}
    \else
    \put(\LenToUnit{\textwidth\kern3pt},\LenToUnit{-\AAVL@ruleroffset}){%right ruler
      \AAVL@ruler{\AAVL@rulercount}}
    \fi
  }
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography stuff.

% Natbib gives sorting of numeric references.
% We don't use the compress option, because we
% want each reference to have its own popup
\usepackage[sort,numbers]{AAVL_natbib}

% Compressed bibliography for the 1-pager
\ifAAVL@extabs
\def\bibsection{} % No ``References'' header
\bibsep=2pt
\fi

\newif\ifAAVL@annot
\AAVL@annotfalse
\def\AAVL@annotation{}
\definecolor{AAVL@CiteBoxColor}{rgb}{1,1,1}

\def\Hy@StartlinkName#1#2{%^  #1 is object props -- ignored for us
  \ifAAVL@annot%^
  \setbox\@tempboxa=\hbox{\textcolor{AAVL@CiteBoxColor}{{AAVLtest~}}}%^
  \immediate\pdfxform\@tempboxa%^
  \edef\AAVL@theblank{\the\pdflastxform}%^
   \pdfannot {  % This annot will be given a bounding box corresponding to
		% its surrounding hbox
    % We use a ``square'' Annot because we want it to scale with the text
    /A << /D << /S /GoTo /D (#2) >> >> ^^J
    /Subtype /Square ^^J
    /Subj (Citation) ^^J
    /CA 1.0
    /T (Citation) ^^J
    /Contents (\AAVL@annotation) ^^J
    /XAP << % Appearance
      /N \AAVL@theblank\space 0 R
      /D \AAVL@theblank\space 0 R
      /R \AAVL@theblank\space 0 R
    >> ^^J
    /Open false
   }%^
  \else
    \pdfstartlink attr{#1 /PTEX.FullName (AAVLtest) }goto name{#2}\relax
  \fi}

% hook into the natbib/hyperref citation hooks.
\ifAAVL@extabs\else
\ifAAVL@pdf
\newbox\AAVL@citebox
\let\hyper@natlinkend=\relax
\def\hyper@natlinkstart#1{%^
  \Hy@backout{#1}%^
  \xdef\AAVL@annotation{\NAT@all@names\space\NAT@date}%^
  \message{AAVL cite \AAVL@annotation}%^
  %\fbox{\AAVL@annotation}%^
  \AAVL@annottrue%^
  \hyper@linkstart{cite}{cite.#1}%^
  \AAVL@annotfalse%^
  \def\hyper@nat@current{#1}%^
}

\def\hyper@natlinkend{%^
  \Hy@endcolorlink %^
%\pdfendlink
}
\fi
\fi

\bibliographystyle{plainnat}

%------------------------------------------------------------------------------
% End of AAVL.cls
%------------------------------------------------------------------------------
\message{Finished loading AAVL}
