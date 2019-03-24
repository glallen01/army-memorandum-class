% Army memo class

% George Allen base64(Z2xhbGxlbjAx) AT base64(Z21haWwuY29t)

\ProvidesClass{armymemo}[2019/03/10 0.2.1 Army Memorandum Class]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[
  12pt,
  oneside,
  headings=small,
  DIV=15
]{scrartcl}

%\usepackage{blindtext}

% do I need this later? https://tex.stackexchange.com/a/64615
% \usepackage[colorlinks=true,urlcolor=blue,citecolor=blue,breaklinks=true]{hyperref}
% \urlstyle{same}

% Setting penalties for widows and orphans: broken paragraphs with only one line
% at the top or bottom of the page. This messes up other formatting leaving lots
% of space at the bottom of some pages that requires manual intervention.
%% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=widows
\widowpenalty=10000
\clubpenalty=10000

% required for conditionals (already implied)
\RequirePackage{etoolbox}
% Setup fonts:
\RequirePackage[utf8]{inputenc}
% allow automatic quote expansion
\RequirePackage{csquotes}
\MakeOuterQuote{"}
% for font selection
\RequirePackage{fontspec}
\RequirePackage[english]{babel}
% AR 25-50 recommends Arial as of 17 May 2013.  1-17b
\setmainfont{Arial}
\setsansfont{Arial}
\defaultfontfeatures{Mapping=tex-text} % To support LaTeX ``" quotes.

\AtBeginDocument{%
  \ifstrempty{\am@documentmark}{}{%
    \backgroundsetup{opacity=1, scale=1, angle=0,contents={\CLASSMARK{\am@documentmark}}}\BgThispage
  }
  \dodlogo%
  \dodheader%
  \vspace*{2\baselineskip}
}

% \typeout{===========>}\show\@enddocumenthook
% https://tex.stackexchange.com/a/212214
% BUG: something is messing with this, so for now moving it to the top
\AtEndDocument{%
  \setlength{\parskip}{0pt}
  \noindent\am@authorityline\\
  \vspace*{4\baselineskip}
  \begin{tikzpicture}[overlay]
    %% to draw a grid for debugging
    % \draw[style=help lines] (0,0) grid (15,5);
    \node [align=left, anchor=west, inner sep=0, outer sep=0] at (0.5\textwidth,-10pt){% TODO BUG - why a 10pt offset? I don't know.
      \am@author\\ 
      \am@rank, \am@branch\\
      \am@title
    };
  \end{tikzpicture}%
  \am@encls%
  \am@distro%
  \am@cf%
%
%   % since minipages can't break, and this may happen near the bottom of a page,
%   % only encls and signature block go in the first mini-page
%   \begin{minipage}[t]{0.49\textwidth}
%     \am@encls
%   \end{minipage}
%   % signatureblock
% %  % \begin{minipage}[t]{0.49\textwidth}
%   %   % consider changing this to an \addtosig{}
%   %   % \am@author\\ 
%   %   % \am@rank, \am@branch\\
%   %   % \am@title
% %  % \end{minipage}
%   % \filbreak % if a break must happen, do it here, rather than orphaning the signature
%   % spacing issues w/ minipage: https://tex.stackexchange.com/q/349178/6648
%   % TODO: figure out continuations of Distro and CF across pagebreaks
%   \begin{minipage}[t]{0.49\textwidth}\am@distro\end{minipage}%
%   \begin{minipage}[t]{0.49\textwidth}\ \end{minipage}
%   \begin{minipage}[t]{0.49\textwidth}\am@cf\end{minipage}%
%   \begin{minipage}[t]{0.49\textwidth}\ \end{minipage}
}

% for future use of colors in classification markings
\RequirePackage[dvipsnames]{xcolor}
% for margins
\RequirePackage[letterpaper,margin=1in,includehead]{geometry}
\setlength{\parskip}{\baselineskip}
% for headings
\RequirePackage{scrlayer-scrpage}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{2\baselineskip}
\setlength{\footheight}{2\baselineskip}
\setlength{\headsep}{2\baselineskip}
\clearpairofpagestyles%
\lohead[]{\am@officesymbol\hspace*{\fill}\am@signaturedate\\\am@subject}
\cofoot[]{\thepage}
\pagestyle{scrheadings}

% used to change date format
\RequirePackage{datetime}
% for logo and other includes
\RequirePackage{graphicx}
% required for graphics placement
\RequirePackage{tikz}
% for overlay of classification markings without affecting layout
\RequirePackage[pages=all,color=black]{background}
% required to enable high-depth nested lists, and custom numbering
\RequirePackage{enumitem}
\setlist{topsep=0pt,itemsep=0pt,parsep=0pt}
\renewlist{enumerate}{enumerate}{9}
\setlistdepth{9}
% required for \setstretch used in header
\RequirePackage{setspace}

% process class options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

% TODO probably not needed ?
%---------------------------
% \RequirePackage{hanging}

% \RequirePackage[normalem]{ulem}

% we don't always do tables, but when we do:
\RequirePackage{booktabs}
\RequirePackage{longtable}
% for additional paragraph column types in tables
\RequirePackage{array}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

% \RaggedRight is a bit more compact, but allows lots of hyphens
% reduce hyphens with a combination of \hypenpenalty and microtype
\RequirePackage{microtype}
\RequirePackage{ragged2e}
\RaggedRight
% AR 25-50 allows for hyphenation (just not across pages, which LaTeX won't do
% anyway) we just want less hyphenation than more
\hyphenpenalty=5000
% \RequirePackage[none]{hyphenat}
% https://tex.stackexchange.com/a/134318
% https://tex.stackexchange.com/a/249335
% https://tex.stackexchange.com/a/134342
% https://tex.stackexchange.com/a/291688
%
% TODO - experiment with the lengths until the effect works
% \RaggedRightRightskip doesn't have the intended effect on lists, apparently:
% \setlength\RaggedRightRightskip{\z@ plus 0.02\hsize} % from tufte
% \setlength\RaggedRightRightskip{1pt plus 4em minus 1pt} % default is: 0pt plus 2em


\setlist{topsep=0pt,itemsep=0pt,parsep=\baselineskip,partopsep=0pt}
%% from https://github.com/jschaf/army-memos/blob/master/src/memorandum-for-record.tex
\renewcommand{\theenumi}{\arabic{enumi}}\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}\renewcommand{\labelenumii}{\theenumii.}
\renewcommand{\theenumiii}{\arabic{enumiii}}\renewcommand{\labelenumiii}{(\theenumiii)}
\renewcommand{\theenumiv}{\alph{enumiv}}\renewcommand{\labelenumiv}{(\theenumiv)}
% these \setlist provide the layout for each indentation level
% the after={} on level[1] prevents orphaned signature-blocks without the preceding final paragraph.
\RequirePackage{needspace}
\setlist[1]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=16pt,align=left,
  after={
    \nopagebreak\@nobreaktrue
  }
}
\setlist[2]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.5in,align=left}
\setlist[3]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.75in,align=left}
\setlist[4]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.75in,align=left}
%% uncomment to go deeper
% \renewcommand{\theenumv}{\arabic{enumv}}\renewcommand{\labelenumv}{(\theenumv)}
% \renewcommand{\theenumvi}{\alph{enumivi}}\renewcommand{\labelenumvi}{(\theenumvi)}
% \setlist[5]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=1.00in,align=left}
% \setlist[6]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=1.25in,align=left}



\newcommand{\st}{\textsuperscript{st}}
\newcommand{\nd}{\textsuperscript{nd}}
\newcommand{\rd}{\textsuperscript{rd}}
\newcommand{\thh}{\textsuperscript{th}}

%%%%%%%%%%%%%%
\newcommand{\am@MissingRequiredArgError}[2]{%
\textcolor{red}{#2}
  \ClassError{army-memo}{%
    #1{} is a required field\MessageBreak
    press enter to continue}{}}
\newcommand{\am@MissingRequiredArgWarning}[2]{%
  \textcolor{red}{#2}%
  \ClassWarningNoLine{army-memo}{%
    #1{} is a required field\MessageBreak
    press enter to continue}}
% letterhead info
\newcommand{\address}[1]{\def \am@address{#1}}\address{}
\newcommand{\city}[1]{\def \am@city{#1}}\city{}
% header info
\newcommand{\signaturedate}[1]{\def \am@signaturedate{#1}}\signaturedate{}
\signaturedate{\am@MissingRequiredArgWarning{signaturedate}{DRAFT}}
\newcommand{\suspensedate}[1]{\def\am@suspensedate{\ifstrempty{#1}{}{S: #1}}}\suspensedate{}
\newcommand{\officesymbol}[1]{\def \am@officesymbol{#1}}
\officesymbol{\am@MissingRequiredArgError{officesymbol}{OFFICE SYMBOL}}
\newcommand{\memoline}[1]{\def \am@memoline{#1}}\memoline{MEMORANDUM FOR RECORD}
\renewcommand{\subject}[2][]{\def \am@subject{\uppercase{#1{}Subject}: #2}}
\subject{\am@MissingRequiredArgWarning{subject}{DRAFT}}
\newcommand{\documentmark}[1]{\def \am@documentmark{#1}}\documentmark{}
% authority line
\newcommand{\authority}[1]{\def\am@authorityline{\ifstrempty{#1}{}{\uppercase{#1}:}}}
\authority{}
% signature block
\renewcommand{\author}[1]{\def \am@author{#1}}\author{}
\newcommand{\rank}[1]{\def \am@rank{#1}}\rank{}
\newcommand{\branch}[1]{\def \am@branch{#1}}\branch{}
\renewcommand{\title}[1]{\def \am@title{#1}}\title{}


% used to unroll etoolbox lists
\newcommand{\am@do@encl}[1]{\item #1 }

\newcounter{am@encl@count}
\newcommand{\addencl}[1]{\stepcounter{am@encl@count}\listadd{\am@list@encls}{#1}}
\newcommand{\am@encls}{%
  \ifnumcomp{\value{am@encl@count}}{=}{0}{%
    \noindent{}Encl\\[2\baselineskip]%
  }{%
    \ifnumcomp{\value{am@encl@count}}{=}{1}{%
      \noindent{}Encl%
      \begin{enumerate}[topsep=0pt,itemsep=0pt,parsep=0pt,itemindent=0pt,align=left,label={}]
        \forlistloop{\am@do@encl}{\am@list@encls}
      \end{enumerate}
      \vspace{\baselineskip}
    }{}%
    \ifnumcomp{\value{am@encl@count}}{>}{2}{%
      \noindent\theam@encl@count{} Encls%
      \begin{enumerate}[topsep=0pt,itemsep=0pt,parsep=0pt,leftmargin=16pt,itemindent=0pt,align=left,label={\arabic*.}]
        \forlistloop{\am@do@encl}{\am@list@encls}
      \end{enumerate}}{}
  }
}

\newcommand{\am@do}[1]{#1\\}

\newcounter{am@distro@count}
\newcommand{\adddistro}[1]{\stepcounter{am@distro@count}\listadd{\am@list@distro}{#1}}
\newcommand{\am@distro}{%
  \ifnumcomp{\value{am@distro@count}}{>}{0}{%
    \vspace{\baselineskip}%
    \noindent{}DISTRIBUTION:\\%
    \forlistloop{\am@do}{\am@list@distro}}{}}
% insert \continuedistro at the beginning of an \adddistro list in order to push it to the next page
\newcommand{\continuedistro}{\adddistro{(CONTINUED)\clearpage
    DISTRIBUTION:}}

\newcounter{am@cf@count}
\newcommand{\addcf}[1]{\stepcounter{am@cf@count}\listadd{\am@list@cf}{#1}}
\newcommand{\am@cf}{%
  \ifnumcomp{\value{am@cf@count}}{>}{0}{%
    \vspace{\baselineskip}%
    \noindent{}CF:\\
    \forlistloop{\am@do}{\am@list@cf}}{}}
% insert \continuecf at the beginning of an \addcf list in order to push it to the next page
\newcommand{\continuecf}{\addcf{(CONTINUED)\clearpage
    CF:}}

%%%%%%%%%%%%%%





\newcommand{\CLASSMARK}[1]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[align=center,anchor=north,yshift=-24pt] at (current page.north) {#1};
    \node[align=center,anchor=south,yshift=36pt] at (current page.south) {#1};
  \end{tikzpicture}
}

\newcommand{\dodlogo}{%
  \begin{tikzpicture}[remember picture, overlay]%
    \node[anchor=north west,inner sep=0pt,xshift=0.5in, yshift=-0.5in]%
      at (current page.north west) {\includegraphics[width=1in]{DODb1}};%
    \node[anchor=north west,inner sep=0pt,xshift=1.5in, yshift=-1.25in,text width=1in]%
	  at (current page.north west) {\scriptsize{REPLY TO\\\vspace{-6pt}ATTENTION OF:}};
  \end{tikzpicture}%
}

\newcommand{\daletterhead}[1]{\fontsize{10pt}{10pt}\selectfont\textbf{\uppercase{#1}}\\}
\newcommand{\letterhead}[1]{\fontsize{8pt}{5pt}\selectfont\textbf{\uppercase{#1}}\\}

% \dodheader alternate implementation possibility:
%    https://www.ntg.nl/maps/31/15.pdf "Exact layout with LaTeX" Siep Kroonenberg
%    uses plain tex and picture environment

\newcommand{\dodheader}{%
  \thispagestyle{plain}%
  \begin{tikzpicture}[remember picture, overlay]%
    \setstretch{0.7}\fontfamily\sfdefault\selectfont%
    \node[align=center,anchor=north,inner sep=0pt,yshift=-0.625in] at (current page.north) {%
      \daletterhead{Department of the Army}%
      \letterhead{Organizational Name/Title}%
      \letterhead{Starndardized Street Address}%
      \letterhead{City, State 12345-1234}%
    };%%
  \end{tikzpicture}%%
  \par%there must be a \par here, or things break!
  \vspace{-2\baselineskip}
  %conditional block for optional suspense date:
  \ifstrempty{\am@suspensedate}{}{%
    \vspace{-2\baselineskip}
    \noindent\,\hspace*{\fill}\am@suspensedate\\
    \vspace{\baselineskip}}
  \noindent\am@officesymbol\hspace*{\fill}\am@signaturedate\\
  \vspace{2\baselineskip}
  \noindent\am@memoline\\
  \vspace{\baselineskip}
  \noindent\am@subject\\
}

