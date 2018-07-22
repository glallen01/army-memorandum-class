
Army Memorandum LaTeX Class
============

![Sample Memo](example.pdf)

## Purpose
Provides a basic AR 25-50 memo in LaTeX.
## Requirements
- Requires XeLaTeX for font handling.
- Requires the Arial font to be installed, if it's not already.
### Ubuntu
To install the XeLaTeX, run the following commands:
```
sudo apt-get install texlive-xetex
```
To install the Arial font:
```
sudo apt-get install ttf-mscorefonts-installer
sudo fc-cache
```
### MacOS
The Arial font will already be installed, but you will need to install XeLaTeX [here](http://www.tug.org/mactex/index.html).
### Windows
I currently don't have a method of testing this on Windows.

## Installation and Usage
Within a terminal:
```
git clone https://github.com/git@github.com:rgnelson00/army-memorandum-class.git
cd army-memorandum
make
```
You'll find the file `example.pdf` in the directory.
To change the data, use your favorite text editor to edit `example.tex` and then run `make` again.

## Credits
This is a fork from George Allen's project and his collaborators.
Modifications made by Roberts Nelson.

-----------------------------------------------------------------------------

Thanks for updates from:
 Patrick Conwell (2014-)
 Eric Kjeldergaard (2015-)


-----------------------------------------------------------------------------
## License
Copyright (c) 2011 George L. Allen <glallen01@gmail.com> All rights reserved.

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
