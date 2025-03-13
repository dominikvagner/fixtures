#!/bin/bash

NUM_RPMS=12

# Create a directory to store all RPM files
mkdir -p tests

# Function to create a directory with a specific combination of RPMs
create_dir_with_rpms() {
  local dir_num=$1
  local combination=$2

  # Create the directory
  mkdir -p "tests/test-${dir_num}"

  # Create symlinks or copy the RPMs based on the combination
  for rpm_id in $combination; do
    # Either copy or create symlink (using cp for actual files)
    nth_file=$(ls -1 ~/Documents/dummy_rpms | sort | sed -n "${rpm_id}p")
    cp "$HOME/Documents/dummy_rpms/$nth_file" "tests/test-${dir_num}"
    createrepo "tests/test-${dir_num}"
    # Alternative: ln -s "../rpm_source/sample-package-${rpm_id}.rpm" "rpm_dir_${dir_num}/"
  done
}

# Create 1000 directories with different combinations
dir_count=1
for size in $(seq 1 $NUM_RPMS); do
  # Use combinations of different sizes
  for ((mask = 1; mask < (1 << NUM_RPMS); mask++)); do
    # Check if the number of bits set matches our desired size
    if [ $(bc <<<"obase=2; $mask" | tr -cd '1' | wc -c) -eq $size ]; then
      # Convert mask to the list of RPM files to include
      combination=""
      for ((bit = 0; bit < NUM_RPMS; bit++)); do
        if (((mask >> bit) & 1)); then
          combination+="$((bit + 1)) "
        fi
      done

      create_dir_with_rpms $dir_count "$combination"
      ((dir_count++))

      # Stop after creating 1000 directories
      if [ $dir_count -gt 2500 ]; then
        echo "Created 2500 directories/repos with different RPM combinations"
        exit 0
      fi
    fi
  done
done

echo "Created $((dir_count - 1)) directories with different RPM combinations"
