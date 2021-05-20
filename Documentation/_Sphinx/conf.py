# -*- coding: utf-8 -*-
#
# Configuration file for the Sphinx documentation builder.
#
# This file does only contain a selection of the most common options. For a
# full list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

import os
import sys
sys.path.insert(0, os.path.abspath('./_custom_extensions'))


# -- Project information -----------------------------------------------------

project = 'Gamepad.Coder\'s'
copyright = 'Gamepad.Coder 2021'
author = 'Gamepad.Coder'

# The short X.Y version
version = ''
# The full version, including alpha/beta/rc tags
release = '2021'


# -- General configuration ---------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
# needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.todo',
    'extended_ahk_lexer',
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'Documentation'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = [
    '_build', 
    'Thumbs.db', 
    '.DS_Store',
    'AutoHotkey/Object-Oriented_GUI_Framework',
    'AutoHotkey/Utilities/2do_Tree',
    'AutoHotkey/Utilities/Clock',
    'AutoHotkey/Utilities/Program_Launcher/Code/Functions_and_Variables',
    'AutoHotkey/Utilities/Program_Launcher/Code/Walkthrough',
    'AutoHotkey/Utilities/Program_Launcher/Code/index.rst',
]


    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #
    #               Code Lexer + Pygments (custom colors)
    #
    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    
    
# The name of the Pygments (syntax highlighting) style to use.
# pygments_style = 'sphinx'
# pygments_style = None

#-----------------------------------------------------------------------------
# Initially I was going to use a default pygments style, 
# but then I modified the default Lexer 
# and used custom CSS to modify the "monokai" pygment. 
#
# The Monokai pygment is awesome because it adds a specific 
# css class to each element type, which made creating the CSS styles a breeze. 
#-----------------------------------------------------------------------------
#                                      rank                bg
#                                  ============       =============
# pygments_style = 'default'
# pygments_style = 'emacs'            # *               white
# pygments_style = 'colorful'         #                 white
# pygments_style = 'autumn'           #                 white
# pygments_style = 'murphy'           #                 white
# pygments_style = 'pastie'           #                 white
# pygments_style = 'borland'          #                 white
# pygments_style = 'trac'             #                 white
# pygments_style = 'bw'               #                 white
# pygments_style = 'vs'               #                 white
# pygments_style = 'xcode'            #                 white
# pygments_style = 'igor'             #                 white
# pygments_style = 'lovelace'         #                 white
# pygments_style = 'algol'            #                 white
# pygments_style = 'algol_nu'         #                 white
# pygments_style = 'arduino'          #                 white
# pygments_style = 'rainbow_dash'     #                 white
# pygments_style = 'abap'             #                 white
# pygments_style = 'perldoc'          #               tan
# pygments_style = 'paraiso-light'    #               tan
# pygments_style = 'friendly'         # *             grey
# pygments_style = 'manni'            #               grey
# pygments_style = 'tango'            #               grey
# pygments_style = 'fruity'           #             night
# pygments_style = 'vim'              #             night
# pygments_style = 'rrt'              #             night
# pygments_style = 'paraiso-dark'     #             night
# pygments_style = 'native'           # ***         night
# pygments_style = 'monokai'          # ***         night
                                          # good support for if else winget substr

#------------------------------------------------------------------------------------
# HOW TO CUSTOMIZE LEXER : 
#------------------------------------------------------------------------------------
#  1) Spend many hours Googling with no recipes that will take less than a day to learn
#  2) Prepare to give up
#  3) Finally find a blog entry which mentions Sphinx's
#     built-in functionality to easily import a lexer : 
#  4) Write lexer
#  5) Set `pygments_style = 'monokai'
#  6) Download Pygments source code 
#  7) Navigate to ../Pygments-2.8.1/pygments/styles/monokai.py
#  8) Observe that unaffected keywords are still given a unique span class
#  9) Write simple css to color the keywords of your language defined in (4)
#------------------------------------------------------------------------------------
#  Magical URL :    https://samprocter.com/2014/06/documenting-a-language-using-a-custom-sphinx-domain-and-pygments-lexer/
#------------------------------------------------------------------------------------
pygments_style = 'monokai'          # ***         night

# highlight_language = 'autohotkey'
highlight_language = 'autohotkey'
# highlight_language = 'pygments.lexers.automation.AutohotkeyLexer'




    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #
    #               HTML SUBSTITUTION DEFINITIONS
    #
    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#------------------------------------------------------------------------------
# Docs: Conf.py -> option: rst_prolog 
#------------------------------------------------------------------------------
# A string of reStructuredText that will be included at the beginning of every
# source file that is read. This is a possible place to add substitutions that
# should be available in every file (another being rst_epilog).
#------------------------------------------------------------------------------

rst_prolog = """

..    
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    
    =============================================
    |Substitutions| allow manual HTML insertions
    =============================================



..
        ------------------------------
            Basic <html> tags
        ------------------------------

.. |h2| raw:: HTML

    <h2>

.. |h2_close| raw:: HTML

    </h2>


.. |i| raw:: HTML 
    
    <i>

.. |i_close| raw:: HTML 
    
    </i>

.. |ib| raw:: HTML 
    
    <i><b>

.. |ib_close| raw:: HTML 
    
    </b></i>


.. |i_code| raw:: HTML 
    
    <i><code class="docutils literal notranslate"><span class="pre">

.. |i_code_close| raw:: HTML 
    
    </span></code></i>


.. |br| raw:: HTML

   <br />

.. |br_small| raw:: HTML

    <p style="
        height: 10px;
    "></p>

.. |hr| raw:: HTML

    <hr style="
        border-top: 1px solid #75b4ca;
    ">
    
.. |nbsp| raw:: HTML

    &nbsp;
   
.. |unicode_nbsp| unicode:: 0xA0 


..
        ------------------------------------------
            <details>   (collapsible region)
        ------------------------------------------

.. |details_open| raw:: HTML

    <details><summary>

.. |summary_close| raw:: HTML 

    </summary>

.. |details_close| raw:: HTML

    </details>

.. |indented_block| raw:: HTML

    <div style="padding-left:60px;">

.. |less_indented_block| raw:: HTML

    <div style="padding-left:40px;">

.. |barely_indented_block| raw:: HTML

    <div style="padding-left:10px;">

.. |indented_block_close| raw:: HTML

    </div>



..
        ---------------------------------------
            (>) Collapsible Section Wrapper
        ---------------------------------------
        
.. |collapsible_wrapper| raw:: HTML 

    <div class="collapsible_wrapper">

.. |collapsible_wrapper_close| raw:: HTML 

    </div>


.. |collapsible_label_1| raw:: HTML

   <input  id="collapsible_section_1" class="toggle_collapsible_section" type="checkbox">
   <label for="collapsible_section_1" class="label-toggle_collapsible_section">

.. |collapsible_label_2| raw:: HTML

   <input  id="collapsible_section_2" class="toggle_collapsible_section" type="checkbox">
   <label for="collapsible_section_2" class="label-toggle_collapsible_section">

.. |collapsible_label_close| raw:: HTML 

    </label>
    
    
.. |collapsible_section| raw:: HTML

   <div class="collapsible_codeblock_section">

.. |collapsible_section_close| raw:: HTML 

    </div>

.. |alt_collapsible_label_open| raw:: HTML

    <details class="collapsible_section_via_details"><summary>

.. |alt_collapsible_label_endopen| raw:: HTML

    </summary>
    
.. |alt_collapsible_label_close| raw:: HTML

    </details>




..
        ------------------------------
            Embed clickable Image 
        ------------------------------
    
.. |picture_pt1_a_open_href| raw:: HTML

    <a class="reference external image-reference" href="

.. |picture_pt2_close_href_a| raw:: HTML

    ">

.. |picture_pt3_img_open_alt| raw:: HTML

    <img alt="

.. |picture_pt4_img_src| raw:: HTML

    " src="

.. |picture_pt5_close_img_a| raw:: HTML 
    
    "/></a>
    



..
        ------------------------------
            Embed YouTube Video
        ------------------------------

.. |youtube_open| raw:: HTML


    <div class="videoWrapper" 
        style="
            position: relative;
            padding-bottom: 57.25%; /* 16:9 */
            height: 0; "
    >
        <iframe src="


.. |youtube_muted_close| raw:: HTML
    
    ?mute=1" 
                frameborder="0" 
                allowfullscreen="" 
                style="
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%; "
        ></iframe>
    </div>

.. |youtube_close| raw:: HTML
    
    " 
                frameborder="0" 
                allowfullscreen="" 
                style="
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%; "
        ></iframe>
    </div>
    
..
                        ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                        COMMENT 
                        
                        Aspect-ratio auto-size trick found here:
                        https://css-tricks.com/fluid-width-video/#iframe-video-youtube-vimeo-etc
                        
                        Original Code: 
                        ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                            
                            <div class="videoWrapper" 
                                style="
                                    position: relative;
                                    padding-bottom: 57.25%; /* 16:9 */
                                    height: 0; "
                            >
                                <iframe src="https://www.youtube.com/embed/XptlVErsL-o?mute=1" 
                                        frameborder="0" 
                                        allowfullscreen="" 
                                        style="
                                            position: absolute;
                                            top: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 100%; "
                                ></iframe>
                            </div>
                            
                        ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 



..
        ----------------------------------
            USER TUTORIAL
            
            Codeblock Navigation on PC
        ----------------------------------

.. |hint_tutorial__navigating_codeblocks| raw:: HTML 

    <div class="admonition hint">
    <p class="first admonition-title">Hint</p>
    <p></p><details><summary> <strong>Scrolling Horizontally (On PC):</strong> </summary>
    <div style="padding-left:10px;">
    <p style="
        height: 20px;
    "></p>
    If your mouse has a wheel, you can scroll horizontally using the mouse.
    Place your mouse cursor over the code, hold shift, then move the wheel up or down.<p></p>
    <p>If you are using a laptop which supports two-finger-scrolling,
    hold shift and move two fingers up or down on the touchpad <em>(both in the same direction)</em>,
    and the region under the mouse will scroll horizontally.</p>
    <p>This only works if</p>
    <ol class="arabic simple">
    <li>The mouse is hovering over the area to scroll.</li>
    <li>The area under the mouse has a horizontal scroll bar.</li>
    </ol>
    <p>If nothing happens, then your window is big enough to display the entire
    width of the box. <em>(In this scenario, horizontal scroll bar will be
    greyed out, if it exists)</em>.
    </p></div>
    </details>
    <br> <hr style="
        border-top: 1px solid #75b4ca;
    ">
    <details><summary> <strong>Quick Navigation (On PC):</strong> </summary>
    <div style="padding-left:10px;">
    <p style="
        height: 20px;
    "></p>
    I’ve used the HTML <code class="docutils literal notranslate"><span class="pre">&lt;details&gt;</span></code> tag to add text folding to:
    <ul class="simple" style="margin-top:0;">
    <li style="
        margin-top: 0;
    ">these Hint boxes,</li>
    <li style="
        margin-top: 0;
    ">the blue-outlined boxes below (which contain entire scripts),</li>
    <li style="
        margin-top: 0;
    ">and blocks of AutoHotkey code <code class="docutils literal notranslate" style="
        color: blue;
    "><span class="pre">{</span></code> with curly braces <code class="docutils literal notranslate" style="
        color: blue;
    "><span class="pre">}</span></code>.</li>
    </ul>
    <p>On PC, you can quickly navigate between these foldable <code class="docutils literal notranslate"><span class="pre">&lt;details&gt;</span></code> tags:</p>
    <ol><li style="
        margin-top: 20px;
    "><p>First click any block of code or text which has a folding arrow to activate it.</p></li>
    <li style="
        margin-top: 20px;
    "><p>Once you’ve activated one of the folding text blocks,
    you can use <kbd class="kbd docutils literal notranslate">Tab</kbd> to go to the next foldable region, and
    <kbd class="kbd docutils literal notranslate">Shift</kbd>+<kbd class="kbd docutils literal notranslate">Tab</kbd> to go to the previous region. If the region is outside your current view, your browser will scroll the window for you.</p></li>
    <li style="
        margin-top: 20px;
    "><p>After pressing (<kbd class="kbd docutils literal notranslate">Shift</kbd>+) <kbd class="kbd docutils literal notranslate">Tab</kbd>, the selected region
    should be outlined by your web browser. Press <kbd class="kbd docutils literal notranslate">Space</kbd> when a region
        is outlined to toggle its fold/unfold state!</p></li></ol>
    <hr style="
        border-top: 1px solid #75b4ca;
        margin-top: 34px;
        margin-left: 2vw;
        margin-right: 2vw;
    "><div style="
        padding: 30px;
        padding-top: 10px;
        padding-right: 50px;
    "><p><em>Note 1:<br><br> If</em> <i><b>”Quick Navigation (On PC)”</b></i> <em>was the last thing
    you clicked, then the</em> <i><code class="docutils literal notranslate"><span class="pre">&lt;details&gt;</span></code></i> <em>containing
    this block is currently activated. Go ahead and try pressing</em> <kbd class="kbd docutils literal notranslate">Tab</kbd> <em>now!</em></p></div>
    <hr style="
        border-top: 1px solid #75b4ca;
        margin-left: 2vw;
        margin-right: 2vw;
    "><div style="
        padding: 30px;
        padding-top: 10px;
        padding-right: 50px;
    "><p><em>Note 2:<br><br>This navigation trick only works after clicking a foldable region,
    or clicking somewhere in the middle of the page, outside of the sidebar. If you load the page then immediately press</em> <kbd class="kbd docutils literal notranslate">Tab</kbd><em>,  the
    Table of Contents in the Sidebar will be outlined first.  If this happens,
    click a foldable text block to change the activated region, then use</em>
        <kbd class="kbd docutils literal notranslate">Tab</kbd><em>.</em><br>
    </p></div> </div>
    </details>
    <p style="
        height: 10px;
    "></p><p></p>
    </div>
    
    
    
    
.. 
    =============================================
    </> end of section defining  |Substitutions| 
    =============================================

..    
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    
"""





# =========================================================================================
#
#               Options per specific output format below this line. 
#
# =========================================================================================


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
# html_theme = 'alabaster'
# html_theme = 'sphinx_rtd_theme'


html_theme = 'sphinx_rtd_theme__modified'
html_theme_path = ["."]

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}
html_theme_options = {
        # Default Options:
        # 'analytics_id': 'UA-XXXXXXX-1',  #  Provided by Google in your dashboard
        # 'analytics_anonymize_ip': False,
        # 'logo_only': False,
        # 'display_version': True,
        # 'prev_next_buttons_location': 'bottom',
        # 'style_external_links': False,
        # 'vcs_pageview_mode': '',
        # 'style_nav_header_background': 'white',
        # # Toc options
        # 'collapse_navigation': True,
        # 'sticky_navigation': True,
        # 'navigation_depth': 4,
        # 'includehidden': True,
        # 'titles_only': False
        #
        # docs: https://sphinx-rtd-theme.readthedocs.io/en/stable/configuring.html
        
        #  Only display the logo image, do not display the project name at the top of the sidebar
        # 'logo_only' : False,
        # 'show_source_at_top' : False,    
        # 'navigation_depth': -1,
        # 'sticky_navigation': False
        # 'collapse_navigation': True,
    'collapse_navigation': False,
    'navigation_depth': -1,
    'titles_only': False,
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# The default sidebars (for documents that don't match any pattern) are
# defined by theme itself.  Builtin themes are using these templates by
# default: ``['localtoc.html', 'relations.html', 'sourcelink.html',
# 'searchbox.html']``.
#
# html_sidebars = {}

#from
#https://stackoverflow.com/questions/18969093/how-to-include-the-toctree-in-the-sidebar-of-each-page
html_sidebars = { '**': ['globaltoc.html', 'relations.html', 'sourcelink.html', 'searchbox.html'] }


# html_show_copyright
#
#    If true, “(C) Copyright …” is shown in the HTML footer. Default is True.
#
#    New in version 1.0.

html_show_copyright = False


# -- Options for HTMLHelp output ---------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = 'SphinxTest2021doc'
html_title = 'NewHTMLtitle'

# -- Options for LaTeX output ------------------------------------------------

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #
    # 'papersize': 'letterpaper',

    # The font size ('10pt', '11pt' or '12pt').
    #
    # 'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #
    # 'preamble': '',

    # Latex figure (float) alignment
    #
    # 'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (master_doc, 'SphinxTest2021.tex', 'Sphinx Test 2021 Documentation',
     'JTester', 'manual'),
]


# -- Options for manual page output ------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'sphinxtest2021', 'Sphinx Test 2021 Documentation',
     [author], 1)
]


# -- Options for Texinfo output ----------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, 'SphinxTest2021', 'Sphinx Test 2021 Documentation',
     author, 'SphinxTest2021', 'One line description of project.',
     'Miscellaneous'),
]


# -- Options for Epub output -------------------------------------------------

# Bibliographic Dublin Core info.
epub_title = project

# The unique identifier of the text. This can be a ISBN number
# or the project homepage.
#
# epub_identifier = ''

# A unique identification for the text.
#
# epub_uid = ''

# A list of files that should not be packed into the epub file.
epub_exclude_files = ['search.html']


# -- Extension configuration -------------------------------------------------

# -- Options for todo extension ----------------------------------------------

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = True
