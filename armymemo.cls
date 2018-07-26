% Army memo class
% Modification of Version 0.1.1 2016/03/12
% George L. Allen base64(Z2xhbGxlbjAx) AT base64(Z21haWwuY29t)
% Modified by Roberts G. Nelson

%-----------------------------------General Document Setup----------------------------------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{armymemo}[2017/04/27]

\LoadClass[
        12pt,
        letterpaper,
        headings=small,
        oneside,
        pdftex]{scrartcl}

\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{helvet}
\RequirePackage{datetime} % used to change date format
% Set paper size and margins
\RequirePackage[letterpaper,margin=1in,bottom=1in,includefoot]{geometry}
% Setup fonts:
\RequirePackage{fontspec} % Requires XeLatex
\defaultfontfeatures{Mapping=tex-text} % To support LaTeX ``" quotes.
\setmainfont{Arial} % AR 25-50 recommends Arial as of 17 May 2013.  1-17b
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{hanging}
\RequirePackage{xstring} %for finding character in substring
\RequirePackage{ragged2e} \RaggedRight  % recommended by jurabib for better ragged right

%Setting penalties for widows and orphans: broken paragraphs with only one line
%at the top or bottom of the page.
\widowpenalty=10000
\clubpenalty=10000

% Disable hyphenation on a page-break. See AR 25-50 2-5-c-3
\brokenpenalty10000\relax

% Army date format.  1-23a. Note, this is the long month name
\newdateformat{armydate}{\THEDAY\ \monthname[\THEMONTH] \THEYEAR}

%-----------------------------------Paragraph Definitions-----------------------------------%
\setlength{\parindent}{1.5em}

\newcounter{ParNumi}
\newcounter{ParNumii}[ParNumi]
\newcounter{ParNumiii}[ParNumii]
\newcounter{ParNumiiii}[ParNumiii]
\newcounter{ParNumiiiii}[ParNumiiii]

%added \par's for each line to force separation even without linebreaks between \Ni's
%need to do this differently to force a newline at a \par, but to ignore
%additional newlines if there's already a separation
\newcommand{\Ni}{\refstepcounter{ParNumi}\noindent\makebox[\parindent][l]{\arabic{ParNumi}. }}
\newcommand{\Nii}{\refstepcounter{ParNumii}\noindent\hspace{\parindent}\makebox[\parindent][l]{\alph{ParNumii}. }}
\newcommand{\Niii}{\refstepcounter{ParNumiii}\noindent\hspace{2\parindent}\setlength{\parindent}{2em}\makebox[\parindent][l]{(\arabic{ParNumiii}) }\setlength{\parindent}{1.5em}}
\newcommand{\Niiii}{\refstepcounter{ParNumiiii}\noindent\hspace{2\parindent}\setlength{\parindent}{2em}\makebox[\parindent][l]{(\alph{ParNumiiii}) }\setlength{\parindent}{1.5em}}
\newcommand{\Nx}[1]{\noindent\hspace{#1\parindent}}

%------------------------------------------Header------------------------------------------%
% #0 Department
% #1 UNIT
% #2 Address1
% #3 Office Symbol
% #4 Subject

% define the saveboxes for internal use
\newsavebox{\DEPT}
\newsavebox{\UNIT}
\newsavebox{\ADDRESS}
\newsavebox{\CITY}
\newsavebox{\OSYMB}
\newsavebox{\MEMOFOR}
\newsavebox{\SUBJECT}
\newsavebox{\DATE}
\newsavebox{\SUSPENSE}
\newcommand{\AMsuspense}[1]{\sbox{\SUSPENSE}{#1}}
\newcommand{\AMdate}[1]{\sbox{\DATE}{#1}}
\newcommand{\AMfor}[1]{\renewcommand{\AMfor}{#1}}
\newcommand{\AMsubject}[1]{\renewcommand{\AMsubject}{#1}}

\newcommand{\headfmt}[1]{\normalfont\bfseries\MakeUppercase{\fontsize{8}{8}\selectfont{#1}}}

% could adjust to add other services or customizable 'dept'
\newcommand{\AMdept}[1]{\sbox{\DEPT}{\normalfont\bfseries\MakeUppercase{\fontsize{10}{8}\selectfont{#1}}}}
\newcommand{\AMunit}[1]{\sbox{\UNIT}{\headfmt{#1}}}
\newcommand{\AMaddress}[1]{\sbox{\ADDRESS}{\headfmt{#1}}}
\newcommand{\AMcity}[1]{\sbox{\CITY}{\headfmt{#1}}}
\newcommand{\AMsymbol}[1]{\sbox{\OSYMB}{#1}}

\setkomafont{pagehead}{\normalfont}
\setkomafont{pagefoot}{\normalfont}
\setkomafont{pagenumber}{\normalfont}
\setkomafont{disposition}{\normalfont}
\setkomafont{disposition}{\normalfont}

\fancypagestyle{plain}{%
  \topmargin = -0.5in % top of page to header = 0.5in
  \fancyhf{} %clear all header and footer fields
  \lhead{% still wrapping logo in header for the moment to keep on page1
    {\begin{tikzpicture}[remember picture, overlay]
        \node [xshift=0.0in,yshift=0.05in] at (0,0) {\includegraphics[height=1in]{DODb1.eps}};
      \end{tikzpicture}}
  }

  \chead{%HEADER and SECTION ADDRESS
    \setstretch{0.65} % adjusts spacing for the header
    \usebox{\DEPT}\\
    \usebox{\UNIT}\\
    \usebox{\ADDRESS}\\
    \usebox{\CITY}
  }

  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
}

\fancypagestyle{body}{%
  \lhead[]{\usebox{\OSYMB}\\SUBJECT: \AMsubject}%[24pt]}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
}

\newcommand{\AMsethead}{
  \setlength{\parskip}{1em minus .5em} %stretchable glue
  \thispagestyle{plain}
  \pagestyle{body}
  \ \vspace*{1\parskip}\\
  \noindent\hfill\armydate\usebox{\SUSPENSE}
  \ \vspace*{1\parskip}\\
  \noindent\usebox{\OSYMB}\hfill\armydate\usebox{\DATE}
  \ \vspace*{2\parskip}\\
  \noindent \AMfor\\[1\parskip]
  \noindent SUBJECT:~~\AMsubject % double space required after colon
  \ \vspace*{2\parskip}\\
}

%-------------------------------------Signature Block-------------------------------------%
% #1 Name
% #2 Rank, Branch
% #3 Title
% #4 Number of Enclosures
% #5 Enclosures
\newcommand{\AMsigblock}[5]{%
  \vspace{4\parskip}
  \noindent\begin{minipage}[t]{\textwidth}

  % Use "*" for the number of enclosures to not include the number before "Encls"
  % See AR 25-50 Figure 4-4
    
  % ifsubstr from xstring package
  % I am a novice with Tex, so there are probably much better ways to check the number of enclosures
  % Hopefully someone can get around to it soon. (Bobby Nelson 2018-07-25)
  \IfSubStr{#4}{*}{
      \parbox[t]{0.28\textwidth}{Encls}\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}\\
  }{  
    \ifnum#4=0
      \parbox[t]{0.28\textwidth}{}\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}\\
    \else
      \ifnum#4=1
        \parbox[t]{0.28\textwidth}{Encl}\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}\\
      \else
        \parbox[t]{0.28\textwidth}{#4 \ Encls\\
          \begin{hangparas}{2.4ex}{1}
            #5%
          \end{hangparas}
        }\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}\\
      \fi     
    \fi
  }

  \end{minipage}
}

\newcommand{\AMcf}[1]{\\[1\parskip]\noindent{}\parbox[t]{\textwidth}{CF: \\#1}}

\newcommand{\AMMOAsig}[7]{
	\vspace{4\parskip}
	\begin{minipage}{\textwidth}
	\noindent\parbox[t]{0.45\textwidth}{\noindent #1\\#2\\#3}
	\hfill\parbox[t]{0.45\textwidth}{\uppercase{#4\\#5}\\#6}
	\end{minipage}
	\ \\\vspace{2em}
	\noindent\parbox[t]{2in}{\noindent #7}
}
