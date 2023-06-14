#!/bin/bash

# Get the current directory
current_dir="$(dirname "$(readlink -f "$0")")"

# Create test files with different modification times
echo "Creating test files..."

# Directory structure:
# ./test_files/
# ├── dir1/
# │   ├── file1.txt (modified 5 days ago)
# │   ├── file2.txt (modified 3 days ago)
# │   └── file3.txt (modified 1 day ago)
# ├── dir2/
# │   ├── file4.txt (modified 2 days ago)
# │   └── file5.txt (modified 4 days ago)
# ├── file6.txt (modified 6 days ago)
# ├── file7.txt (modified 8 days ago)
# └── file8.txt (modified 10 days ago)

# Create directories
mkdir -p "$current_dir/test_files/dir1"
mkdir -p "$current_dir/test_files/dir2"

# Create files with different modification times
touch -d "10 days ago" "$current_dir/test_files/file8.txt"
touch -d "8 days ago" "$current_dir/test_files/file7.txt"
touch -d "6 days ago" "$current_dir/test_files/file6.txt"
touch -d "5 days ago" "$current_dir/test_files/dir1/file1.txt"
touch -d "3 days ago" "$current_dir/test_files/dir1/file2.txt"
touch -d "1 day ago" "$current_dir/test_files/dir1/file3.txt"
touch -d "4 days ago" "$current_dir/test_files/dir2/file4.txt"
touch -d "2 days ago" "$current_dir/test_files/dir2/file5.txt"

echo "Test files created successfully."
