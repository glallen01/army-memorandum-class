# Army Memorandum LaTeX Class

Provides a basic AR 25-50 memo in latex.

## Setup

* Requires LuaLaTeX or XeLaTeX for font handling.
* Install Arial font ("preferred" by AR 25-50 1-17)

Debian:
```bash
sudo apt-get install ttf-mscorefonts-installer
sudo fc-cache
fc-match Arial
```

Fedora:

## Usage

See `example.tex` and (TODO) template.tex.

A minimum set of declarations are required for the office-symbol, subject,
signature block, etc. After these options, within `\begin{document}` ...
`\end{document}`, the structure is based on an `enumerate` list. This is a major
break from the previous version, but much better for writing, as a good LaTeX
editor will facilitate editing the nested list. Also, I intend to tie this into
my emacs org-mode configuration eventually to further ease writing.

The basic structure looks like:

```latex
\documentclass{armymemo}

\author{John W. Smith}
\rank{CPT}
\branch{CY}
\officesymbol{ABC-DEF-GH}
\signaturedate{10 April 2019}
\memoline{MEMORANDUM FOR RECORD}
\subject[(U) ]{The creation of memos using \LaTeX}
\authority{BY ORDER OF THE COMMANDER}

\begin{document}

\begin{enumerate}
\item This memo is a demo.
\item This item contains sub items.
  \begin{enumerate}
  \item Thing one.
  \item Thing two.
  \end{enumerate}
\item Point of contact is the undersigned.
\end{enumerate}

\end{document}
```

## Compile

```bash
latexmk -pdf -pvc -lualatex example.tex
```

## Thanks
Thanks to @jschaf for enumitem and a better document template, also @pconwell, @kjelderg, @nelsonrg, and others.


-----------------------------------------------------------------------------
Copyright (c) 2011 George Allen, All rights reserved.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA  02111-1307  USA
