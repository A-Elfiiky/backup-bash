#!/bin/bash

source backup_restore_lib.sh

# Validate the parameters
validate_backup_params "$@"

# Store command-line parameters
source_dir="$1"
backup_dir="$2"
encryption_key="$3"
days="$4"

# Format the date
formatted_date=$(date +%Y-%m-%d_%H-%M-%S | sed 's/[\s:]/_/g')

# Create backup directory
backup_directory="${backup_dir}/${formatted_date}"
mkdir -p "$backup_directory"

# Loop over directories
while IFS= read -r -d '' directory; do
  # Get the directory name
  dir_name=$(basename "$directory")

  # Find modified files within the specified number of days
  modified_files=$(find "$directory" -type f -mtime "-${days}")

  if [[ -n "$modified_files" ]]; then
    # Create directory-wise tar.gz backups
    tar_file="${dir_name}_${formatted_date}.tgz"
    tar -czf "${backup_directory}/${tar_file}" -C "$(dirname "$directory")" "$dir_name"

    # Encrypt the tar.gz files
    gpg --batch --passphrase "$encryption_key" -c "${backup_directory}/${tar_file}"

    # Delete original tar files
    rm "${backup_directory}/${tar_file}"
  fi
done < <(find "$source_dir" -type d -print0)

# Create a combined tar.gz backup for files
file_tar_file="files_${formatted_date}.tar.gz"
find "$source_dir" -type f -mtime "-${days}" -print0 | tar --create --null --files-from=- -z --file="${backup_directory}/${file_tar_file}"

# Encrypt the combined tar.gz file
gpg --batch --passphrase "$encryption_key" -c "${backup_directory}/${file_tar_file}"

# Delete the original tar.gz file
rm "${backup_directory}/${file_tar_file}"

# Copy backup to remote server
# Configure the following command to copy the encrypted backup to the remote server
# Replace <remote_user> and <remote_host> with the appropriate values
scp "${backup_directory}/${file_tar_file}.gpg" <remote_user>@<remote_host>:/path/to/remote/backup/directory/
