% Army memo class
% Version 0.1 2011/09/15
% George L. Allen glallen01@gmail.com


\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{armymemo}[2011/09/01]

\LoadClass[
        %titlepage,
        12pt,
        letterpaper,
        headings=small,
        %twoside,
        oneside,
        %parskip=half-,
        %parindent,
        %liststotoc,
        %draft,
        headinclude,
        DIV=15,
        headlines=2,
        pdftex]{scrartcl}

\RequirePackage{fancyhdr}
\RequirePackage[margin=1in,includefoot]{geometry}
\RequirePackage{typearea}
\RequirePackage[absolute]{textpos}
\RequirePackage[utf8x]{inputenc}		% for windows quotes without having to sed them out
\RequirePackage[T1]{fontenc}                	% For Times (Nimbus Roman) Font:
\RequirePackage{tgtermes}
\RequirePackage{color}
\RequirePackage{ctable}
\RequirePackage{graphicx}
\RequirePackage{lipsum}                     	% delete this later
\RequirePackage{microtype}
\RequirePackage{ragged2e} \RaggedRight      	% recommended by jurabib for better ragged right
\RequirePackage{setspace}%\doublespacing    	% turns off in floats and tables
%\RequirePackage{endnotes}
\RequirePackage{multicol}
\RequirePackage[normalem]{ulem}


\setlength{\parindent}{2em}

\newcounter{ParNumi}
\newcounter{ParNumii}[ParNumi]
\newcounter{ParNumiii}[ParNumii]
\newcounter{ParNumiiii}[ParNumiii]
\newcounter{ParNumiiiii}[ParNumiiii]

\newcommand{\Ni}{\refstepcounter{ParNumi}\noindent\makebox[\parindent][l]{\arabic{ParNumi}. }}
\newcommand{\Nii}{\refstepcounter{ParNumii}\noindent\hspace{\parindent}\makebox[\parindent][l]{\alph{ParNumii}. }}
\newcommand{\Niii}{\refstepcounter{ParNumiii}\noindent\hspace{2\parindent}\makebox[\parindent][l]{\roman{ParNumiii}. }}
\newcommand{\Niiii}{\refstepcounter{ParNumiiii}\noindent\hspace{3\parindent}\makebox[\parindent][l]{(\arabic{ParNumiiii}) }}
\newcommand{\Niiiii}{\refstepcounter{ParNumiiiii}\noindent\hspace{4\parindent}\makebox[\parindent][l]{(\alph{ParNumiiiii}) }}
\newcommand{\Nx}[1]{\noindent\hspace{#1\parindent}}


% #1 UNIT
% #2 Address1
% #3 Office Symbol
% #4 Subject

% could adjust to add other services or customizable 'dept'
\newcommand{\AMarmy}{\newsavebox{\DEPT}      \sbox{\DEPT}{\textmd{{DEPARTMENT OF THE ARMY}}}}
\AMarmy
\newcommand{\AMunit}[1]{ 		\newsavebox{\UNIT}      \sbox{\UNIT}{\headfmt{#1}}}
\newcommand{\AMaddress}[1]{	\newsavebox{\ADDRESS}   \sbox{\ADDRESS}{\headfmt{#1}}}
\newcommand{\AMsymbol}[1]{	\newsavebox{\OSYMB}     \sbox{\OSYMB}{#1}}
\newcommand{\AMsubject}[1]{	\newsavebox{\SUBJECT}   \sbox{\SUBJECT}{#1}}

\newcommand{\headfmt}[1]{\uppercase{\footnotesize\textmd{{#1}}}}

\setkomafont{pagehead}{\normalfont}
\setkomafont{pagefoot}{\normalfont}
\setkomafont{pagenumber}{\normalfont}
\setkomafont{disposition}{\normalfont}
\setkomafont{disposition}{\normalfont}

\newcommand{\AMsethead}{
 \fancypagestyle{plain}{%
  \fancyhf{} %clear all header and footer fields
  \lhead{
   \setlength{\unitlength}{1pc}    
   \begin{picture}(0,0)
   \put(-3,-2.5){\includegraphics[height=1in]{DA_LOGO.png}}
   \end{picture}
  }
  \chead{
   \usebox{\DEPT}\\\usebox{\UNIT}\\\usebox{\ADDRESS}
  }
  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
 }
 \lhead[]{\newgeometry{margin=1.0in}\usebox{\OSYMB}\\SUBJECT:
 \usebox{\SUBJECT}\\[24pt]}
 \fancyfoot[C]{\thepage}
 \renewcommand{\headrulewidth}{0.0pt}
 \renewcommand{\footrulewidth}{0.0pt}
 
 \thispagestyle{plain}
 \pagestyle{fancy}
 \ \vspace*{12pt}\\      
 \noindent\usebox{\OSYMB}\hfill\today\\[24pt]
 \noindent MEMORANDUM FOR RECORD\\[12pt]
 \noindent SUBJECT: \usebox{\SUBJECT}\\[12pt]
 \setlength{\parskip}{12pt}
}

% #1 
% #2 
% #3 
% #4 
\newcommand{\AMsigblock}[4]{
	\setlength{\parskip}{0pt}
	\vspace{48pt}
	\noindent\parbox[t]{2in}{\noindent #4}
	\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}
}
