import json
import os
import sys


def update_execution_count(folder_path):
    files = os.listdir(folder_path)

    for file_name in files:
        if file_name.endswith('.ipynb'):
            full_path = os.path.join(folder_path, file_name)

            try:
                with open(full_path, 'r', encoding='utf-8') as file:
                    notebook = json.load(file)
            except Exception as e:
                print(f"Error reading {file_name}: {e}")
                continue

            execution_count = 1
            for cell in notebook['cells']:
                if cell['cell_type'] == 'code':
                    cell['execution_count'] = execution_count
                    execution_count += 1

            try:
                with open(full_path, 'w', encoding='utf-8') as file:
                    json.dump(notebook, file, indent=2)
            except Exception as e:
                print(f"Error writing {file_name}: {e}")
                continue

            print(f"Updated notebook {file_name} saved to {full_path}.")


if __name__ == "__main__":
    if len(sys.argv) > 2:
        print("Usage: python clear_execution_count.py <directory_path>")
        sys.exit(1)

    if len(sys.argv) == 1:
        directory_path = '.'
    else:
        directory_path = sys.argv[1]

    update_execution_count(directory_path)
