set -x 
source_files="srcNoReaderSync/Utilities/threading/threading.cpp srcNoReaderSync/Utilities/io/io.cpp srcNoReaderSync/index.cpp srcNoReaderSync/Library/Library.cpp srcNoReaderSync/Reader/Reader.cpp"
exe_file="solutionNoReaderSync.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -f data/1/in.in