build:
	dune build

.SILENT:
run: build
	dune exec ./_build/default/bin/main.exe

clear:
	hibou clear bin

doc:
	dune build @doc
	firefox ./_build/default/_doc/_html/index.html

format:
	dune build --auto-promote @fmt

.SILENT:
dot: run 
	dot -Tsvg output/graph.dot > output/graph.html 
	firefox output/graph.html
