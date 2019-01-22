# Army Memorandum LaTeX Class

This package provides a document class for Army memorandums in accordance with
AR 25-50.

This package requires xelatex for font processing and the Arial font. To
install the font in debian:

    sudo apt-get install ttf-mscorefonts-installer
    sudo fc-cache

To install this class, copy armymemo.cls and dodlogo.eps to your xelatex
directory. You can do so with the following command.

    cp armymemo.cls dodlogo.eps `kpsewhich -var-value=TEXMFHOME`/tex/xelatex/armymemo/

To build and install from source, you can use the provided Makefile or extract
the .cls file and documentation manually with latex.

    make
    make install


## Copyright

Copyright (c) 2011 George L. Allen <glallen01@gmail.com>
Copyright (c) 2019 Christian J. Sharpsten

This package is a derivative work from army-memorandum-class by George L.
Allen, which is licensed GPLv2. This package is therefore also licensed under
the terms of the GNU Public License, version 2.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
