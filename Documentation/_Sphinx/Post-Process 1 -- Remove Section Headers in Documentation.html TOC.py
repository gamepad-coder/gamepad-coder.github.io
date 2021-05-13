print('\t./post 1')

import re
import os.path 


script_header = """

\t\t================================================================
\t\tPost-Process 1 
\t\tRemove Section Headers from rst TOC in Documentation.html
\t\t================================================================
"""      
print(script_header)

def main():
    c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"
    file_to_edit = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/_build/html/Documentation.html"

    Text_FirstHalf = ""
    Text_SecondHalf_WithReplacements = ""

    with open (file_to_edit, 'r' ) as f:
        
        AllOfTheText = f.read()
        
            
        skip_flag = True
        
        for line in AllOfTheText.splitlines():
            if skip_flag:
                find_pattern = "^.*<div class=\"rst-content\">.*$"
                found = re.match(find_pattern,line)
                if found:
                    # print("found match")
                    skip_flag = False                
                Text_FirstHalf += line + "\n"
            else:
                Text_SecondHalf_WithReplacements += line + "\n"
        
        # print(Text_SecondHalf_WithReplacements)
        
        count=0
        flags = re.M | re.I



        
        #***********************************************************************
        #   
        #  Remove these:
        #   
        #      <li class="toctree-l2"><a class="reference internal" href="AutoHotkey/index.html#autohotkey-overview">AutoHotkey Overview</a></li>
        #   
        #  Keep These:
        #   
        #      <li class="toctree-l1"><a class="reference internal" href="AutoHotkey/index.html">What is AutoHotkey?</a><ul>
        #      <li class="toctree-l1"><a class="reference internal" href="AutoHotkey/Utilities/index.html">My AutoHotkey Utilities</a><ul>
        #      <li class="toctree-l2"><a class="reference internal" href="AutoHotkey/Utilities/Program Launcher/index.html">Program Launcher</a><ul>
        #      <li class="toctree-l3"><a class="reference internal" href="AutoHotkey/Utilities/Program Launcher/Walkthrough/index.html">Walkthrough</a></li>
        #      <li class="toctree-l3"><a class="reference internal" href="AutoHotkey/Utilities/Program Launcher/Functions and Variables/index.html">Functions and Variables</a></li>
        #      <li class="toctree-l3"><a class="reference internal" href="AutoHotkey/Utilities/Program Launcher/Complete Script.html">Complete Script</a></li>
        #   
        #***********************************************************************
        

        #
        #	Find:
        #		_____DETAILS_BEGIN_____
        #
        find    = "<li class=\".*toctree.*\"><a .*href=\".*#[^\d]*\".*>.*</a></li>\n"
        replace = ""
        Text_SecondHalf_WithReplacements = re.sub(find, replace, Text_SecondHalf_WithReplacements, count, flags)
        
        # print(Text_SecondHalf_WithReplacements)

    if Text_SecondHalf_WithReplacements != "":

        
        with open (file_to_edit, 'w' ) as f:
            print("\t\t... Succesfully altered file.\n")
            
            TheText = Text_FirstHalf + Text_SecondHalf_WithReplacements
            f.write( TheText )

    else:
        print("\t\t... Failure to find strings to replace. No changes to file.\n")
    
    return
 
 
main()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    