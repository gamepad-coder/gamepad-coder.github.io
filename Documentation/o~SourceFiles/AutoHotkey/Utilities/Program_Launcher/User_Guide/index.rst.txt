.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                                       HTML CODE |SUBSTITUTIONS|
                                       DEFINED IN /conf.py
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

====================
User Guide
====================

|picture_pt1_a_open_href|\ ../HelloProgramLauncher.gif\ |picture_pt2_close_href_a|\ 
|picture_pt3_img_open_alt|\ ../HelloProgramLauncher.gif\ |picture_pt4_img_src|\ ../HelloProgramLauncher.gif\ |picture_pt5_close_img_a|

|collapsible_wrapper|
|alt_collapsible_label_open|\ **About program_launcher.ahk** |alt_collapsible_label_endopen| |collapsible_section| 

.. code-block:: AutoHotkey_CustomLexer

    ;===========================================================================
    ;                           program_launcher.ahk
    ;===========================================================================
    ;
    ;
    ;  ------------------
    ;  What it does:
    ;  ------------------
    ;
    ;  program_launcher.ahk is a small utility
    ;  to reduce the number of steps to
    ;
    ;     () open programs or
    ;     () navigate to folders.
    ;
    ;  You can register words or phrases as [commands]
    ;  which program_launcher.ahk will associate with an [action].
    ;
    ;
    ;  --------------------
    ;  Commands + Actions:
    ;  --------------------
    ;
    ;  A command can be any single-line series of typable text you desire.
    ;
    ;  Each command triggers one specific action.
    ;  Each action can have multiple commands which trigger it.
    ;
    ;  Example:
    ;
    ;     Register the command "Show me my muisc"
    ;     -> to open the folder C:/Music in a new window.
    ;
    ;     Register (also) the command "mu"
    ;     -> to open the folder C:/Music in a new window.
    ;
    ;  Currently, commands can only be one line long, but can contain:
    ;
    ;     () any alphanumeric text
    ;     () spaces
    ;     () symbols ~!@#$%^&*()_+-=[]\{}|;':",./<>?
    ;
    ;  Actions fall into three categories:
    ;
    ;     (1) Open a folder in a new window.
    ;     (2) Open an application.
    ;     (3) program_launcher.ahk functions:
    ;         () Quit
    ;         () Settings
    ;
    ;
    ;  ------------------
    ;  How to use it:
    ;  ------------------
    ;
    ;  Run program_launcher.ahk
    ;
    ;  (1) Add some commands:
    ;
    ;     (1.1)  Hit the hotkey to bring up the command prompt
    ;
    ;            (By default, this is Ctrl+Windows+Space.
    ;            This can be changed using this file,
    ;            or by using the settings window).
    ;
    ;     (1.2)  A popup will appear.
    ;            Type 'settings' or 'config' or 'configuration' here
    ;            (without quotes).
    ;
    ;     (1.3)  Hit <Enter> or press "OK".
    ;
    ;     (1.4)  The command popup will disappear.
    ;            The settings window will appear.
    ;
    ;            Change or add commands and actions.
    ;
    ;     (1.5)  Close the settings window.
    ;            Your changes will be automatically saved to this file.
    ;
    ;  (2) Use your commands:
    ;
    ;     (2.1)  Hit the hotkey to bring up the command prompt
    ;            (default setting is Ctrl+Windows+Space)
    ;
    ;     (2.2)  Type one of the commands you registered in (1.4)
    ;
    ;     (2.3)  Hit <Enter> or press "OK".
    ;
    ;     (2.4)  Enjoy!
    ;
    ;
    ;
    ;  -------------------------------
    ;  How do I know if it's running?
    ;  -------------------------------
    ;
    ;  Run program_launcher.ahk.
    ;  You will see its icon appear in Window's "Notificaiton Area"
    ;  (located at the right end of the Windows Taskbar, just before the clock).
    ;
    ;  If you hover your mouse over this script's icon in the Notificaiton Area,
    ;  a tooltip will appear saying "program_launcher.ahk".
    ;
    ;
    ;  -------------------
    ;  How do I close it?
    ;  -------------------
    ;
    ;  To close program_launcher.ahk either:
    ;
    ;  (1) Right click its icon in the Notificaiton Tray and click "Exit".
    ;
    ;  (2) Quit using a command:
    ;
    ;      (2.1)  Press the hotkey to display the commandline popup
    ;             (by default, this hotkey is Ctrl+Win+Space).
    ;      (2.2)  Type 'q' or 'quit' or 'exit' without quotes (').
    ;      (2.3)  Hit enter or click "OK".
    ;      (2.4)  The program will stop running.
    ;
    ;
    ;===========================================================================

|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|


|h2| Using Program Launcher |h2_close|


.. todo::
    
    Add basic tutorial with short video demonstrations.

    How to use the Config window. |br| Demonstrate drag 'n drop.


|h2| The Settings File |h2_close|

|collapsible_wrapper|
|alt_collapsible_label_open|\ **Basic Use** |alt_collapsible_label_endopen| |collapsible_section| 

.. code-block:: text 

    ;====================================================================
    ; About the settings file:         program_launcher_saved_phrases.ini
    ;====================================================================
    ;
    ;  ------------------
    ;  Commented lines :
    ;  ------------------
    ;
    ;     program_launcher.ahk will ignore any line
    ;     in this config file if it starts with ';'
    ;
    ;     Feel free to keep, alter, move, or remove any commented lines.
    ;     It won't affect program_launcher.ahk's behavior.
    ;
    ;  -----------
    ;  Settings :
    ;  -----------
    ;
    ;  Setting name:               "icon"
    ;  Value for setting:          Integer number.
    ;
    ;    How it works:
    ;
    ;      This number corresponds to a Shell32.dll icon number.
    ;      This script will use this icon
    ;      (1) in the Windows Notification Tray
    ;      (2) in the window title bars for program_launcher.ahk's
    ;          (2.a) commandline popup
    ;          (2.b) configuration window
    ;
    ;
    ;  Setting name:               "hotkey_for_commandline_popup"
    ;  Value for setting:          Key names separated by spaces.
    ;
    ;    How it works:
    ;
    ;      When this hotkey is pressed
    ;      program_launcher.ahk displays its commandline popup.
    ;
    ;
    ;  Setting name:               "hotkey_for_quit"
    ;  Value for setting:          Key names separated by spaces.
    ;
    ;    How it works:
    ;
    ;      When this hotkey is pressed
    ;      program_launcher.ahk exits.
    ;
    ;
    ;   ---------------------
    ;   Commands + Actions :
    ;   ---------------------
    ;
    ;   Commands can be registered to actions in two ways:
    ;
    ;      (1) Add them manually to this settings file,
    ;          then refresh program_launcher.ahk.
    ;
    ;          Press the the hotkey associated with
    ;          [hotkey_for_commandline_popup]
    ;
    ;          Type 'r' or 'reload', and hit enter.
    ;
    ;      (2) Add them using the settings window.
    ;
    ;          Open program_launcher.ahk's command prompt
    ;          (by default, this hotkey is Ctrl+Win+Space)
    ;          then type 'settings' or 'config' or 'configuration'
    ;          press OK, then the configuration window should appear.
    ;
    ;   Commands can contain:
    ;     (+) spaces*
    ;     (+) symbols
    ;     (+) any printable ASCII character.
    ;     *see note below.
    ;
    ;   Each Command phrase is associated with a single action.
    ;   program_launcher.ahk handles two action types, either :
    ;     (1) launch a specific explorer folder, or
    ;     (2) launch a program (optionally with a passed default path)
    ;
    ;====================================================================


    ;===========================================================================
    ; Help
    ;===========================================================================
    ;
    ; ------------------------------
    ; How do I back up my settings?
    ; ------------------------------
    ;
    ; (1) Using Windows Explorer
    ;     copy and paste the file "program_launcher_saved_phrases.ini"
    ;     (the settings file you're reading right now) to make a backup.
    ;
    ;     If the reader is unfamiliar, these are the steps:
    ;
    ;       (1.1) Navigate to this file in Windows Explorer.
    ;       (1.2) Select this file by clicking it once.
    ;       (1.3) Press <Ctrl+C> to copy it.
    ;       (1.4) Press <Ctrl+V> to paste it.
    ;             This will create a duplicate copy.
    ;
    ;       Fun trivia: When you paste the file in step (1.4),
    ;       it does not matter if the file is still selected (or not).
    ;       Windows Explorer ignores what is (or isn't) selected
    ;       when you tell it to paste files,
    ;       it only cares about which folder you are currently in.
    ;
    ;       Conversely, Windows Explorer does care about what is selected
    ;       when you copy files in step (1.3), and will copy all selected files.
    ;
    ;
    ; (2) Rename the duplicate file and give it a new name like:
    ;     "program_launcher_saved_phrases.ini.backup123"
    ;     or any name you prefer.
    ;
    ;     As long as the backup's name doesn't exactly match
    ;     "program_launcher_saved_phrases.ini",
    ;     the backup will be ignored.
    ;
    ;
    ; ----------------------------------------------------
    ; How to I restore the default settings and commands?
    ; ----------------------------------------------------
    ;
    ; program_launcher.ahk can auto-generate this file.
    ;
    ; NOTE: This step will not auto-generate your custom commands and actions.
    ;       Be sure to make a backup file first.
    ;
    ;   (a) Move or copy
    ;      program_launcher.ahk to a directory without
    ;      program_launcher_saved_phrases.ini.
    ;
    ;      When you run program_launcher.ahk
    ;      the default version of this settings file will be auto-generated.
    ;
    ;   (b) Alternatively
    ;===========================================================================

|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|

|collapsible_wrapper|
|alt_collapsible_label_open|\ Advanced Use: |br| |nbsp| |nbsp|\ Syntax and Parsing Overview |alt_collapsible_label_endopen| |collapsible_section| 

.. code-block:: AutoHotkey_CustomLexer
        
    (
    
    ==================================================  
    Parsing the settings file
    ==================================================  

      program_launcher.ahk's settings are stored in 
      program_launcher_saved_phrases.ini

      When program_launcher does not detect 
      program_launcher_saved_phrases.ini in its folder 
      program_launcher will generate this settings .ini file 
      with default values.

      More details can be found below
      and in the settings file itself.

        
    ==================================================
    Edge case Overview:

    Notes about (;) semicolons and ( ) spaces 
    in the settings file:
    ==================================================  

      COMMENTS IN THE SETTINGS FILE: 

        Any line in program_launcher_saved_phrases.ini
        which begins with a semicolon (;) will be ignored or "commented out" 
        when program_launcher reads its settings.

        Any line beginning with spaces and tabs in the settings file are ignored,
        and lines are parsed beginning at the first non-whitespace character of the line.
        
        To begin a command with one or more semicolons or 
        to begin a command with one or more leading spaces
        (or a combination of both)
        start the command with the phrase:
        
          \BEGIN_LITERAL\
          
        For more details:
        See the COMMANDS sub-section in the SYNTAX section below.
        
        
      HOW COMMANDS ARE READ INTO THE PROGRAM:
        
        Each command takes up only one line in the settings file.
        Each command is located in the 'commands[]' section.
        Each command begins with one or more characters, 
         then ends the line with a (:) colon and an Action ID.

        program_launcher ignores lines in the settings file
        which begin with a (;) semicolon.
        
        program_launcher will ignore leading spaces and tabs 
        when reading commands from its settings file.
        
        
        program_launcher determines which part (of a non-commented line)
        is the command phrase by:
        
          [1] Ignoring all spaces and tabs at the beginning of a line
          [2] Reading from the first non-whitespace character onward until
          [3] it finds a colon and a number at the end of the line.
          
        [1] and [3] are stripped, and [2] becomes the resulting command.
        
        If you wish to use leading spaces or semicolons for commands, 
        use the "\BEGIN_LITERAL\" flag (details below).


    =======================================================
    Conventions for syntax annotations in the next section:
    =======================================================
      
      "Double quotes signify verbatim text needed here".
      'Single quotes represents a class of acceptable input'.
      Unquoted phrases reprsent datatypes 
       like integer numbers (possibly with clarifying parenthesis).
      
      
      
    ===============================================
    SYNTAX for program_launcher_saved_phrases.ini:
    ===============================================
      
      SETTINGS 
        
        Syntax:
          
          "settings["
            'setting_name' ":" int (for icon)
            'setting_name' ":" 'modifierkey1' 'a space character' 'key' (for hotkeys)
            'setting_name' ":" 'modifierkey1' 'a space character' 'modifierkey2' 'a space' 'key' (for hotkeys)
          "]"
          
          Note:
            
            For valid keynames, see:
              https://www.autohotkey.com/docs/KeyList.htm
            
            For information about hotkeys using AutoHotkey, see:
              https://www.autohotkey.com/docs/Hotkeys.htm
        
        Example:
        
          settings[
            icon:123
            hotkey_for_commandline_popup:control alt space
            hotkey_for_quit :            shift ctrl win q
          ]
        
        Available:
        
          [1]  "hotkey_for_commandline_popup" : 'mod1' .. 'modn' 'key'
          [2]  "hotkey_for_quit" : 'mod1' 'mod2' etc 'key'
          [3]  "icon" : int
        
          Minimum:
            
            [1] is required.
            [2] and [3] are optional.
        
        Syntax Rules:
        
          Capitalization doesn't matter.
          Leading tabs or spaces are optional (and ignored).
          Hotkey key names must be separated from one another by spaces.
          Hotkey key names must be from the list here: 
            https://www.autohotkey.com/docs/KeyList.htm
          Spaces directly surrounding the ":" colon 
           in the SETTINGS[] section of program_launcher_saved_phrases.ini
           are optional and ignored. 
          (Spaces in the "COMMANDS[]" settings section 
           surrounding the final ":" do matter. See next subsection.)
      
      
      COMMANDS
        
        Syntax:
        
          "commands["
            'command word or phrase' ":" int (unique action ID)
            'command word or phrase' ":" "Quit" 
            'command word or phrase' ":" "Settings" 
            
          "]"
          
        
        Example:

          commands[
            Play a ~groovy~ tune:234
          ]
        
        
        Syntax Rules: 
          
          Each command can only be one line long. 
          Each command can contain any typable symbol.
          Each command must be followed by a colon and a whole number.
                      
          The colon + wholenumber pair (": 12" or ":23") correspond to an Action ID,
          and any spaces to the right of this colon are optional and ignored.
          
          Whitespace to the left of the (:) colon will be considered part of the command.
          
            For example:
              "command for music: 123" and 
              "command for music : 123"
            This first command requires 'c' as the last character.
            This second command requires a space as the last character.
          
          Special (non-int) Action IDs:
          
            There are only two actions which have no ID number: QUIT and SETTINGS.
            These are hardcoded to quit the program 
            or pull up the interactive settings window, respectively.
            
            For commands which trigger ": Quit" or ":Settings", capitalization is ignored,
            but there must still be a (:) colon between the command and the action "ID".
            
          Leading Spaces: 
          
            Leading tabs or spaces at the beginning 
            of commands in the settings file are ignored.        
          
          Leading Semicolons:
          
            Lines beginning with a semicolon are ignored.
            Lines beginning with tabs or spaces then a semicolon are ignored.
        
        
        The \BEGIN_LITERAL\ flag:
        
          How: 
          
            To begin a command with a semicolon or 
            to begin a command with whitespace 
            
               (1) Add the phrase "\BEGIN_LITERAL\" 
                   (with (\) backslashes, without (") quotes)
                   to the beginning of the command, 
            
               (2) type whatever you want the command to be verbatim, 
               
               (3) then finish the line with a colon and an action ID number.
          
          
          Why: 
          
            program_launcher ignores lines beginning with a semicolon (ex: ";line...")
            when reading the file program_launcher_saved_phrases.ini.
            
            This allows lines to be "commented out" instead of deleting them, 
            and allows the user to add notes.
            
            If the user desires a command which begins with a semicolon (and or whitespace), 
            add the text
              \BEGIN_LITERAL\
            to the beginning of the command  (including the (\) backslashes).
          
            This allows the semicolon comment syntax to remain consistent
            without adding a multitude of additional rules for parsing.
            
           
           Example + Elaboration:

            Pretend the user wants to 
               (1) open the commandline popup,
               (2) type ";calculator" (excluding the (") quotes)
               (3) hit enter
               (4) and have action 235 run.
            
            The following setting will accomplish that:
            
              commands[
                Play a ~groovy~ tune:234
                \BEGIN_LITERAL\;calculator:235
              ]
            
            Now pretend, for reasons undisclosed to us,
            the user wants to type:
            
              ;\BEGIN_LITERAL\;calculator:234
             
            to trigger action 235.
            
            
            The following setting will accomplish that:
            
              commands[
                Play a ~groovy~ tune:234
                \BEGIN_LITERAL\;\BEGIN_LITERAL\;calculator:234:235
              ]
            
            program_launcher will store everything between the first
              \BEGIN_LITERAL\
            and the final 
              :235
            as the command which triggers action 235.
            
            
      
      ACTIONS
          
        Syntax:
        
          int ID, "Folder", "C:/drive/path"
          int ID, "Program", quoted full path, (optional argument) quoted full path
        
        
        Example:
        
          236, Program, "C:/apps/winamp.exe", "C:/music/GroovySpoon.mp3"
          237, Folder, "D:/music/My Favorite Songs/"
          

        Syntax Rules:
        
          Actions are single lines.
          No two actions have the same ID
          
          File paths (to folders or programs) must be absolute and "quoted".
          An action does one of three things:
          [1]      Open a folder in Windows Explorer.
          [2]      Open a program 
          [3]      Trigger an internal routine 
                   (for now, only "Quit" and "Settings")
          
          Each action in category [1] or [2] must have an entry in the settings file, 
          but category [3] actions are referenced directly by commands 
          and are the only actions without an ID. 
          
          Trailing slash for folders is optional.
       
      )
      
|collapsible_section_close|
|alt_collapsible_label_close|
|collapsible_wrapper_close|
