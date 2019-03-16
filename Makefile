pdf: example.pdf

example.pdf: example.tex example-long.tex armymemo.cls
	latexmk -pdf -lualatex example.tex
	latexmk -pdf -lualatex example-long.tex

check: armymemo.cls
	chktex armymemo.cls

clean:
	-rm -f \
		*-blx.bib \
		*.aux \
		*.bbl \
		*.bcf \
		*.blg \
		*.brf \
		*.dvi \
		*.ent \
		*.fdb_latexmk \
		*.idx \
		*.ilg \
		*.ind \
		*.lof \
		*.log \
		*.lot \
		*.orig \
		*.out \
		*.rtf \
		*.run.xml \
		*.toc \
		*.url 

