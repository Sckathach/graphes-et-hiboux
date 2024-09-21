# Install OWL

Archlinux packages:  
```shell
pacman -S lapacke openblas
yay -S plplot
```

Using opam:
```shell
opam install owl=1.0.2
opam install owl-jupyter
# opam pin add git+https://github.com/owlbarn/owl-pyplot.git
```

Install jupyter notebook compatibility:
```shell
opam install jupyter
ocaml-jupyter-opam-genspec
jupyter kernelspec install --name ocaml-jupyter --user "$(opam config var share)/jupyter"
echo '#use "topfind";;' >> ~/.ocamlinit
```
> Warning: `python-jupyter` must be installed, either with a venv or globally.
