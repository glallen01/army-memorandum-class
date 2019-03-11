% Army memo class
% Version 0.2.1 2019/03/10
% George Allen base64(Z2xhbGxlbjAx) AT base64(Z21haWwuY29t)

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{armymemo}[2019/03/10]

\LoadClass[
  12pt
  ,oneside
  ,parskip=half-
  ,headings=small
  ,DIV=15
]{scrartcl}

% Setting penalties for widows and orphans: broken paragraphs with only one line
% at the top or bottom of the page. This messes up other formatting leaving lots
% of space at the bottom of some pages that requires manual intervention.
%% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=widows
\widowpenalty=10000
\clubpenalty=10000

\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[letterpaper,margin=1in,includehead]{geometry}
\RequirePackage[normalem]{ulem}
\RequirePackage{booktabs}
\RequirePackage{datetime} % used to change date format
\RequirePackage{graphicx}
\RequirePackage{hanging}
\RequirePackage{longtable}
\RequirePackage{setspace}
\RequirePackage{tikz}
\RequirePackage[pages=all,color=black]{background} % for markings
\RequirePackage{array}
  \newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\RequirePackage[utf8]{inputenc}
\RequirePackage{csquotes}
  \MakeOuterQuote{"}  
\RequirePackage{enumitem}
  \setlist{topsep=0pt,itemsep=0pt,parsep=0pt}
  \renewlist{enumerate}{enumerate}{9}
  \setlistdepth{9}
\RequirePackage{ragged2e}
  \RaggedRight
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

% Setup fonts:

\RequirePackage{fontspec} % Requires XeLatex
\RequirePackage[english]{babel}
  \setmainfont{Arial} % AR 25-50 recommends Arial as of 17 May 2013.  1-17b
  \setsansfont{Arial}
  \defaultfontfeatures{Mapping=tex-text} % To support LaTeX ``" quotes.

  % regarding ragged right and microtype
  % http://tex.stackexchange.com/questions/134303/does-combining-microtype-with-ragged-right-make-any-sense
\RequirePackage[protrusion=true,expansion=false]{microtype}
  % regarding RaggedRight and \hyphenpenalty=500
  % http://tex.stackexchange.com/questions/291685/minimize-hyphenations-with-ragged2e
  
  % \RequirePackage[none]{hyphenat}\raggedright

\setlist{topsep=0pt,itemsep=0pt,parsep=0.5\baselineskip}
%% from https://github.com/jschaf/army-memos/blob/master/src/memorandum-for-record.tex
\renewcommand{\theenumi}{\arabic{enumi}}\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}\renewcommand{\labelenumii}{\theenumii.}
\renewcommand{\theenumiii}{\arabic{enumiii}}\renewcommand{\labelenumiii}{(\theenumiii)}
\renewcommand{\theenumiv}{\alph{enumiv}}\renewcommand{\labelenumiv}{(\theenumiv)}
\setlist[1]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=16pt ,align=left}
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
\newsavebox{\am@address}\newcommand{\address}[1]{\sbox{\am@address}{#1}}
\newsavebox{\am@city}\newcommand{\city}[1]{\sbox{\am@city}{#1}}
\newsavebox{\am@signaturedate}\newcommand{\signaturedate}[1]{\sbox{\am@signaturedate}{#1}}
\newsavebox{\am@suspensedate}\newcommand{\suspensedate}[1]{\sbox{\am@suspensedate}{#1}}
\newsavebox{\am@officesymbol}\newcommand{\officesymbol}[1]{\sbox{\am@officesymbol}{#1}}
\newsavebox{\am@memoline}\newcommand{\memoline}[1]{\sbox{\am@memoline}{#1}}
\newsavebox{\am@subject}\renewcommand{\subject}[2][]{\sbox{\am@subject}{\uppercase{#1{}Subject}: #2}}
\newsavebox{\am@documentmark}\newcommand{\documentmark}[1]{\sbox{\am@documentmark}{#1}}
\newsavebox{\am@author}\renewcommand{\author}[1]{\sbox{\am@author}{#1}}
\newsavebox{\am@rank}\newcommand{\rank}[1]{\sbox{\am@rank}{#1}}
\newsavebox{\am@branch}\newcommand{\branch}[1]{\sbox{\am@branch}{#1}}
\newsavebox{\am@title}\renewcommand{\title}[1]{\sbox{\am@title}{#1}}
%%%%%%%%%%%%%%

\RequirePackage{scrlayer-scrpage}
\setlength{\headheight}{2\baselineskip}
\clearpairofpagestyles
\lohead[]{\usebox{\am@officesymbol}\hspace*{\fill}\usebox{\am@signaturedate}\\\usebox{\am@subject}}
\cofoot[]{\thepage}
\pagestyle{scrheadings}

\newcommand{\CLASSMARK}
{
  \begin{tikzpicture}[remember picture, overlay]
    \node[align=center,anchor=north,yshift=-24pt] at (current page.north) {UNCLASSIFIED//FOR OFFICIAL USE ONLY};
    \node[align=center,anchor=south,yshift=36pt] at (current page.south) {UNCLASSIFIED//FOR OFFICIAL USE ONLY};
  \end{tikzpicture}
}

\newcommand{\dodlogo}%
{%
  \begin{tikzpicture}[remember picture, overlay]%
    \node[anchor=north west,inner sep=0pt,xshift=0.5in, yshift=-0.5in]%
      at (current page.north west) {\includegraphics[width=1in]{DODb1}};%
  \end{tikzpicture}%
}

\newcommand{\daletterhead}[1]{\fontsize{10pt}{10pt}\selectfont\textbf{\uppercase{#1}}\\}
\newcommand{\letterhead}[1]{\fontsize{8pt}{5pt}\selectfont\textbf{\uppercase{#1}}\\}

\newcommand{\dodheader}%
{%
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
  \vspace{-6pt}%

  \noindent\usebox{\am@officesymbol}\hspace*{\fill}\usebox{\am@signaturedate}\\[24pt]%
  \noindent\usebox{\am@memoline}\\[12pt]%
  \noindent\usebox{\am@subject}\\[0 pt]%
}

\newcommand{\signatureblock}
{
  \begin{minipage}[t]{0.49\textwidth}
    \usebox{\am@author}\\ 
    \usebox{\am@rank}, \usebox{\am@branch}\\
    \usebox{\am@title}
  \end{minipage}
}

\newcommand{\am@encls}{
  1 Encls
  \begin{enumerate}[
    topsep=0pt
    ,itemsep=0pt
    ,parsep=0pt
    ,leftmargin=16pt
    ,itemindent=0pt
    ,align=left
    ,label={\arabic*.}
    ]
  \item AR 25-50
  \end{enumerate}
  
}

\newcommand{\am@distro}{
  DISTRIBUTION:\\%
  CDR\\
  S3\\
}

\newcommand{\am@cf}{
  CF:\\
  CFline1\\
  CFline2
}

\newcommand{\am@EnclAndDistro}
{
  \begin{minipage}[t]{0.49\textwidth}
    \am@encls
    \ \newline
    \am@distro
    \ \newline
    \am@cf
  \end{minipage}
}

\AtBeginDocument{
  \backgroundsetup{opacity=1, scale=1, angle=0, contents={\CLASSMARK}}\BgThispage
  \dodlogo
  \dodheader
  \vspace*{2\baselineskip}
}

\newcommand{\SignatureEnclAndDistro}{
  \vspace*{4\baselineskip}
  \am@EnclAndDistro
  \signatureblock
}

\AtEndDocument{
  %\vspace*{4\baselineskip}
  % \am@EnclAndDistro
  % \signatureblock
}

