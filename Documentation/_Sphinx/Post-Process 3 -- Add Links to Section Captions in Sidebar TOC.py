print('\t./post 3')

import re
import os.path 
from pathlib import Path

script_header = """

\t\t================================================================
\t\tPost-Process 3
\t\tAdd links to "AUTOHOTKEY" and "GODOT" in sidebar TOC
\t\t================================================================
"""
      
print(script_header)


def main():
    
    count_updated_files = 0
    
    c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"
    sphinx_path = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/_build/html/"
    
    
    # print("... files to operate on:\n\n")
    pathlist = Path(sphinx_path).glob('**/*.html')
    for html_file in pathlist : 
        
        # print(html_file)
        TheText = ""
        
    
        with open (html_file, 'r' ) as f:
        
            TheText = f.read()
        
            count=0
            flags = re.M | re.I
            #
            #	Find:
            #	
            #		<span class="caption-text">AutoHotkey:</span>
            #		<span class="caption-text">Godot:</span>
            #
            #   To avoid the rst page inserted TOC from matching, 
            #   additional negative lookbehind for a div class 
            #   present in the Page TOC but not in the Sidebar TOC 
            #
            find    = "(?<!<div class=\"toctree-wrapper compound\">[\n])(<p class=\"caption\">)(<span class=\"caption-text\">AutoHotkey:</span>)"
            replace = "\\1<a class=\"caption-manually-inserted-link\" href=\"/Documentation/AutoHotkey/index.html\">\\2</a>"
            TheText = re.sub(find, replace, TheText, count, flags)
            
            find    = "(?<!<div class=\"toctree-wrapper compound\">[\n])(<p class=\"caption\">)(<span class=\"caption-text\">Godot:</span>)"
            replace = "\\1<a class=\"caption-manually-inserted-link\" href=\"/Documentation/Godot/index.html\">\\2</a>"
            TheText = re.sub(find, replace, TheText, count, flags)
        
        if TheText != "":
            with open (html_file, 'w' ) as f:
                f.write( TheText )
                count_updated_files +=1
        
        
    print("\t\t... Succesfully altered "+ str(count_updated_files) +" files")
    
    return



main()
