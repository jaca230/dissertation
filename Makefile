PDF=main.pdf

all:
	cd src && latexmk -C -output-directory=../build main.tex
	cd src && latexmk -pdf -synctex=1 -interaction=nonstopmode -output-directory=../build main.tex

playground:
	./scripts/env/create_playground.sh

examples: playground
	$(MAKE) -C .playground all

clean:
	cd src && latexmk -C -output-directory=../build main.tex
	if [ -d .playground ]; then $(MAKE) -C .playground clean; fi
	rm -rf build
