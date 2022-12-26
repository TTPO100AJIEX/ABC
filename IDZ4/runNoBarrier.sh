set -x 
source_files="srcNoBarrier/Utilities/threading/threading.cpp srcNoBarrier/Utilities/io/io.cpp srcNoBarrier/index.cpp srcNoBarrier/Library/Library.cpp srcNoBarrier/Reader/Reader.cpp"
exe_file="solutionNoBarrier.exe"

rm $exe_file
g++ $source_files -lpthread -std=c++20 -fsanitize=address,undefined -fno-sanitize-recover=all -Wall -Werror -Wsign-compare -o $exe_file
./$exe_file -f data/1/in.in