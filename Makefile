TEXMFHOME := $(shell kpsewhich -var-value=TEXMFHOME)
INSTALL_DIR := $(TEXMFHOME)/tex/xelatex

all: armymemo.cls armymemo.pdf

doc: armymemo.pdf

install: armymemo.cls dodlogo.eps
	mkdir -p $(INSTALL_DIR)
	cp $^ $(INSTALL_DIR)

dist: armymemo.dtx armymemo.ins armymemo.pdf dodlogo.eps README.md
	mkdir armymemo
	cp $^ armymemo/
	tar czf armymemo.tar.gz armymemo
	$(RM) -r armymemo

armymemo.cls: armymemo.ins armymemo.dtx
	latex $<

armymemo.pdf: armymemo.dtx
	pdflatex $<
	makeindex -s gglo.ist -o armymemo.gls armymemo.glo
	makeindex -s gind.ist -o armymemo.ind armymemo.idx
	pdflatex $<

clean:
	$(RM) *.aux *.cls *.glo *.gls *.idx *.ilg *.ind *.log *.pdf *.tar.gz
