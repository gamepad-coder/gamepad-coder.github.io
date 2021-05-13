print('\t./pre 1')

import os.path 
from shutil import copyfile

def main():
    
    # alternative oneline: 
    #   c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"

    c_path = ""
    c_windows ="C:/"
    c_wsl2    ="/mnt/c/"
    if os.path.isdir(c_windows) :
        c_path = c_windows
    elif os.path.isdir(c_wsl2) :
        c_path = c_wsl2

    ahk_repo_path = c_path + "GitHub/gamepad-coder/AutoHotkey_Projects/"
    sphinx_path   = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/"

    AHK_SCRIPTS = [
        { 
            "from": ahk_repo_path + "Utilities/emulate_numpad.ahk", 
            "to"  : sphinx_path   + "Utilities/Emulate_Numberpad/emulate_numpad.ahk", 
        },
        { 
            "from": ahk_repo_path + "Utilities/emulate_numpad.without_commentary.ahk", 
            "to"  : sphinx_path   + "Utilities/Emulate_Numberpad/emulate_numpad.without_commentary.ahk", 
        },
        { 
            "from": ahk_repo_path + "Utilities/Program_Launcher/program_launcher.ahk", 
            "to"  : sphinx_path   + "Utilities/Program_Launcher/Code/Complete_Script/program_launcher.ahk", 
        },
        { 
            "from": ahk_repo_path + "Utilities/Program_Launcher/program_launcher_settings_window.ahk", 
            "to"  : sphinx_path   + "Utilities/Program_Launcher/Code/Complete_Script/program_launcher_settings_window.ahk", 
        },
    ]

    for ahk_script_path in AHK_SCRIPTS:

        # Copy (ahk_repo)/script.ahk -> (sphinx_repo/ahk_repo_name)/script.ahk
        src = ahk_script_path["from"]
        dst = ahk_script_path["to"]
        # print("simulate moving from\n" + src + "\n\nto\n" + dst + "\n\n")
        copyfile(src, dst)





main()