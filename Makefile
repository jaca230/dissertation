PDF=main.pdf

all:
	latexmk -pdf -synctex=1 -interaction=nonstopmode -output-directory=build src/main.tex

clean:
	latexmk -C src/main.tex
	rm -rf build
