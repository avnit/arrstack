import os
import shutil
from datetime import datetime

def create_timestamped_directory(base_path):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    new_dir = os.path.join(base_path, f"screenshots_{timestamp}")
    os.makedirs(new_dir, exist_ok=True)
    return new_dir

def copy_screenshot_to_directory(screenshot_path, directory):
    shutil.copy2(screenshot_path, directory)

def sort_screenshots_by_date(directory):
    screenshots = [f for f in os.listdir(directory) ]
    screenshots.sort(key=lambda x: os.path.getmtime(os.path.join(directory, x)))
    return screenshots

def sort_screenshots_by_name(directory):
    screenshots = [f for f in os.listdir(directory) ]
    screenshots.sort()
    return screenshots

def sort_screenshots_by_size(directory):
    screenshots = [f for f in os.listdir(directory) ]
    screenshots.sort(key=lambda x: os.path.getsize(os.path.join(directory, x)))
    return screenshots

def move_screenshots_to_directory(directory:str, destination_folder):
    for file in os.listdir(directory):
        date_str = datetime.fromtimestamp(os.path.getmtime(os.path.join(directory, file))).strftime("%Y-%m-%d")
        # date_folder = os.path.join(directory, date_str)
        # os.makedirs(date_folder, exist_ok=True)
        shutil.move(os.path.join(directory, file), os.path.join(destination_folder, file))
        print(f"Moved {file} to {destination_folder}")

def main():
    base_path = "C:\\Users\\abamb\\Downloads"
    timestamped_dir = create_timestamped_directory(base_path)
    # Copy a screenshot to the new directory
    # Example usage: copy a screenshot file from base_path to the new directory
    # Replace 'example_screenshot.png' with your actual screenshot filename
   
    # Sort screenshots
    print(sort_screenshots_by_date(base_path))
    print(sort_screenshots_by_name(base_path))
    print(sort_screenshots_by_size(base_path))
    # Move screenshots
    move_screenshots_to_directory(base_path, timestamped_dir)

if __name__ == "__main__":
    main()