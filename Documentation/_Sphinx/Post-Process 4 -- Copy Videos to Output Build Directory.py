print('\t./post 3')

import os.path 
from pathlib import Path
from shutil import copyfile

script_header = """

\t\t================================================================
\t\tPost-Process 4
\t\tManually copy videos to _build output dirs.
\t\t================================================================
"""
      
print(script_header)


def main():
    
    count_updated_files = 0
    
    c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"
    sphinx_path = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/_build/html/"
    
    
    src = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/Utilities/Emulate_Numberpad/Emulate_Numberpad_Demo.mp4"
    dst = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/_build/html/AutoHotkey/Utilities/Emulate_Numberpad/Emulate_Numberpad_Demo.mp4"
    copyfile(src, dst)
        
    # print("\t\t... Succesfully altered "+ str(count_updated_files) +" files")
    
    return



main()
