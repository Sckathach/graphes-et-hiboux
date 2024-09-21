#!/bin/bash

# Default filename
filename="hibou"

# If an argument is given, use it as the filename
if [ ! -z "$1" ]; then
  filename="$1"
fi

# Create the .ipynb file with content
cat > "${filename}.ipynb" <<EOF
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "initial_id",
   "metadata": {
    "collapsed": true,
    "ExecuteTime": {
     "end_time": "2024-03-22T22:29:06.845100Z",
     "start_time": "2024-03-22T22:29:06.844400Z"
    }
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Hello world!\\n"
     ]
    }
   ],
   "source": [
    "#use \\"topfind\\"\\n",
    "#require \\"owl-top, owl-plplot, owl-jupyter, jupyter.notebook\\"\\n",
    "open Owl_plplot\\n",
    "open Owl_jupyter\\n",
    "open Owl"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "name": "ocaml-jupyter",
   "language": "OCaml",
   "display_name": "OCaml default"
  },
  "language_info": {
   "codemirror_mode": "text/x-ocaml",
   "file_extension": ".ml",
   "mimetype": "text/x-ocaml",
   "name": "OCaml",
   "nbconvert_exporter": null,
   "pygments_lexer": "OCaml",
   "version": "4.04.2"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF
