DOT_FILES = $(wildcard figures/*.dot)
PNG_GRAPH_FILES = $(DOT_FILES:.dot=.generated.png)

paper: figures
	sed -E 's!\(figures/(.+\.)dot\)!(figures/\1generated.png)!g' paper.Rmd > generated_paper.Rmd
	Rscript -e "require(rmarkdown); render('generated_paper.Rmd', output_format='all')"
	rm generated_paper.Rmd

figures: $(PNG_GRAPH_FILES)

clean:
	rm -f figures/*.generated.png
	rm -f generated_paper.*

%.generated.png: %.dot
	@dot -Gdpi=600 -Tpng $< > $@