DATE="$(date +%Y-%m-%d)"
DATE_YESTERDAY="$(date -d 'yesterday' +%Y-%m-%d)"

echo $DATE
echo $DATE_YESTERDAY

git clone https://github.com/BaconBreaker/sudoku_solver_generator_golang.git
mkdir puzzles/$DATE/
mkdir solutions/$DATE/
cd sudoku_solver_generator_golang

#create puzzles
echo "Generating puzzles"
go run . -task "generate" -n_filled_cells 38 -save_path "../puzzles/$DATE/easy.txt"
go run . -task "generate" -n_filled_cells 30 -save_path "../puzzles/$DATE/medium.txt"
go run . -task "generate" -n_filled_cells 30 -save_path "../puzzles/$DATE/hard.txt"

#find solutions
echo "Finding solutions"
go run . -task "solve" -file_path "../puzzles/$DATE/easy.txt" -save_path "../solutions/$DATE/easy.txt"
go run . -task "solve" -file_path "../puzzles/$DATE/medium.txt" -save_path "../solutions/$DATE/medium.txt"
go run . -task "solve" -file_path "../puzzles/$DATE/hard.txt" -save_path "../solutions/$DATE/hard.txt"

cd ..

print_func () {
    echo "\`\`\`" >> "$2"
    while IFS= read -r line
    do
        echo "$line" >> "$2"
    done < "$1"
    echo "\`\`\`" >> "$2"
}

echo "" > README.md

echo "# daily_sudoku_puzzles \n" >> README.md

echo "Collection of daily sudoku puzzles automated with GitHub workflows \n" >> README.md
echo "Puzzles are generated using my other library https://github.com/BaconBreaker/sudoku_solver_generator_golang \n \n" >> README.md

echo "# Todays puzzles are \n" >> README.md
echo "## Easy \n" >> README.md
print_func "puzzles/$DATE/easy.txt" "README.md"

echo "## Medium \n" >> README.md
print_func "puzzles/$DATE/medium.txt" "README.md"

echo "## Hard \n" >> README.md
print_func "puzzles/$DATE/hard.txt" "README.md"

echo "# Yesterdays solutions are \n" >> README.md
echo "## Easy \n" >> README.md
print_func "solutions/$DATE_YESTERDAY/easy.txt" "README.md"

echo "## Medium \n" >> README.md
print_func "solutions/$DATE_YESTERDAY/medium.txt" "README.md"

echo "## Hard \n" >> README.md
print_func "solutions/$DATE_YESTERDAY/hard.txt" "README.md"