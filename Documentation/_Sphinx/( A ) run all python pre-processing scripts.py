# Ensure the command line cd's to this dir before running this script.

print('\t./(a)')

Python_PreProcess_Scripts = [
    "Pre-Process   1 -- Copy AHK scripts to Sphinx source.py",
    "Pre-Process   2 -- Insert custom tags into AHK scripts (post-process will replace with html codeblock folding).py",
]

for py in Python_PreProcess_Scripts:
    # print("\tRun: " + py)
    with open(py) as scriptfile:
        exec( scriptfile.read() )

print('\n')