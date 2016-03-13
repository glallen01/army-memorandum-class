pdf: example.pdf


example.pdf: example.tex armymemo.cls
	xelatex example.tex
	xelatex example.tex

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
		*.pdf \
		*.rtf \
		*.run.xml \
		*.toc \
		*.url 

