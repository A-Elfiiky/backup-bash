#!/bin/bash

# Function to validate backup parameters
validate_backup_params() {
  if [[ $# -ne 4 ]]; then
    echo "Error: Invalid number of parameters."
    echo "Usage: $0 <source_dir> <backup_dir> <encryption_key> <days>"
    exit 1
  fi

  source_dir="$1"
  backup_dir="$2"
  encryption_key="$3"
  days="$4"

  # Validate source directory
  if [[ ! -d "$source_dir" ]]; then
    echo "Error: Source directory '$source_dir' does not exist."
    exit 1
  fi

  # Validate backup directory
  if [[ ! -d "$backup_dir" ]]; then
    echo "Error: Backup directory '$backup_dir' does not exist."
    exit 1
  fi

  # Validate encryption key
  if [[ -z "$encryption_key" ]]; then
    echo "Error: Encryption key is required."
    exit 1
  fi

  # Validate number of days
  if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid number of days."
    exit 1
  fi
}

# Function to validate restore parameters
validate_restore_params() {
  if [[ $# -ne 3 ]]; then
    echo "Error: Invalid number of parameters."
    echo "Usage: $0 <backup_dir> <restore_dir> <decryption_key>"
    exit 1
  fi

  backup_dir="$1"
  restore_dir="$2"
  decryption_key="$3"

  # Validate backup directory
  if [[ ! -d "$backup_dir" ]]; then
    echo "Error: Backup directory '$backup_dir' does not exist."
    exit 1
  fi

  # Validate restore directory
  if [[ ! -d "$restore_dir" ]]; then
    echo "Error: Restore directory '$restore_dir' does not exist."
    exit 1
  fi

  # Validate decryption key
  if [[ -z "$decryption_key" ]]; then
    echo "Error: Decryption key is required."
    exit 1
  fi
}
