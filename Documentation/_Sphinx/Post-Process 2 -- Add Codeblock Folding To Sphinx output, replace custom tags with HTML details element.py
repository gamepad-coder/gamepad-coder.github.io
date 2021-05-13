print('\t./post 2')

import re
import os.path 

script_header = """

\t\t================================================================
\t\tPost-Process 2
\t\tAdd Codeblock Folding To Sphinx output:
\t\t
\t\t     Replace custom tags injected by Pre-Process 2
\t\t     with HTML <detail> + <summary> elements.
\t\t================================================================
"""
      
print(script_header)


def main():
    global TheText
    
    c_path = "C:/" if os.path.isdir("C:/") else "/mnt/c/"
    sphinx_path = c_path + "GitHub/gamepad-coder/gamepad-coder.github.io/Documentation/_Sphinx/_build/html/"
    
    Sphinx_AHK_HTML_pages = [
        "AutoHotkey/Utilities/Emulate_Numberpad/index.html",
        "AutoHotkey/Utilities/Program_Launcher/Code/Complete_Script/index.html",
    ]
    
    for html_baked_unprocessed in Sphinx_AHK_HTML_pages : 
        
        html_path = sphinx_path + html_baked_unprocessed
    
        with open (html_path, 'r' ) as f:
    
            TheText = f.read()
    
            count=0
            flags = re.M | re.I
    
            remove_details_from_codeblocks()
            insert_details_element_for_curly_brace_blocks()
            insert_details_element_for_block_comments()
            insert_details_element_for_collapsible_comment_regions()
    
            if html_baked_unprocessed == "AutoHotkey/Utilities/Program_Launcher/Code/Complete_Script/index.html" :
                auto_fold_first_few_levels()
    
        with open (html_path, 'w' ) as f:
            print("\t\t... Succesfully altered file")
            print("\t\t_build/html/" + html_baked_unprocessed + "\n")
            
            f.write( TheText )
    
    return

def auto_fold_first_few_levels():
    global TheText

    flags = re.M | re.I
    count=0
    
    #
    #	Find:
    #		<DETAILS open class="leading_tabs_0" || class="leading_tabs_1"
    #
    find    = "<DETAILS open class=\"leading_tabs_(0|1)\">"
    replace = "<DETAILS class=\"leading_tabs_\\1\">"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return

def remove_details_from_codeblocks():
    global TheText

    flags = re.M | re.I
    count=0
    
    #
    #   Remove:
    #
    #       Any Details / Summary / End blocks within a block comment.
    #
    
    find    = "^([ ]*<span class=\"cm\">[ ]*.*)_____DETAILS_BEGIN_____"
    replace = "\\1"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    find    = "^([ ]*<span class=\"cm\">[ ]*.*)_____SUMMARY_END_____"
    replace = "\\1"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    find    = "^([ ]*<span class=\"cm\">[ ]*.*)_____DETAILS_END_____"
    replace = "\\1"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return
    
    
def insert_details_element_for_curly_brace_blocks():
    global TheText

    flags = re.M | re.I
    count=0
    
    #
    #	Find:
    #		_____DETAILS_BEGIN_____
    #
    find    = "<span class=\"[^\"]*\">_____DETAILS_BEGIN_____([\d]+)t_</span>[ ]*"
    # find    = "<span class=\"[^\"]*\">_____DETAILS_BEGIN_____</span> "
    replace = "<DETAILS open class=\"leading_tabs_\\1\"><SUMMARY>"
    TheText = re.sub(find, replace, TheText, count, flags)


    #
    #	Find:
    #	
    #		_____SUMMARY_END_____
    #
    find    = " <span class=\"vc\">_____SUMMARY_END_____</span>"
    replace = "<span class=\"DETAILS_CLOSE_BRACE\">}</span></SUMMARY>"
    TheText = re.sub(find, replace, TheText, count, flags)
    

    #
    #	Find:
    #	
    #		_____DETAILS_END_____
    #
    find    = "<span class=\"p\">}</span>[ ]*<span class=\"vc\">_____DETAILS_END_____</span>"
    replace = "<span class=\"p\">}</span></DETAILS>"
    # replace = "<span class=\"p DETAILS__INNER_CLOSE_BRACE\">}</span></DETAILS>"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    #
    #	Find:
    #	    _____DETAILS_END_____
    #
    #	Where:
    #		<span>}</span> <span class='comment'>; some comment following a close brace (followed by) _____DETAILS_END_____</span>
    #
    find    = "(<span class=\"p\">}</span>[ ]*<span class=\"c1\">[^\n<]*)_____DETAILS_END_____</span>"
    replace = "\\1</span></DETAILS>"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return

            
def insert_details_element_for_block_comments():
    global TheText

    flags = re.M | re.I
    count=0
    
    #
    #	Find:
    #		_____BLOCK_COMMENT_DETAILS_BEGIN_____
    #
    find    = "<span class=\"cm\">/\* _____BLOCK_COMMENT_DETAILS_BEGIN_____([\d]+)t_[ ]*"
    # find    = "<span class=\"cm\">/\* _____BLOCK_COMMENT_DETAILS_BEGIN_____ "
    
    replace = "<DETAILS class=\"leading_tabs_\\1\"><SUMMARY><span class=\"cm\">/* "
    TheText = re.sub(find, replace, TheText, count, flags)
    


    #
    #	Find:
    #	
    #		_____BLOCK_COMMENT_SUMMARY_END_____
    #
    find    = "_____BLOCK_COMMENT_SUMMARY_END_____</span>"
    replace = "</span><span class=\"cm DETAILS_CLOSE_BRACE\">*/</span></SUMMARY>"
    TheText = re.sub(find, replace, TheText, count, flags)



    
    #
    #	Find:
    #	
    #		_____BLOCK_COMMENT_DETAILS_END_____
    #
    find    = "<span class=\"cm\">([ ]*\*/)</span>[ ]*<span class=\"vc\">_____BLOCK_COMMENT_DETAILS_END_____</span>"
    replace = "<span class=\"cm DETAILS__INNER_CLOSE_BRACE\">\\1</span></DETAILS>"
    TheText = re.sub(find, replace, TheText, count, flags)
    
    return
    

def insert_details_element_for_collapsible_comment_regions():
    global TheText

    flags = re.M | re.I
    count=0
    
    #
    #	Find:
    #	
    #		_____COMMENT_DETAILS_BEGIN_____
    #		_____COMMENT_SUMMARY_END_____
    #		_____COMMENT_DETAILS_END_____
    #
    find    = "<span class=\"vc\">_____COMMENT_DETAILS_BEGIN_____([\d]+)t_</span>(<span class=\"[^\"]*\">) "
    replace = "<DETAILS class=\"leading_tabs_\\1\"><SUMMARY>\\2"
    TheText = re.sub(find, replace, TheText, count, flags)

    find    = "_____COMMENT_SUMMARY_END_____</span>"
    replace = "</span></SUMMARY>"
    TheText = re.sub(find, replace, TheText, count, flags)

    find    = "_____COMMENT_DETAILS_END_____</span>"
    replace = "</span></DETAILS>"
    TheText = re.sub(find, replace, TheText, count, flags)

    return


TheText=""
main()
