EXEC=main
DOTFILE=graph

build:
	dune build

run: build
	dune exec ./_build/default/bin/$(EXEC).exe

clear:
	hibou clear bin

doc:
	dune build @doc
	firefox ./_build/default/_doc/_html/index.html

format:
	dune build --auto-promote @fmt

.SILENT:
dot: run 
	dot -Tsvg _output/$(DOTFILE).dot > _output/$(DOTFILE).html 
	firefox _output/$(DOTFILE).html
