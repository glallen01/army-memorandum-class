MD=$(wildcard *.md)
TEX=$(wildcard *.tex)

main:
	pandoc -o out.pdf --pdf-engine=xelatex --template=default.latex main.md

clean:
	rm *.pdf

