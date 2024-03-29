SRC=$(wildcard *.tex)
MAKEFLAGS=-j

.PHONY: clean proper check force

all: $(SRC:.tex=.pdf) force ../armymemo.cls

%.pdf: %.tex
	if [ -x ../latexrun ]; then ../latexrun --latex-cmd lualatex -W no-overfull --color always "$<"; else latexmk -lualatex "$<"; fi

# https://github.com/aclements/latexrun

# convert -thumbnail x400 -background white -alpha remove -density 300 example.pdf example.png
# convert -thumbnail x400 -background white -alpha remove -density 150 example.pdf example.png
# convert -thumbnail x400 -background white -alpha remove -density 150 -trim example.pdf example.png
# convert           \\n   -verbose       \\n   -density 150   \\n   -trim          \\nexample.pdf \\n-resize 50% -quality 100 \\n-flatten \\n-sharpen 0x1.0 \\nexample.png
# convert           \\n   -verbose       \\n   -density 150   \\n   -trim          \\nexample.pdf \\n-quality 100 \\n-flatten \\n-sharpen 0x1.0 \\nexample.png
# convert -density 300 -trim example.pdf -quality 100 example.png


check: ../armymemo.cls
	chktex ../armymemo.cls

clean:
	-rm -f \
		example*.pdf \
		*-blx.bib \
		*.aux \
		*.bbl \
		*.bcf \
		*.blg \
		*.brf \
		*.dvi \
		*.ent \
		*.fdb_latexmk \
		*.fls \
		*.idx \
		*.ilg \
		*.ind \
		*.lof \
		*.log \
		*.lot \
		*.orig \
		*.rtf \
		*.run.xml \
		*.toc \
		*.url 
proper: clean
	-rm -rf *.out
