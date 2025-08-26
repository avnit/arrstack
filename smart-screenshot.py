import os
import shutil
import argparse
from datetime import datetime

def create_timestamped_directory(base_path):
    """Creates a timestamped directory for storing screenshots."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    new_dir = os.path.join(base_path, f"screenshots_{timestamp}")
    os.makedirs(new_dir, exist_ok=True)
    return new_dir

def move_screenshots_to_directory(source_dir, destination_dir):
    """Moves all files from the source directory to the destination directory."""
    if not os.path.isdir(source_dir):
        print(f"Error: Source directory '{source_dir}' not found.")
        return

    for file in os.listdir(source_dir):
        source_path = os.path.join(source_dir, file)
        destination_path = os.path.join(destination_dir, file)
        shutil.move(source_path, destination_path)
        print(f"Moved {file} to {destination_dir}")

def main():
    """Organizes screenshots into a timestamped directory."""
    parser = argparse.ArgumentParser(description="Organize screenshots into a timestamped directory.")
    parser.add_argument("source_directory", nargs="?", default=".", help="The directory containing the screenshots to organize. Defaults to the current directory.")
    args = parser.parse_args()

    source_directory = args.source_directory
    timestamped_dir = create_timestamped_directory(source_directory)
    move_screenshots_to_directory(source_directory, timestamped_dir)

if __name__ == "__main__":
    main()
