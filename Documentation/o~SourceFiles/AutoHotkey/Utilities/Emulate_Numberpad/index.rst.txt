.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                                       HTML CODE |SUBSTITUTIONS|
                                       DEFINED IN /conf.py
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

===========================
emulate_numpad.ahk
===========================
    
Do you have a keyboard or laptop which doesn't have a NumberPad? |br|
This utility can help.

.. raw:: html 
    
    <div class="video_wrapper">
        <video class="docs_video" controls loop autoplay muted>
            <source src="Emulate_Numberpad_Demo.mp4" type="video/mp4">
        </video>
    </div>

|h2|\ What does it do?\ |h2_close|

The script ``emulate_numpad.ahk`` has two modes. When turned off, the keyboard
functions normally. When turned on, the keys :kbd:`7` :kbd:`8` :kbd:`9` 
and the keys below them function as a Number Pad (instead of sending letters).

This script only has one hotkey, which toggles the Number Pad feature on and off. 

Pressing the hotkey :kbd:`Right Control`\ +\ :kbd:`F12` will turn the following keys

- :kbd:`*` :kbd:`-` :kbd:`+`
- :kbd:`7` :kbd:`8` :kbd:`9`
- :kbd:`u` :kbd:`i` :kbd:`o` 
- :kbd:`j` :kbd:`k` :kbd:`l` :kbd:`Enter`
- :kbd:`m` :kbd:`.` :kbd:`/`

into a NumberPad, which sends the following keycodes: 

- :kbd:`Numpad*` :kbd:`Numpad-` :kbd:`Numpad+`
- :kbd:`Numpad7` :kbd:`Numpad8` :kbd:`Numpad9`
- :kbd:`Numpad4` :kbd:`Numpad5` :kbd:`Numpad6`
- :kbd:`Numpad1` :kbd:`Numpad2` :kbd:`Numpad3` :kbd:`NumpadEnter` 
- :kbd:`Numpad0` :kbd:`Numpad.` :kbd:`Numpad/`

When the NumberPad mode is enabled, you can restore the keyboard to its normal
state by pressing :kbd:`Right Control`\ +\ :kbd:`F12` again, or by pressing
:kbd:`Esc`.

|h2|\ Download\ |h2_close|

.. csv-table::

   "Project Folder |br| ", "`https://github.com/gamepad-coder/AutoHotkey_Projects/tree <https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities>`__ |br|\ `/main/Utilities <https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities>`__"
   "Full Script |br|\ (with Comments & Hints)", "`https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__ |br|\ `/main/Utilities/emulate_numpad.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__"
   "Full Script |br|\ (minimal Comments)", "`https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__ |br|\ `/main/Utilities/emulate_numpad.without_commentary.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.without_commentary.ahk>`__"
    
.. note::
    
    If you want to look at AutoHotkey scripts in a text editor with highlighted code, see the links 
    at the bottom of my :ref:`AutoHotkey Resources <Ref-What_is_AutoHotkey-Resources-Text_Editors>` section.

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment: 
    
    Notes on tables at the end of this .rst document.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment:
    
    Sphinx derives from standard docutils reST processing.
    Above, for each of my script links, 
    I've broken up two long links into 
    two separate lines which both have the same url.
    
    Sphinx emitted the following error:
        /mnt/c/GitHub/gamepad-coder/gamepad-coder.github.io/Documentation
        /_Sphinx/AutoHotkey/Utilities/Emulate_Numberpad/index.rst:2:
        WARNING: Duplicate explicit target name:
        "https://github.com/gamepad-coder/autohotkey_projects/blob".
    
    To suppress this warning, 
    instead of using the syntax 
        `link text <link.path>`_
    I've instead used the syntax
        `link text <link.path>`__
    
    Recipe recommending this solution (when links are duplicates deliberately)
        https://github.com/sphinx-doc/sphinx/issues/3921#issuecomment-315581557
        
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    
|h2|\ Read The Full Script On This Page\ |h2_close|

In this section, you can read the entire code for ``emulate_numpad.ahk``.

If you'd like to read the script with a tutorial, click the dropdown |br|
*"emulate_numpad.ahk with commentary"*\ .

If you're familiar with AutoHotkey, or if you only want to see the code,
click the dropdown |br|
*"emulate_numpad.ahk without commentary"*\ .

.. hint::
    You can expand and contract sections of code in the scripts below. 
    
    By default, I've expanded the code but collapsed the more detailed comments.
    
    |details_open| Look for the blocks that look like this 
    |br|\ |nbsp| |nbsp| |nbsp| and click either the arrow or the text. |summary_close|
    
    |indented_block| 
    
    |br|    
    And the code inside that block 
    
    will be revealed!     
    |indented_block_close|
    
    |details_close|
    
    |nbsp| 


|hint_tutorial__navigating_codeblocks|

|collapsible_wrapper|
|alt_collapsible_label_open|\ emulate_numpad.ahk |br|\ with commentary. |alt_collapsible_label_endopen| |collapsible_section| 

.. literalinclude:: emulate_numpad.ahk
   :language: AutoHotkey_CustomLexer
   

|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|


|collapsible_wrapper|
|alt_collapsible_label_open|\ emulate_numpad.ahk |br|\ without commentary. |alt_collapsible_label_endopen| |collapsible_section| 

.. literalinclude:: emulate_numpad.without_commentary.ahk
   :language: AutoHotkey_CustomLexer
   
|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|


.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment
    
    V1 with label and input instead of <details>
    
    you can tab & shift+tab nav with <details>
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    
        |collapsible_wrapper|
        |collapsible_label_1|\ emulate_numpad.ahk |br|\ with commentary. |collapsible_label_close| |collapsible_section| 

        .. literalinclude:: emulate_numpad.ahk
           :language: AutoHotkey_CustomLexer
           

        |collapsible_section_close|
        |collapsible_wrapper_close|


        |collapsible_wrapper|
        |collapsible_label_2|\ emulate_numpad.ahk |br|\ without commentary. |collapsible_label_close| |collapsible_section| 

        .. literalinclude:: emulate_numpad.without_commentary.ahk
           :language: AutoHotkey_CustomLexer
           
        |collapsible_section_close|
        |collapsible_wrapper_close|



..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment: 
    
    CSV tables are so much simpler and support nested |replacements|. 
    
    Alternate tables / previous iterations in this comment.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    
    I couldn't get multiple rows per subject (1st col) working until I discovered CSV tables
    (not possible with simple tables, couldn't get it to work with the grid table syntax).
    
    Links:
        https://docutils.sourceforge.io/docs/ref/rst/directives.html#csv-table
        https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#simple-tables
        https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#grid-tables
    
    Simple Table 

        =======================================   ==================================================================================================================
        Project Folder                             https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities
        Full Script (with Comments & Hints)        | `https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__
        |  `/main/Utilities/emulate_numpad.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`_
        Full Script (minimal Comments)             | `https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.without_commentary.ahk>`__
        |  `/main/Utilities/emulate_numpad.without_commentary.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.without_commentary.ahk>`_
        =======================================   ==================================================================================================================
     
     Grid Table: 
     
        +--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
        | Project Folder           | https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities                                                                                                          |
        +--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
        | Full Script              | `https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__                       |
        | (with Comments & Hints)  |  `/main/Utilities/emulate_numpad.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.ahk>`__                                             |
        +--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
        | Full Script              | `https://github.com/gamepad-coder/AutoHotkey_Projects/blob <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.without_commentary.ahk>`__    |
        | (minimal Comments)       |  `/main/Utilities/emulate_numpad.without_commentary.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/emulate_numpad.without_commentary.ahk>`__       |
        +--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
     
     ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~