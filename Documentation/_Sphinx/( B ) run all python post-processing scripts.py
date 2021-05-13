# Ensure the command line cd's to this dir before running this script.

print('\t./(b)')

Python_PostProcess_Scripts = [
    "Post-Process 1 -- Remove Section Headers in Documentation.html TOC.py",
    "Post-Process 2 -- Add Codeblock Folding To Sphinx output, replace custom tags with HTML details element.py",
    "Post-Process 3 -- Add Links to Section Captions in Sidebar TOC.py",
    "Post-Process 4 -- Copy Videos to Output Build Directory.py",
]

for py in Python_PostProcess_Scripts:
    # print("\tsimulate Run: " + py)
    with open(py) as scriptfile:
        exec( scriptfile.read() )


print('\n')