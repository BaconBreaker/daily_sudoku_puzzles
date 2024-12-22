#!/bin/bash

DATE="${date +'%Y-%m-%d'}"

git clone https://github.com/BaconBreaker/sudoku_solver_generator_golang.git
mkdir puzzles/$DATE/
mkdir solutions/$DATE/
cd sudoku_solver_generator_golang

#create puzzles
go run . -task "generate" -n_filled_cells 38 -save_path "../puzzles/$DATE/easy.txt"
go run . -task "generate" -n_filled_cells 30 -save_path "../puzzles/$DATE/medium.txt"
go run . -task "generate" -n_filled_cells 25 -save_path "../puzzles/$DATE/hard.txt"

#find solutions
go run . -task "solve" -file_path "../puzzles/$DATE/easy.txt" -save_path "../solutions/$DATE/easy.txt"
go run . -task "solve" -file_path "../puzzles/$DATE/medium.txt" -save_path "../solutions/$DATE/medium.txt"
go run . -task "solve" -file_path "../puzzles/$DATE/hard.txt" -save_path "../solutions/$DATE/hard.txt"

cd ..
