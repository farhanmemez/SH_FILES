#!/bin/bash

# Configuration
package_name="com.pubg.imobile"
obb_file_path="/storage/emulated/0/BABAMODZ/DONT_DELETE/obb_file_name.txt"
activation_obb_directory="/sdcard/Android/ACTIVATION"
modded_obb_directory="/sdcard/Android/MOD"
main_obb_directory="/storage/emulated/0/Android/obb/com.pubg.imobile"

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Function to retrieve version information
retrieve_version_info() {
    version_code=$(dumpsys package "$package_name" | grep versionCode | sed -E 's/.*versionCode=([0-9]+).*/\1/' | head -1)
    version_name=$(dumpsys package "$package_name" | grep versionName | sed -E 's/.*versionName=([0-9.]+).*/\1/' | head -1)

    if [ -z "$version_code" ] || [ -z "$version_name" ]; then
        handle_error "Failed to retrieve version information for $package_name"
    fi
}

# Function to store the OBB file name
store_obb_file_name() {
    local obb_file_name="$1"
    echo "$obb_file_name" > "$obb_file_path" || handle_error "Failed to store OBB file name"
    echo "Stored OBB file name: $obb_file_name"
}

# Function to copy OBB file with progress indication
copy_obb_file() {
    local source_directory="$1"
    local destination_directory="$2"
    local obb_file_name="$3"

    echo "Copying OBB file: $obb_file_name"
    local total_size=$(stat -c %s "$source_directory/$obb_file_name")
    cp "$source_directory/$obb_file_name" "$destination_directory/$obb_file_name" || handle_error "Failed to copy OBB file: $obb_file_name"
    local copied_size=$(stat -c %s "$destination_directory/$obb_file_name")
    local copied_mb=$(echo "scale=2; $copied_size / (1024 * 1024)" | bc)
    local total_mb=$(echo "scale=2; $total_size / (1024 * 1024)" | bc)
    echo "Copied: $copied_mb MB / $total_mb MB"
}

# Main function
main() {
    # Check if the OBB file name is already stored in the file
    if [ -f "$obb_file_path" ]; then
        local stored_obb_file_name=$(cat "$obb_file_path")
        if [ -n "$stored_obb_file_name" ]; then
          #  echo "OBB file name found: $stored_obb_file_name"
            # Retrieve version information
            retrieve_version_info
            # Construct the expected OBB file name
            local expected_obb_file_name="main.${version_code}.${package_name}.obb"
            # Check if the stored OBB file name matches the expected one
            if [ "$stored_obb_file_name" != "$expected_obb_file_name" ]; then
                store_obb_file_name "$expected_obb_file_name"
            fi
        fi
    fi

    # Retrieve version information if not already retrieved
    if [ -z "$version_code" ]; then
        retrieve_version_info
    fi

    # Construct the expected OBB file name
    local expected_obb_file_name="main.${version_code}.${package_name}.obb"

    # Store the OBB file name if not already stored
    if [ ! -f "$obb_file_path" ]; then
        store_obb_file_name "$expected_obb_file_name"
    fi

    # Increment counter
    local counter_file="/sdcard/BABAMODZ/DONT_DELETE/counter.txt"
    local count=0
    if [ -f "$counter_file" ]; then
        count=$(($(<"$counter_file") + 1))
    fi
    echo "$count" >"$counter_file" || handle_error "Failed to write to counter file"

    # Copy OBB file based on counter
    local source_directory=""
    if ((count % 2 == 1)); then
        source_directory="$activation_obb_directory"
        echo "Activation OBB Task"
    else
        source_directory="$modded_obb_directory"
        echo "Modded OBB Task"
    fi
    copy_obb_file "$source_directory" "$main_obb_directory" "$expected_obb_file_name"

    echo "SUCCESSFULLY APPLIED.."
}

# Execute main function
main
