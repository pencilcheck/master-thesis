MAIN=thesis

.SUFFIXES: .tex

all: $(MAIN).pdf

$(MAIN).pdf: $(wildcard *.tex) ntu.sty
	pdflatex $(MAIN)
	bibtex $(MAIN)
	pdflatex $(MAIN)
	pdflatex $(MAIN)

.tex: 
	pdflatex $*
	pdflatex $*

clean:
	rm -f *.log *.aux *.dvi *.lof *.lot *.toc *.bbl *.blg

purge: 
	$(MAKE) clean
	rm -f *.pdf

clean-all: clean clean-pdf
