import os
import re
from collections import defaultdict

# Regular expressions for parsing files, classes, and function calls
file_pattern = re.compile(r'#include\s+"(.+?\.h)"')
class_pattern = re.compile(r'class\s+(\w+)')
function_pattern = re.compile(r'(\w+)\s+(\w+)\s*\(')

# Dictionary for storing dependencies
dependencies = defaultdict(set)

# Directory to search for C++ files
directory = '/Users/didenkos/Desktop/Projects/framework/src/PryonConfig/src'

# Traverse through the directory tree and process all C++ files
for root, dirs, files in os.walk(directory):
    for file_name in files:
        if file_name.endswith(('.cpp', '.h')):
            file_path = os.path.join(root, file_name)
            with open(file_path, 'r') as file:
                # Parse file dependencies
                for match in file_pattern.finditer(file.read()):
                    dependencies[file_name].add(match.group(1))
                # Parse class and function dependencies
                for line in file:
                    match = class_pattern.search(line)
                    if match:
                        dependencies[file_name].add(match.group(1))
                    match = function_pattern.search(line)
                    if match:
                        dependencies[file_name].add(match.group(1))

# Write the .dot file
with open('dependency_graph.dot', 'w') as file:
    file.write('digraph DependencyGraph {\n')
    for source, targets in dependencies.items():
        for target in targets:
            file.write(f'  "{source}" -> "{target}";\n')
    file.write('}')

# Print a message with instructions to generate the graph using Graphviz
print('Dependency graph generated in dependency_graph.dot. To generate an image, run the following command:')
print('dot -Tpng dependency_graph.dot -o dependency_graph.png')
