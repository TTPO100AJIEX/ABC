set -x 
source_files="srcAlternative/Utilities/threading/threading.cpp srcAlternative/Utilities/io/io.cpp srcAlternative/index.cpp srcAlternative/Library/Library.cpp srcAlternative/Reader/Reader.cpp"
exe_file="solutionAlternative.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -r