print('\t./pre 2')

import re
import os.path 


def main():
    global TheText
    
    c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"
        
    Sphinx_AHK_Scripts = [
        c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/Utilities/Emulate_Numberpad/emulate_numpad.ahk",
        c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/Utilities/Emulate_Numberpad/emulate_numpad.without_commentary.ahk",
        c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/Utilities/Program_Launcher/Code/Complete_Script/program_launcher.ahk",
        c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/AutoHotkey/Utilities/Program_Launcher/Code/Complete_Script/program_launcher_settings_window.ahk",
    ]
    
    for ahk_script_path in Sphinx_AHK_Scripts:
        
        TheText = ""
        
        with open (ahk_script_path, 'r' ) as f:
    
            TheText = f.read()
    
            process_leading_tabs()
            process_foldable_curly_braces()
            process_comments()
            tag_with_num_tabs_indentation()
    
        if TheText:
            print("\t\tRegEx Replace successful.")
            #print()
            
            # output_file = "ahk_script --- tags injected, ready for Sphinx to bake, then process again.ahk"
            
            output = open(ahk_script_path, "w")
            
            n = output.write(TheText)
            
            output.close()
        else:
            print("\t\tRegEx Replace unsuccessful.")	
    
    return


def process_leading_tabs():
    global TheText
    
    flags = re.M | re.I
    count=0
    
    ###################################################################
    #
    #	Remove leading tabs.
    #
    find    = "^\t"
    replace = ""
    TheText = re.sub(find, replace, TheText, count, flags)
    
    ###################################################################
    #
    #	Replace Tabs with spaces.
    #
    find    = "\t"
    replace = "   "
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return


def process_foldable_curly_braces():
    global TheText
    
    flags = re.M | re.I
    count=0
    
    ###################################################################
    #  Find:
    #       Class, if, label, directive, etc followed by (\n?) and { 
    #
    #  Example:
    #               (line) {
    #           or
    #
    #               (line
    #               and block)
    #               {
    # updated this one to add ~hotkey_support::
    # find = '^(([ \t]*(if|#If|else|class|for|while|and|\,|or|\w*[ ]*\:[ ]*$|(\w*[ ]*\([^){]*\)[ ]*)|loop|Loop)[^\n\{]*\n?)*\n?[ \t]*{[ \t;\w]*$)'
    # find = '^(([ \t]*(if|#If|else|class|for|while|and|\,|or|[^;\/\n]*[ ]*\:[:]?[ ]*$|(\w*[ ]*\([^){]*\)[ ]*)|loop|Loop)[^\n\{]*\n?)*\n?[ \t]*{[ \t;\w]*$)'
    # find = '^(([ \t]*(if|#If|else|class|for|while|and|\,|or|[^;\/\n]*[ ]*\:[:]?[ ]*$|(\w*[ ]*\([^){]*\)[ ]*)|loop|Loop)(;[^\n]*)|[^\n\{]*\n?)*\n?[ \t]*{[ \t;\w]*$)' #BEWARE SUPER SLOW WITH THIS ORDER
    find = '^(([ \t]*(if|#If|else|class|for|while|and|\,|or|[^;\/\n]*[ ]*\:[:]?[ ]*$|(\w*[ ]*\([^){]*\)[ ]*)|loop|Loop)[^\n\{;]*(;[^\n]*)?\n?)*\n?[ \t]*{[ \t;\w]*)$'
    replace = '_____DETAILS_BEGIN_____\\1 _____SUMMARY_END_____'
    TheText = re.sub(find, replace, TheText, count, flags)
    
    
    #######################################################################
    #  Find:
    #          Closing curly brace, closure of one instance of above pattern.
    #
    #  Example:
    #               }
    #
    find    = '^([ \t]*)\}([ \t]*(;[^\n]*)?)'
    replace = '\\1}\\2 _____DETAILS_END_____'
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return


def process_comments():
    global TheText
    
    flags = re.M | re.I
    count=0

    #######################################################################
    #  Find:
    #          /*   Beginning of comment block
    #

    # find = '^([ \t]*/\*)([ \t]*.*)(?<!\*/)$'
    # replace = '\\1 _____BLOCK_COMMENT_DETAILS_BEGIN_____ \\2 _____BLOCK_COMMENT_SUMMARY_END_____'
    # TheText = re.sub(find, replace, TheText, count, flags)
    
    find = '^([ \t]*)(/\*)([ \t]*.*)(?<!\*/)$'
    TheText = re.sub(find, tag_comment_block_with_num_tabs, TheText, count, flags)


    #######################################################################
    #  Find:
    #          */   Ending of comment block
    #
    find = '^([ \t]*\*/)'
    replace = '\\1 _____BLOCK_COMMENT_DETAILS_END_____'

    TheText = re.sub(find, replace, TheText, count, flags)



    #######################################################################
    #  Find:
    #          ;---------;`   Beginning of folding comment block
    #
    find = '^([ \t]*;[^\n]*)[^`]`[ \t]*$'
    replace = '_____COMMENT_DETAILS_BEGIN_____ \\1'
    TheText = re.sub(find, replace, TheText, count, flags)

    find = '^([ \t]*;[^\n]*)[^`]``[ \t]*$'
    replace = '\\1 _____COMMENT_SUMMARY_END_____'
    TheText = re.sub(find, replace, TheText, count, flags)

    find = '^([ \t]*;[^\n]*)[^`]```[ \t]*$'
    replace = '\\1 _____COMMENT_DETAILS_END_____'
    TheText = re.sub(find, replace, TheText, count, flags)

    return

def tag_comment_block_with_num_tabs(matchobj):
    
    m =  matchobj.group(0)              # full capture
    m1 =  matchobj.group(1)             # capture group 1: leading tabs
    m2 =  matchobj.group(2)             # capture group 2: /*
    m3 =  matchobj.group(3)             # capture group 2:    anything after "/*"
    
    num_tabs = int( len(m1) / 3 )
    
    # replace = '\\1 _____BLOCK_COMMENT_DETAILS_BEGIN_____ \\2 _____BLOCK_COMMENT_SUMMARY_END_____'
    replace  = m2                                       # /*
    replace += " _____BLOCK_COMMENT_DETAILS_BEGIN_____"  #   _..BEGIN_____
    replace += str(num_tabs) + "t_ "                    #     3t_
    replace += m3                                       #       anything after "/*"
    replace += " _____BLOCK_COMMENT_SUMMARY_END_____"   #         _..END_____
    
    return replace
    

def tag_with_num_tabs_indentation():
    global TheText

    flags = re.M | re.I
    count=0

    #######################################################################
    # Append tab indentation
    #
    #    example:
    #                    _____DETAILS_BEGIN_____   next_string 
    #              ->    _____DETAILS_BEGIN_____t1 next_string
    #
    #                    _____DETAILS_BEGIN_____      next_string 
    #              ->    _____DETAILS_BEGIN_____t2 next_string
    #
    find = '^(_____DETAILS_BEGIN_____|_____COMMENT_DETAILS_BEGIN_____)([ ]*)'
    
    # Sphinx processes "_____BLOCK_COMMENT_SUMMARY_END_____" weird 
    # if it isn't placed AFTER an opening /*
    # so the tabs for that are processed above in a separate function.
    
    TheText = re.sub(find, replace_tabs_with_tn, TheText, count, flags)
    
    return
#
#########################################################
# call from re.sub( .., replace_tabs_with_flag, .. )
# expects two capture groups
#
def replace_tabs_with_tn(matchobj):
    
    m =  matchobj.group(0)              # full capture
    m1 =  matchobj.group(1)             # capture group 1: __details__
    m2 =  matchobj.group(2)             # capture group 2: spaces, 3 eq 1tab
    
    num_tabs = int( len(m2) / 3 )
    
    return m1 + str(num_tabs) + "t_ "


TheText=""
main()