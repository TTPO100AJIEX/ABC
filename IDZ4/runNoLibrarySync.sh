set -x 
source_files="srcNoLibrarySync/Utilities/threading/threading.cpp srcNoLibrarySync/Utilities/io/io.cpp srcNoLibrarySync/index.cpp srcNoLibrarySync/Library/Library.cpp srcNoLibrarySync/Reader/Reader.cpp"
exe_file="solutionNoLibrarySync.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -f data/1/in.in