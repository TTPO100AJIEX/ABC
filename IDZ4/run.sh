set -x 
source_files="src/Utilities/threading/threading.cpp src/Utilities/io/io.cpp src/index.cpp src/Library/Library.cpp src/Reader/Reader.cpp"
exe_file="solution.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -r