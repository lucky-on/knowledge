import os
import optparse

#TODO consider differnt number of spaces
include_notation = "#include \""

valid_headers = ['.h', '.hh', '.hpp']
valid_sources = ['.c', '.cc', '.cpp']
valid_extensions = valid_headers + valid_sources

parser = optparse.OptionParser()

parser.add_option('-s', '--source',
    action="store", dest="source_folder",
    help="Main folder that contains the secondary folder", default="src")

parser.add_option('-r', '--root_dir',
    action="store", dest="root_dir",
    help="The secondary folder that contains the dir that needs to be structured", default="")

parser.add_option('-o', '--output',
    action="store", dest="dot_file",
    help="DOT file with source dependency graph", default="src.dot")

parser.add_option('-a', '--add_all_objects',
    action="store", dest="add_all_objects",
    help="Add all files/folders from source forder to dependency graph", default=False)

options, args = parser.parse_args()

source_folder = options.source_folder
output_path = options.dot_file
rootdir = options.root_dir
add_all_objects = options.add_all_objects

if rootdir == "":
    rootdir = source_folder

dot_file = ""
connections_dot = ""

files = {"list" : {}, "visited": {}}

def strip_cluster(path):
    return path[path.rfind(os.sep)+1:].replace("-", "_").replace(".", "_")

def strip_cluster_label(path):
    return path[path.rfind(os.sep)+1:].replace("-", "_").replace(".", "_")

def strip_file(path):
    head_tail = os.path.split(path)
    return path[len(head_tail[0])+1:].replace(".", "_").replace("-", "_")

def get_extension(path):
    """ Return the extension of the file targeted by path. """
    return path[path.rfind('.'):]

def get_list_of_includes(path):
    # parse file cpp or h to get list of includes
    # add to global dictionary with unique path
    file = open(path, 'r')
    lines = file.readlines()

    list_of_includes = []

    for line in lines:
        if include_notation in line:
            include_file = line[len(include_notation):line.rfind("\"", 2)]
            list_of_includes.append(str(include_file))

    return list_of_includes


def connections(path, level="\t"):
    global connections_dot
    global files
    print(level+"path="+path)
    for key in files["list"].keys():
        if path in key and files["visited"][key] == False:
            print(level+"path in key="+ key)
            print(files["list"][key])
            for include in files["list"][key]:
                print(level+"include="+include)
                connections_dot += strip_file(key) + " -> " + strip_file(include) + ";\n"
                connections(include, level+"\t")
            files["visited"][key] = True

def find_all_files(path):
    for entry in os.scandir(path):
        if entry.is_dir():
            find_all_files(entry.path)
        elif get_extension(entry.path) in valid_extensions:
            files["list"][entry.path] = get_list_of_includes(entry.path)
            files["visited"][entry.path] = False

def build_clusters_and_files(path):
    global dot_file
    for entry in os.scandir(path):
        if entry.is_dir():
            #createdot_file with name entry
            dot_file += "\n\tsubgraph cluster"+strip_cluster(str(entry.path))+" {\n\t\tlabel=\""+strip_cluster_label(str(entry.path))+"\";\n\t\t"
            build_clusters_and_files(entry.path)
            #add }
            dot_file += "\n}\n"
        elif get_extension(entry.path) in valid_extensions:
            #create file with the correct notation fo
            stripped_file = strip_file(str(entry.path))
            #if there is a file with the same name as another file, we have to add something that makes it different in order for the .dot file to show it
            while stripped_file in files:
                stripped_file += "_"
            #add to dot_file
            if get_extension(entry.path) in valid_headers:
                dot_file += stripped_file + " [color=green]; "
            else:
                dot_file += stripped_file + " [color=blue]; "

def WriteToFile(string, output_path):     #this overwrites everything that is currently in the file
    f = open(output_path, 'w')
    f.write(string)
    f.close()

def graph(source, root, output_path, add_all_objects):
    res = ""
    res += "digraph {\n\trankdir=LR\n\n"

    find_all_files(source)

    #print(files)

    build_clusters_and_files(root)

    res += dot_file

    res += "\n\n"
    connections(root)
    res += connections_dot

    res += "\n}"

    WriteToFile(res, output_path)

if __name__ == '__main__':
    graph(source_folder, rootdir, output_path, add_all_objects)
