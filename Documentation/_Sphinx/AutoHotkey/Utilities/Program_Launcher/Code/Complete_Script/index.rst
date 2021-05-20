.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                                       HTML CODE |SUBSTITUTIONS|
                                       DEFINED IN /conf.py
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

=========================
Code
=========================

|picture_pt1_a_open_href|\ ../../HelloProgramLauncher.gif\ |picture_pt2_close_href_a|\ 
|picture_pt3_img_open_alt|\ ../../HelloProgramLauncher.gif\ |picture_pt4_img_src|\ ../../HelloProgramLauncher.gif\ |picture_pt5_close_img_a|

|br|

|h2|\ How Program Launcher is Organized\ |h2_close|

Program Launcher is divided into two files. 

The first file |blue_code|\ program_launcher.ahk\ |blue_code_close| contains 

* The initialization code.
* A label which displays a command prompt when the hotkey is pressed. 
  (If the user types a known command here, this label runs the 
  associated action. The hotkey is read from the savefile.)
* A class containing functions to read and write to the .ini savefile.
* The default text for the savefile, and code to create a vanilla savefile.
  (A default savefile is created when program launcher's script file
  doesn't find a savefile in the folder where its script lives.)

The second file ``program_launcher_settings_window.ahk`` contains 

* The GUI code for the main settings window.
* The GUI code for the popup window to configure actions.
* The GUI code for the popup window to configure commands.

When |blue_code|\ program_launcher.ahk\ |blue_code_close| is run, it automatically imports 
the code contained in ``program_launcher_settings_window.ahk``. 

|br|

|h2|\ Download\ |h2_close|

You need both |blue_code|\ program_launcher.ahk\ |blue_code_close| and ``program_launcher_settings_window.ahk`` to run this app.
|br|\ *(Place them in the same folder, but that folder can be anywhere)*.

.. csv-table::

   "**Project Folder**"
   "`https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main <https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities/Program_Launcher>`__"
   "|nbsp| |nbsp| |nbsp| `/Utilities/Program_Launcher <https://github.com/gamepad-coder/AutoHotkey_Projects/tree/main/Utilities/Program_Launcher>`__"
   ""
   "**program_launcher.ahk**"
   "`https://github.com/gamepad-coder <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher.ahk>`__"
   "|nbsp| |nbsp| |nbsp| `/AutoHotkey_Projects/blob/main/Utilities <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher.ahk>`__"
   "|nbsp| |nbsp| |nbsp| `/Program_Launcher/program_launcher.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher.ahk>`__"
   ""
   "**program_launcher_settings_window.ahk**"
   "`https://github.com/gamepad-coder <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings_window.ahk>`__"
   "|nbsp| |nbsp| |nbsp| `/AutoHotkey_Projects/blob/main/Utilities <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings_window.ahk>`__"
   "|nbsp| |nbsp| |nbsp| `/Program_Launcher/program_launcher_settings_window.ahk <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings_window.ahk>`__"
   ""
   "**Sample Settings File**"
   "`https://github.com/gamepad-coder <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings.ini>`__"
   "|nbsp| |nbsp| |nbsp| `/AutoHotkey_Projects/blob/main/Utilities <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings.ini>`__"
   "|nbsp| |nbsp| |nbsp| `/Program_Launcher/program_launcher_settings.ini <https://github.com/gamepad-coder/AutoHotkey_Projects/blob/main/Utilities/Program_Launcher/program_launcher_settings.ini>`__"
    

To download these individual files on GitHub: 

#. Navigating to the file you want.
#. Right-click the button that says :kbd:`Raw`.
#. Click "Save Link As..." and save your script file.

Alternatively:

- `Download a .zip of my entire AutoHotkey_Projects repository on Github <https://github.com/gamepad-coder/AutoHotkey_Projects/archive/refs/heads/main.zip>`__.

|br|
    
.. note::
    
    If you want to look at AutoHotkey scripts in a text editor with highlighted code, see the links 
    at the bottom of my :ref:`AutoHotkey Resources <Ref-What_is_AutoHotkey-Resources-Text_Editors>` section.

|br|

|h2|\ Read The Full Script On This Page\ |h2_close|

In this section, you can read the entire code for |blue_code|\ program_launcher.ahk\ |blue_code_close| and ``program_launcher_settings_window.ahk``.

.. hint::
    
    **Folding and Unfolding:**

    You can expand and contract sections of code in the scripts below.
    
    For Program Launcher, I've collapsed the classes and functions on this page
    since this script is so long.
    
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

.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment
    
    The history/progression of |hint_tutorial__navigating_codeblocks| 
    is outlined at the bottom of this document.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

|collapsible_wrapper|
|alt_collapsible_label_open|\ **program_launcher.ahk** |alt_collapsible_label_endopen| |collapsible_section| 

.. literalinclude:: program_launcher.ahk
   :language: AutoHotkey_CustomLexer

|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|


|collapsible_wrapper|
|alt_collapsible_label_open|\ **program_launcher_settings_window.ahk** |alt_collapsible_label_endopen| |collapsible_section| 

.. literalinclude:: program_launcher_settings_window.ahk
   :language: AutoHotkey_CustomLexer

|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|

|
|
|
|

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    Comment 
    
    At first as I built this .. hint:: ... box 
    I had the code duplicated.
    
    Then as it grew more elaborate and as I wanted to make more tweaks 
    to the spacing and CSS stylings, I decided to just pluck the whole thing 
    and add it as a |substitution| inside of 
        /config.py : rst_prolog's substitution definitions.
    
    For reference or nostalgia, I've kept the first iterations here for now.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    v2
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    
        .. hint::
            
            |details_open| **Scrolling Horizontally (On PC):** |summary_close|    
            |barely_indented_block|
            |br_small|
            If your mouse has a wheel, you can scroll horizontally using the mouse. 
            Place your mouse cursor over the code, hold shift, then move the wheel up or down.

            If you are using a laptop which supports two-finger-scrolling, 
            hold shift and move two fingers up or down on the touchpad *(both in the same direction)*, 
            and the region under the mouse will scroll horizontally. 

            This only works if 

            #. The mouse is hovering over the area to scroll.
            #. The area under the mouse has a horizontal scroll bar. 
            
            If nothing happens, then your window is big enough to display the entire
            width of the box. *(In this scenario, horizontal scroll bar will be
            greyed out, if it exists)*.
            |indented_block_close|    
            |details_close|    
            |br| |hr|
            |details_open| **Quick Navigation (On PC):** |summary_close|    
            |barely_indented_block| 
            |br_small|
            I've used the HTML ``<details>`` tag to add text folding to
            
            * these Hint boxes,
            * the blue-outlined boxes which contain entire scripts,
            * and blocks of code with curly braces {}.
            
            On PC, you can quickly navigate between the foldable ``<details>`` tags.
            
            First click any block of code or text which has a folding arrow to activate it.
            
            Once you've activated one of the folding code blocks,
            you can use :kbd:`Tab` to go to the next foldable region, and 
            :kbd:`Shift`\ +\ :kbd:`Tab` to go to the previous region.
            
            After pressing (\ :kbd:`Shift`\ +) :kbd:`Tab`\ , the selected region 
            should be outlined by your web browser. Press :kbd:`Space` when a region
            is outlined to toggle its fold/unfold state!  
            
            
            *(Note 1: If* |ib|\ "Quick Navigation (On PC)"\ |ib_close| *was the last thing 
            you clicked, then the* |i_code|\ <details>\ |i_code_close| *containing 
            this block is currently activated. Go ahead and try pressing* :kbd:`Tab` *now!)*
            
            *(Note 2: This navigation trick only works after clicking a foldable region,
            or clicking somewhere in the middle of the page, outside of the sidebar.*
            
            *If you load the page then immediately press* :kbd:`Tab`\ *,  the
            Table of Contents in the Sidebar will be outlined first.  If this happens,
            click a foldable text block to change the activated region, then use*
            :kbd:`Tab`\ *.)* |br|
            |indented_block_close|    
            |details_close|
            |br_small|
            
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    v1
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

        |collapsible_wrapper|
        |collapsible_label_1|\ **program_launcher.ahk** |collapsible_label_close| |collapsible_section| 

        .. literalinclude:: program_launcher.ahk
           :language: AutoHotkey_CustomLexer

        |collapsible_section_close|
        |collapsible_wrapper_close|


        |collapsible_wrapper|
        |collapsible_label_2|\ **program_launcher_settings_window.ahk** |collapsible_label_close| |collapsible_section| 

        .. literalinclude:: program_launcher_settings_window.ahk
           :language: AutoHotkey_CustomLexer

        |collapsible_section_close|
        |collapsible_wrapper_close|
        
        |collapsible_wrapper|
        |collapsible_label_2|\ **program_launcher_settings_window.ahk** |collapsible_label_close| |collapsible_section| 
        
        .. literalinclude:: program_launcher_settings_window.ahk
           :language: AutoHotkey_CustomLexer
        
        |collapsible_section_close|
        |collapsible_wrapper_close|
    
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~