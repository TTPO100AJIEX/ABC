set -x 
source_files="srcNoMutex/Utilities/threading/threading.cpp srcNoMutex/Utilities/io/io.cpp srcNoMutex/index.cpp srcNoMutex/Library/Library.cpp srcNoMutex/Reader/Reader.cpp"
exe_file="solutionNoMutex.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -f data/1/in.in