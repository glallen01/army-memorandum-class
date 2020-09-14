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


\AtBeginDocument{%
  \ifstrempty{\am@documentmark}{}{%
    \backgroundsetup{opacity=1, scale=1, angle=0,contents={\am@classmark{\am@documentmark}}}\BgThispage
  }
  \am@putlogo%
  \dodheader%
  \vspace*{2\baselineskip}
}

% \typeout{===========>}\show\@enddocumenthook
% https://tex.stackexchange.com/a/212214
% BUG: something is messing with this, so for now moving it to the top
\AtEndDocument{%
  \setlength{\parskip}{0pt}
  \vspace*{\baselineskip}
  \noindent\am@authorityline\\
  \vspace*{4\baselineskip}
  \begin{tikzpicture}[overlay]
    %% to draw a grid for debugging
    % \draw[style=help lines] (0,0) grid (15,5);
    \node [align=left, anchor=west, inner sep=0, outer sep=0] at (0.5\textwidth,-10pt){% TODO BUG - why a 10pt offset? I don't know.
      {\MakeUppercase \am@author}\\ 
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

% used to change date format
\RequirePackage{datetime}
\newdateformat{mildate}{\twodigit\THEDAY\ \monthname[\THEMONTH] \THEYEAR}
\mildate
% for logo and other includes
\RequirePackage{graphicx}
% for future use of colors in classification markings
\RequirePackage[dvipsnames]{xcolor}
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



% for margins
\RequirePackage{calc}
\RequirePackage[letterpaper
  ,margin=1in
  % in order to get 2-line offset between bottom of text and page number
  % (because it looks nicer)
  ,bottom=1in-2\baselineskip
  ,includehead
  % includefoot, but then we manually adjust the bottom margin above, in order
  % to also adjust the overall \textheight
  % also the AR examples show the page number above the classification marking
  ,includefoot
  ,footskip=3\baselineskip
  ,footnotesep=\baselineskip
  % assume two lines for headers
  % TODO: test with longer subject lines, assuming it will break
  ,headheight=2\baselineskip
  ,headsep=2\baselineskip
  ]{geometry}
% make sure the paragraph spacing matches the linespacing
\setlength{\parskip}{\baselineskip}

% setup page headers
\RequirePackage{scrlayer-scrpage}
\setlength{\footheight}{2\baselineskip}
\clearpairofpagestyles%
\lohead[]{\am@officesymbol\hspace*{\fill}\\\am@subject}
\cofoot[]{\thepage}
\pagestyle{scrheadings}
\setkomafont{pagehead}{\sffamily\upshape}


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

% do I need this later? https://tex.stackexchange.com/a/64615
\usepackage[colorlinks=true,urlcolor=blue,citecolor=blue,breaklinks=true]{hyperref}
\urlstyle{same}

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
\setlist[1]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=16pt,align=left,
  after={\nopagebreak\@nobreaktrue}}
\setlist[2]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.5in,align=left}
\setlist[3]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.75in,align=left}
\setlist[4]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=0.75in,align=left}
%% TODO - change to an option - uncomment to go deeper
% \renewcommand{\theenumv}{\arabic{enumv}}\renewcommand{\labelenumv}{(\theenumv)}
% \renewcommand{\theenumvi}{\alph{enumivi}}\renewcommand{\labelenumvi}{(\theenumvi)}
% \setlist[5]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=1.00in,align=left}
% \setlist[6]{labelwidth=12pt,labelsep=4pt,leftmargin=0pt,itemindent=1.25in,align=left}

% define superscripts for use in unit addresses, etc.
% these may need to be followed by an '\ '
\newcommand{\st}{\textsuperscript{st}}
\newcommand{\nd}{\textsuperscript{nd}}
\newcommand{\rd}{\textsuperscript{rd}}
\newcommand{\thh}{\textsuperscript{th}}

% commands for error/warning messages for missing values
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

% header info
\newcommand{\signaturedate}[1]{\def \am@signaturedate{#1}}\signaturedate{}
\signaturedate{\am@MissingRequiredArgWarning{signaturedate}{DRAFT}}
\newcommand{\suspensedate}[1]{\def\am@suspensedate{\ifstrempty{#1}{}{S: #1}}}\suspensedate{}
\newcommand{\officesymbol}[1]{\def \am@officesymbol{#1}}
\officesymbol{\am@MissingRequiredArgError{officesymbol}{OFFICE SYMBOL}}
% allow replacing the logo
\newcommand{\logo}[1]{\def\am@logo{\ifstrempty{#1}{DODb1}{#1}}}\logo{}

%%%%% Memolines:-------------------------------------------------------
%
% example 1:
% nothing or just \mfr -- MEMORANDUM FOR RECORD
%
% example 2:
% \addmemoline{MEMORANDUM FOR ...} % this is hopefully what most people need most of the time
%
% example 3:
% \addmemoline{MEMORANDUM THRU ...}
% \addmemoline{FOR ...}
% This is the first method for doing THRU memorandums. It follows the previous pattern.
%
% example 4:
% \multimemothru{....}    % multi line memorandums break after MEMORANDUM THRU and have
% \multimemothru{....}    % hanging indents after each THRU line, without spaces, followed by
% \addmemoline{FOR ...}   % a space and the FOR line. FOR must be specified in the \addmemoline
%
% This method deviates from examples 1-3, as it uses \multimemothru{...} to add multiple thru lines
% with hanging indents per the AR, followed by an \addmemoline{} to complete the "FOR ..."
%
\newcounter{am@memoline@count}
\newcommand{\addmemoline}[1]{\stepcounter{am@memoline@count}\listadd{\am@list@memolines}{#1}}
\newcommand{\mfr}{\addmemoline{MEMORANDUM FOR RECORD}}
\newcommand{\memoline}[1]{\addmemoline{#1}}
\newcommand{\am@domemoline}[1]{\vspace{\baselineskip}\noindent{}#1\\}
\newcounter{am@memothru@count}
\newcommand{\multimemothru}[1]{\stepcounter{am@memothru@count}\listadd{\am@list@memothru}{#1}}
\newcommand{\am@do@memothru}[1]{\noindent{}\hangindent=0.25in{}#1\\}
\newcommand{\am@memoline}{%
  % if there is nothing specified, add "memorandum for record"
  \ifnumcomp{\value{am@memoline@count}}{=}{0}{%
    \ifnumcomp{\value{am@memothru@count}}{=}{0}{\mfr}{}}{}
  % otherwise, skip a space and begin
  \vspace{\baselineskip}
  % if there are multimemothru lines:
  \ifnumcomp{\value{am@memothru@count}}{>}{0}{%
    \vspace{\baselineskip}
    MEMORANDUM THRU\\
    \vspace{\baselineskip}
    % loop through the thru lines with hanging indent
    \forlistloop{\am@do@memothru}{\am@list@memothru}}
  {}
  % after dealing with special cases, add the other lines from \addmemoline or \memoline
  % these lines must begin with any labels such as "MEMORANDUM FOR" or "MEMORANDUM THRU" or "FOR"
  \forlistloop{\am@domemoline}{\am@list@memolines}
}


%%%%% ----------------------------------------------------------------

\renewcommand{\subject}[1]{\def\am@subject{SUBJECT: #1}}
\subject{\am@MissingRequiredArgWarning{subject}{DRAFT}}

% top and bottom of page classification markings
% TODO should be highest of any portion marking (how to track/test)?
\newcommand{\documentmark}[1]{\def \am@documentmark{#1}}\documentmark{}

% authority line
\newcommand{\authority}[1]{\def\am@authorityline{\ifstrempty{#1}{}{\uppercase{#1}:}}}
\authority{}

% signature block
\renewcommand{\author}[1]{\def \am@author{#1}}\author{}
\newcommand{\rank}[1]{\def \am@rank{#1}}\rank{}
\newcommand{\branch}[1]{\def \am@branch{#1}}\branch{}
\renewcommand{\title}[1]{\def \am@title{#1}}\title{}


% add enclosures along with a total count
\newcommand{\am@do@encl}[1]{\item #1 }
\newcounter{am@encl@count}
\newcommand{\addencl}[1]{\stepcounter{am@encl@count}\listadd{\am@list@encls}{#1}}
\newcommand{\am@encls}{%
  \ifnumcomp{\value{am@encl@count}}{=}{0}{%
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

% add distribution, with an option for continuation on the next page
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

% add cf, with an option for continuation on the next page
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



\newcommand{\am@classmark}[1]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[align=center,anchor=north,yshift=-24pt] at (current page.north) {#1};
    \node[align=center,anchor=south,yshift=36pt] at (current page.south) {#1};
  \end{tikzpicture}
}

\newcommand{\am@putlogo}{%
  \begin{tikzpicture}[remember picture, overlay]%
    \node[anchor=north west,inner sep=0pt,xshift=0.5in, yshift=-0.5in]%
      at (current page.north west) {\includegraphics[width=1in]{\am@logo}};%
  \end{tikzpicture}%
}


% \dodheader alternate implementation possibility:
%    https://www.ntg.nl/maps/31/15.pdf "Exact layout with LaTeX" Siep Kroonenberg
%    uses plain tex and picture environment

\newcounter{am@address@count}
\newcommand{\department}[1]{\def\am@department{\ifstrempty{#1}{DEPARTMENT OF THE ARMY}{\uppercase{#1}}}}\department{}
\newcommand{\address}[1]{\stepcounter{am@address@count}\listadd{\am@list@address}{#1}}
\newcommand{\am@do@address}[1]{\fontsize{8pt}{5pt}\selectfont\textbf{\uppercase{#1}}\\}
\newcommand{\dodheader}{%
  \ifnumcomp{\value{am@address@count}}{<}{2}{
    \address{Organizational Name/Title}
	 \address{Standardized Street Address}
	 \address{City, State, 12345-1234}
  }{}
  \thispagestyle{plain}%
  \begin{tikzpicture}[remember picture, overlay]%
    \setstretch{0.7}\fontfamily\sfdefault\selectfont%
    \node[align=center,anchor=north,inner sep=0pt,yshift=-0.625in] at (current page.north) {%
      \fontsize{10pt}{10pt}\selectfont\textbf{\am@department}\\
      \forlistloop{\am@do@address}{\am@list@address}
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
  \am@memoline
  \vspace{\baselineskip}
  \noindent\am@subject\\
}

