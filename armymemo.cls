% Army memorandum class
% Version 0.1.0 2019/01/08
% Christian Sharpsten
% Takes inspiration from from glallen/armymemo -
%   George L. Allen base64(Z2xhbGxlbjAx) AT base64(Z21haWwuY29t)

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{armymemo}[2019/01/08]

\LoadClass[letterpaper,12pt,oneside]{article}

\RequirePackage{datetime}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{hanging}
\RequirePackage{tikz}

% Set paper size, margins, and font
\RequirePackage[letterpaper,margin=1in,includefoot]{geometry}
\RequirePackage{fontspec}               % Requires XeLatex
\defaultfontfeatures{Mapping=tex-text}  % To support LaTeX ``" quotes.
\setmainfont{Arial}                     % AR 25-50 recommends Arial as of 08JAN2019.  1-17b

% Use raggedright text, one line parskip, and no indentation
\RequirePackage{ragged2e} \RaggedRight
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}

% Don't hyphenate across pages - AR 25-50 2-5.c(3)
\brokenpenalty=10000

% Setting penalties for widows and orphans: broken paragraphs with only one line
% at the top or bottom of the page. This messes up other formatting leaving lots
% of space at the bottom of some pages that requires manual intervention.
% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=widows
\widowpenalty=10000
\clubpenalty=10000

% Letterhead variables
\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\unit}[1]{\gdef\@unit{#1}}
\newcommand*{\unitaddress}[1]{\gdef\@unitaddress{#1}}
\newcommand*{\unitcity}[1]{\gdef\@unitcity{#1}}
\department{DEPARTMENT OF THE ARMY}
\global\let\@unitcity\relax % optional

% Header variables
\newcommand*{\officesymbol}[1]{\gdef\@officesymbol{#1}}
\newcommand*{\memothru}[1]{\gdef\@memothru{#1}}
\newcommand*{\memofor}[1]{\gdef\@memofor{#1}}
\newcommand*{\subject}[1]{\gdef\@subject{#1}}
\newcommand*{\enclosures}[1]{\gdef\@enclosures{#1}}
\global\let\@memothru\relax       % optional
\global\let\@enclosures\relax   % optional

% Army date format. Note this is the long month name. AR25-50 Section 1-23a
\newdateformat{armydate}{\THEDAY\ \monthname[\THEMONTH] \THEYEAR}

% Commands to create armymemo items, subitems, and subsubitems
\newcounter{ami}
\newcounter{amii}[ami]
\newcounter{amiii}[amii]

% Use a helper macro that will indent correctly, followed by the item number
% Items are indented by 0.25in increments - AR25-50 Figure 2-1 Paragraph 3
% #1 Indentation
% #2 Item number
\newcommand*{\@amitem}[2]{\hspace{#1}\makebox[0.25in][l]{#2}}
\newcommand*{\ami}{\refstepcounter{ami}\@amitem{0in}{\arabic{ami}. }}
\newcommand*{\amii}{\refstepcounter{amii}\@amitem{0.25in}{\alph{amii}. }}
\newcommand*{\amiii}{\refstepcounter{amiii}\@amitem{0.5in}{(\arabic{amiii}) }}

\newcommand{\makeheader}{
  \thispagestyle{plain}
  \pagestyle{body}
  \@officesymbol\hfill\armydate\@date\\~\\~\\
  \ifdefvoid{\@memothru}{
    MEMORANDUM FOR \@memofor\\~\\
  }{
    MEMORANDUM THRU \@memothru\\~\\
    FOR \@memofor\\~\\
  }
  SUBJECT: \@subject\\~\\~\\
}

% #1 Name
% #2 Rank, Branch
% #3 Title
\newcommand{\makesigblock}[3]{
  \setlength{\parskip}{0pt}
  \begin{minipage}[t]{\textwidth}   % minipage to keep sigblock on one page
    \vspace{3\baselineskip}
    \ifdefvoid{\@enclosures}{}{
      \parbox[t]{0.28\textwidth}{Encl:\\
        \begin{hangparas}{0.25in}{1}
          \@enclosures
        \end{hangparas}
      }
    }
    \hfill\parbox[t]{0.5\textwidth}{%
      \MakeUppercase{#1}\\
      \MakeUppercase{#2}\\
      #3
    }
  \end{minipage}
}

% Redefine the plain page style. This style should be applied automatically by the \makeheader
% command. This style creates the memo letterhead.
\fancypagestyle{plain}{
  \fancyhf{}
  \setlength{\headheight}{56pt}

  \lhead{
    {\begin{tikzpicture}[remember picture, overlay]
      \node[yshift=20pt] at (0,0) {\includegraphics[height=1in]{dodlogo.eps}};
    \end{tikzpicture}}
  }

  \chead{
    {\begin{sffamily}\begin{bfseries}
      {\footnotesize\MakeUppercase{\@department}} \\
      {\scriptsize
        \MakeUppercase{\@unit} \\
        \MakeUppercase{\@unitaddress} \\
        \MakeUppercase{\@unitcity} \\
      }
    \end{bfseries}\end{sffamily}}
  }

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% Define the page style for the body of the memo. This style should be applied automatically by the
% \makeheader command. This style will apply to all pages except the first.
\fancypagestyle{body}{
  \setlength{\headheight}{30pt}

  \lhead[]{
    \@officesymbol\\
    SUBJECT: \@subject
  }
  \fancyfoot[C]{\thepage}

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
