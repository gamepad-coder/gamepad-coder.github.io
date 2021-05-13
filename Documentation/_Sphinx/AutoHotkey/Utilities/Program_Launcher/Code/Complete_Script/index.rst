Complete Script
=========================

.. 
    ---------------------------------------------
    |Substitutions| allow manual HTML insertions
    ---------------------------------------------

.. |br| raw:: html

   <br />

.. |nbsp| raw:: html

    &nbsp;
   
.. |h2| raw:: html

   <h2>

.. |2h| raw:: html

   </h2>

.. |details_open| raw:: html

    <details><summary>

.. |summary_close| raw:: html 

    </summary>

.. |details_close| raw:: html

    </details>

.. |indented_block| raw:: html

    <div style="padding-left:60px;">

.. |indented_block_close| raw:: html

    </div>

  
.. |collapsible_wrapper| raw:: html 

    <div class="collapsible_wrapper">

.. |collapsible_wrapper_close| raw:: html 

    </div>

.. |collapsible_label_1| raw:: html

   <input  id="collapsible_section_1" class="toggle_collapsible_section" type="checkbox">
   <label for="collapsible_section_1" class="label-toggle_collapsible_section">

.. |collapsible_label_2| raw:: html

   <input  id="collapsible_section_2" class="toggle_collapsible_section" type="checkbox">
   <label for="collapsible_section_2" class="label-toggle_collapsible_section">

.. |collapsible_label_close| raw:: html 

    </label>
    
.. |collapsible_section| raw:: html

   <div class="collapsible_section">

.. |collapsible_section_close| raw:: html 

    </div>

.. 
    ---------------------------------------------
    </> end of section defining  |Substitutions| 
    ---------------------------------------------

Program Launcher is divided into two files. 

The first file ``program_launcher.ahk`` contains 

* The initialization code.
* The hotkey.
* A class containing functions to parse the .ini savefile.
* The default text for the savefile, and code to create a vanilla savefile
  (this happens when program launcher's script file
  doesn't find a savefile in the folder where its script lives).

The second file ``program_launcher_settings_window.ahk`` contains 

* The GUI code for the main settings window.
* The GUI code for the popup window to configure actions.
* The GUI code for the popup window to configure commands.

When ``program_launcher.ahk`` is run, it automatically imports 
the code contained in ``program_launcher_settings_window.ahk``. 


.. hint::
    
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
    
**program_launcher.ahk** 

.. literalinclude:: program_launcher.ahk
   :language: AutoHotkey_CustomLexer

**program_launcher_settings_window.ahk**

.. literalinclude:: program_launcher_settings_window.ahk
   :language: AutoHotkey_CustomLexer


|h2| Demo: |2h|

.. |href_pt1| raw:: html 

    <a class="reference external image-reference" href="

.. |href_pt2| raw:: html 

    ">

.. |picture_pt1| raw:: html 

    <img alt="

.. |picture_pt2| raw:: html 

    " src="

.. |picture_pt3| raw:: html 

    "/></a>

|href_pt1|\ ../../HelloProgramLauncher.gif\ |href_pt2|\ 
|picture_pt1|\ ../../HelloProgramLauncher.gif\ |picture_pt2|\ ../../HelloProgramLauncher.gif\ |picture_pt3|
