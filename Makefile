pdf: 00-Main.pdf


00-Main.pdf: 00-Main.tex armymemo.cls
	pdflatex 00-Main.tex
	pdflatex 00-Main.tex

clean:
	-rm -f \
		*.fdb_latexmk \
		*.bbl \
		*.log \
		*.aux \
		*.blg \
		*.dvi \
		*.pdf \
		*.toc \
		*.url \
		*.lof \
		*.orig \
		*.idx \
		*.ilg \
		*.ind \
		*.out \
		*.lot \
		*.url \
		00-Main.bcf \
		00-Main-blx.bib \
		00-Main.brf \
		00-Main.ent \
		00-Main.rtf \
		00-Main.run.xml

