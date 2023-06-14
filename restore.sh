#!/bin/bash

source backup_restore_lib.sh

# Validate the parameters
validate_restore_params "$@"

# Store command-line parameters
backup_dir="$1"
restore_dir="$2"
decryption_key="$3"

# Create a temporary directory
temp_dir="${restore_dir}/temp"
mkdir -p "$temp_dir"

# Loop over backup files
while IFS= read -r -d '' backup_file; do
  # Decrypt the backup files
  decrypted_file="${temp_dir}/$(basename "$backup_file" .gpg)"
  gpg --batch --passphrase "$decryption_key" -o "$decrypted_file" -d "$backup_file"

  # Extract files to restore directory
  tar -xf "$decrypted_file" -C "$restore_dir"
done < <(find "$backup_dir" -type f -name "*.gpg" -print0)
