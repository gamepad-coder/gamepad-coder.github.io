            ;-------------------------------------;
            ;                                     ;
            ;           PUBLIC DOMAIN             ;
            ;                                     ;
            ;       This file is released         ;
            ;       under the cc0 license.        ;
            ;                                     ;
            ;-------------------------------------;
            ;                                     ;
            ;   Written by:                       ;
            ;                    Gamepad-Coder    ;
            ;                                     ;
            ;-------------------------------------;


;-----------------------------------------------------------------------;
;  _program_launcher.ahk                                                ;
;-----------------------------------------------------------------------;
;                                                                       ;
;                                                     version 2         ;
;                                                                       ;
;                                          detailed instructions        ;
;                                     at the bottom of this file        ;
;-----------------------------------------------------------------------;


; ===================================================
; AutoHotkey hotkey syntax key:
; ===================================================
;    +  shift
;    ^  ctrl
;    #  win
;    !  alt
;
; For more information see:
; https://www.autohotkey.com/docs/commands/Hotkey.htm
; https://www.autohotkey.com/docs/KeyList.htm
; ===================================================


;================================================;
;                                                ;
;             begin autorun section              ;
;                                                ;
;================================================;
   
_____COMMENT_DETAILS_BEGIN_____1t_ ;---------
   ;    ?    ;
   ;--------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ; For more information about the "auto-execute section"   ;
   ; at the beginning of an AutoHotkey script, see:          ;
   ;     https://www.autohotkey.com/docs/Scripts.htm#auto    ;
   ;--------------------------------------------------------- _____COMMENT_DETAILS_END_____
   

#SingleInstance Force
SetWinDelay, -1
SetControlDelay, -1 
  ;
  ; more info:
  ;
  ;      https://www.autohotkey.com/docs/commands/SetControlDelay.htm
  ;      https://www.autohotkey.com/boards/viewtopic.php?t=9660
  ;
  ;      https://www.autohotkey.com/docs/commands/SetWinDelay.htm
  ;
  ;      https://www.autohotkey.com/docs/commands/_SingleInstance.htm
  ;---------------------------------------------------------------------------


_AHK_DIR := "C:\[autohotkey]\"



_____COMMENT_DETAILS_BEGIN_____1t_ ;----------------------------------------------------------------
   ; variables
   ;---------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ;
   ;
   ;   [_savefile_path]
   ;     
   ;      Default name of the settings file from which 
   ;      _program_launcher.ahk loads settings and saved commands.
   ;     
   ;      This filename can be changed here.
   ;
   ;
   ;   [_savefile__default_content]
   ;
   ;      Holds the default text to insert into 
   ;      the %_savefile_path%.ini file.
   ;
   ;
   ;   [_hotkey_for_commandline_popup]
   ;      
   ;      Assigned by .ini settings, by default <^#Space>
   ;      If unlisted in .ini
   ;        then automatically assigned to default.
   ;      
   ;      Program is useless without at least this, 
   ;      so it can't be omitted.
   ;      
   ;      Edge cases with buggy AHK scripts can result in blocking
   ;      keyboard or mouse input. But for normal use this hotkey 
   ;      will always allow the user to exit the application:
   ;        - by opening the command prompt 
   ;        - then typing the Command associated with Quit.
   ;
   ;
   ;  [_hotkey_for_quit]
   ;    
   ;     Assigned via .ini, by default <^#Q>.
   ;     If unlisted in .ini
   ;       then there will be no hotkey assigned
   ;       to quit _program_launcher.ahk
   ;     
   ;     If unlisted, program can be quit:
   ;     (1)  by right clicking the Notification Tray icon 
   ;          for _program_launcher.ahk, then selecting quit, 
   ;     
   ;     or 
   ;     
   ;     (2)  by opening the commandline popup
   ;          then entering the command assigned to the Quit aciton.
   ;---------------------------------------------------------------- _____COMMENT_DETAILS_END_____

   
   
   _o_Gui_ProgramLauncher_UserInputCommand_Popup := ""    
   _o_Gui_Config_Main       := ""
   _o_Gui_Config_Popup      := ""
   _o_Gui_Config_IconPicker := ""

   _COMMANDS := {}
   _ACTIONS  := {}
   
   _ICON_INDEX := 138

   _savefile_path := "program_launcher_settings.ini"
   _savefile__default_content := ""

   _hotkey_for_commandline_popup := "" 
   _hotkey_for_settings          := "" 
   _hotkey_for_reload            := "" 
   _hotkey_for_quit              := "" 

   FILE_HELPER.Load_Settings()
   
   Menu, Tray, Icon, Shell32.dll, %_ICON_INDEX%


return


;================================;
; </>  end of autorun section    ;
;================================;
   

;-----------------------------------------------------------------------------------------------
  

;================================================;
;                                                ;
;                   Hotkeys                      ;
;                                                ;
;================================================;



^#r::
^#!r::
   Reload
return


;==================================;
; </>  end of Hotkey definitions   ;
;==================================;


;-----------------------------------------------------------------------------------------------


;================================================;
;                                                ;
;                    Labels                      ;
;                                                ;
;================================================;


;======================
; Quit
;======================

ProgramLauncherQuit:
   ExitApp
return   


;===================================================
; SETTINGS 
;
;-> Open the window to configure Program Launcher.
;===================================================

OpenConfigurationWindow:
   _o_Gui_Config_Main := new GuiConfigMain         
return 


;======================================================
; Reload Settings Window
;
; -> Reloads the configuration window 
;    in order to display a new icon in the title bar.
;======================================================

_____DETAILS_BEGIN_____0t_ ReloadConfigurationWindow:
{ _____SUMMARY_END_____
_____COMMENT_DETAILS_BEGIN_____1t_ ;-------------------------------------------------------------------
   ; When the user selects a new Icon, 
   ; the Configuration Gui should reflect this change.
   ;------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ;
   ; Progression:
   ;
   ;    1. The user changes the program's icon using 
   ;       the "Settings" tab of the Configuration Gui
   ;    2. The Configuration Gui's class stores the user's choice
   ;       in the global _ICON_INDEX variable. 
   ;    3. The Config Gui calls this label. 
   ;    4. This label deletes both the Configuration Window's 
   ;       global object instance & the Config Window Gui. 
   ;    5. This label re-creates the Config Window's object & Gui.
   ;    6. The Config Window is told to change to the "Settings" tab.
   ;    7. The Config Window now has a new icon and the user is still 
   ;       oriented and on the same tab. 
   ;
   ; Aesthetically, this implementation is a bit choppy in presentation, 
   ; but it's a simple way to accomplish changing the icon 
   ; without telling the user 
   ; 
   ;   "This will be reflected the next time you run this application."
   ; 
   ; Alternatively:
   ;
   ;        It seems like a title bar icon can be changed at runtime
   ;        without destroying the gui by using .dll calls, 
   ;        but I haven't personally researched this.
   ;     
   ;        Further reading:
   ;        
   ;        https://www.autohotkey.com/boards/viewtopic.php?t=72727
   ;
   ;------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
   
   _o_Gui_Config_Main := ""
   _o_Gui_Config_Main := new GuiConfigMain
   _o_Gui_Config_Main.Fn_Change_to_Settings_Tab()
   
   return
} _____DETAILS_END_____


;======================
; Command Line Popup
;======================

_____DETAILS_BEGIN_____0t_ ProgramLauncherPopupCommand:
{ _____SUMMARY_END_____
_____COMMENT_DETAILS_BEGIN_____1t_ ;--------------------------------------------------------
   ; This label creates the "Command Line" popup
   ; where the user can type a Command to trigger an Action.
   ;-------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ;
   ; If the Command exists and is not disabled, 
   ; then the Action associated with the Command is run,
   ; and the popup is closed.
   ;
   ; If the Command is disabled, or text is typed 
   ; which does not match any Command, 
   ; then the popup silently closes. 
   ;-------------------------------------------------------- _____COMMENT_DETAILS_END_____

   box_title         := "Program Launcher!"
   box_prompt        := "`nEnter your command...        : ) "
   box_option_noHide := ""
   box_width         := 300
   box_height        := 150
   Inputbox, userEnteredString
      , %box_title%
      , %box_prompt%
      , %box_option_noHide%
      , %box_width%
      , %box_height%
      ;   , X
      ;   , Y
      ;   , Font
      ;   , Timeout
      ;   , Default string for editable field
   
   ;-----------------------------------------------------------------------
   ; https://www.autohotkey.com/docs/commands/InputBox.htm#Error_Handling
   ;
   ; If the user hits cancel or escape,
   ; then don't process the entered text.
   ;
   ;
_____DETAILS_BEGIN_____1t_ if( 0 != ErrorLevel ){ _____SUMMARY_END_____
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ if( _COMMANDS.HasKey( userEnteredString ) ){ _____SUMMARY_END_____
      cmd := _COMMANDS[ userEnteredString ]
      
      ;------------------------------------------
      ; If a Command is disabled, it will still 
      ; exist in the app at runtime, but 
      ; calls to run it will be ignored here:
      ;
_____DETAILS_BEGIN_____2t_ if( false == cmd["enabled"] ){ _____SUMMARY_END_____
         return 
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
      
         run_action_id := cmd["action_id"]
         gosub RunActionID
      } _____DETAILS_END_____
   } _____DETAILS_END_____
   
   return
} _____DETAILS_END_____


;======================
; Run Action 
;======================

_____DETAILS_BEGIN_____0t_ RunActionID:
{ _____SUMMARY_END_____
_____COMMENT_DETAILS_BEGIN_____1t_ ;---------------------------------------------------------------------
   ; This is the only place in the code 
   ; where Actions are actually run. 
   ;--------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ;
   ; This label is separate from the "ProgramLauncherPopupCommand" label 
   ; to allow the user to run Actions from both of these windows: 
   ; 
   ;   (1) from the Command input popup 
   ;   (2) from the Actions tab of the Configuration Gui.
   ;
   ;--------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
   
_____COMMENT_DETAILS_BEGIN_____1t_ ;--------------------------------------------------------------
   ; Currently, the only two Actions which call internal functions 
   ;-------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ; for Program Launcher are Quit & Settings.
   ;
   ; The Quit Action :
   ;  - closes any opened popups
   ;  - unassigns any hotkeys registered by the app
   ;  - and terminates the application.
   ;
   ; The Settings Action will open 
   ; a window for the user to interactively :
   ;  - add, edit, and remove Actions & Commands 
   ;  - enable or disable Commands 
   ;  - change settings, including which icon to
   ;    display (this icon appears in the title bar 
   ;    and in the Notification Area of the Windows Taskbar).
   ;                                                              _____COMMENT_DETAILS_END_____
_____DETAILS_BEGIN_____1t_ if( run_action_id == "QUIT" ){ _____SUMMARY_END_____
      ExitApp
   } _____DETAILS_END_____
_____DETAILS_BEGIN_____1t_ else 
   if( cmd.action_id == "SETTINGS" ){ _____SUMMARY_END_____
      
      gosub OpenConfigurationWindow

   } _____DETAILS_END_____
_____COMMENT_DETAILS_BEGIN_____1t_ ;------------------------------------------------------
   ; For all other Actions 
   ;------------------------------------------------------ _____COMMENT_SUMMARY_END_____
   ; 
   ; Either:
   ; - a specific folder is opened or
   ; - a specific app is run 
   ;   optionally with added arguments / parameters
   ;
   ;   For example, if your Chrome web browser 
   ;   has multiple profiles, you can tell it to load 
   ;   for a specific user by using the argument: 
   ;
   ;       --profile-directory="Profile 2"
   ;                                                       _____COMMENT_DETAILS_END_____
_____DETAILS_BEGIN_____1t_ else
   if( _ACTIONS.HasKey( run_action_id ) ){ _____SUMMARY_END_____
      act := _ACTIONS[ run_action_id ]
      
      act_path := act["path"]
      act_type := act["type"]
      act_arg  := act["arg"]
_____DETAILS_BEGIN_____2t_ if( "folder" == act_type ){ _____SUMMARY_END_____
         run explorer.exe "%act_path%"
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else 
      if( "app" == act_type ){ _____SUMMARY_END_____
         run "%act_path%" %act_arg%
      } _____DETAILS_END_____
   } _____DETAILS_END_____
   
   return
   
} _____DETAILS_END_____




;===============================;
; </>   end of Label section    ;
;===============================;


;-----------------------------------------------------------------------------------------------


;===========================================================;
;                                                           ;
;                                                           ;
;        Class - Savefile Parser & Writer functions         ;
;                                                           ;
;                                                           ;
;===========================================================;



_____DETAILS_BEGIN_____0t_ class FILE_HELPER { _____SUMMARY_END_____

   static init__ar_duplicate_actions_found := []
   static init__ar_duplicate_commands_found := []
   
_____DETAILS_BEGIN_____1t_ Load_Settings() { _____SUMMARY_END_____
      
      FILE_HELPER.Initialize_Load_Savefile()
      
      FILE_HELPER.Init_Validate_and_Prompt_User_if_Errors()

   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Initialize_Load_Savefile() { _____SUMMARY_END_____
   global 
   
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         ===============================================
         Steps: 
         ===============================================
         
         (1) See if Savefile exists.
         
         (2) Read Savefile into program memory 
         
            (2.1) Ignore commented lines (any line beginning with a semicolon ';')
            
            (2.2) Look for one of these sections:
               'settings['
               'commands['
               'actions['
            
               (2.3) Parse each line as section 
                    til matching line beginning with ']' 
                    (and containing no other non-whitespace characters)
                    is found :
            
            (2.4) Repeat til all 3 items in (2.2) are searched for 
         
         (3) Defaults & Error Correction
         
            (3.1) if not (1), 
            
                  Generate default savefile
                  Load default settings 
            
            (3.2) if missing 
                 settings:'_hotkey_for_commandline_popup',
                 
                  Use default hotkey <Ctrl+Win+Space>
               
                 if unable to get hotkey from 
                 settings:'_hotkey_for_commandline_popup',
                 
                  Exit Application and inform user how to debug.
                  
                  (This behaviour is intended to prevent 
                  pushing hotkey and overriding other AutoHotkey scripts.)
                  
            (3.3) if missing settings:'icon' 
                 
                  Use default icon
            
            (3.4) if missing command for quit or settings, 
                 
                  if no conflict with other user commands:
                     
                     Add Command:'Quit':Quit
                     Add Command:'Settings':Settings
                  
                  if user command conflicts with Quit or Settings
                  notify as soon as init done.
            
         Done.
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      ;-------------------------------------------
      ;   Create Savefile if it doesn't exist.  
      ;-------------------------------------------
      
_____DETAILS_BEGIN_____2t_ if( ! FileExist(_savefile_path) ){ _____SUMMARY_END_____
      
         ;---------------------------------------------------------------
         ; Either 1st run, or user renamed, deleted, or moved savefile.
         ; Steps to take:
         ;
         ;    (1) init _savefile__default_content
         ;    (2)   create default save file 
         ;---------------------------------------------------------------
         
         gosub Default_Save_File
         FileAppend, %_savefile__default_content%, %_savefile_path%
      } _____DETAILS_END_____

      ;------------------------------------
      ;   Parse savefile into memory 
      ;------------------------------------
      
_____DETAILS_BEGIN_____2t_ if( FileExist(_savefile_path) ){ _____SUMMARY_END_____
         ; data := ""
         ; FileRead, data, %_savefile_path%


         
         str := "" 
         
         ;-----------------------------------------------------------------------
         ; Parser's counter values:
         ;   0 when (section"[") not encountered
         ;   1 when (section"[") encountered and section lines being parsed
         ;   2 when ("]") has been encountered and finished processing section
         ;-----------------------------------------------------------------------
         
         counter_settings := 0
         counter_commands := 0
         counter_actions  := 0
         
         ;-------------------------------------------------------------
         ; For more information about Regular Expressions, see:
         ;
         ;  AHK Doc Pages:
         ;    https://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm
         ;    https://www.autohotkey.com/docs/commands/RegExReplace.htm
         ;    https://www.autohotkey.com/docs/commands/RegExMatch.htm
         ;
         ;  Online RegEx Tester + Guide:
         ;    https://regex101.com/
         ;
         ;  jeeswg's RegEx Tutorial:
         ;    https://www.autohotkey.com/boards/viewtopic.php?t=28031
         ;
         ;-------------------------------------------------------------
         
         match_lines_beginning_with_semi := "^[ \t]*[;].*"
         match_entirely_whitespace_lines := "^[ \t]*$"
         
         match_settings          := "i)^[ \t]*SETTINGS[ \t]*\[[ \t]*$"
         match_commands          := "i)^[ \t]*COMMANDS[ \t]*\[[ \t]*$"
         match_actions          := "i)^[ \t]*ACTIONS[ \t]*\[[ \t]*$"
         match_close_set_group    := "i)^[ \t]*\][ \t]*$"
         
            
         str_for_usr_output := ""
         
         FILE_HELPER.init__ar_duplicate_commands_found := []
         FILE_HELPER.init__ar_duplicate_actions_found := []
         
         ;---------------------------------------------
         ; Read _program_launcher_settings.ini, 
         ; one line at a time.
         ;
_____DETAILS_BEGIN_____3t_ Loop, Read, %_savefile_path%
         { _____SUMMARY_END_____
            is_comment := RegExMatch(A_LoopReadLine, match_lines_beginning_with_semi)
            is_empty   := RegExMatch(A_LoopReadLine, match_entirely_whitespace_lines)
            is_empty := (A_LoopReadLine=="" or is_empty)
            
            ;--------------------------------------------------
            ; (;) comment encountered
            ; or empty line (with entirely whitespace characters) encountered
            ;
            ;    (;) at beginning of line or 
            ;    any number of whitespace (anynum spaces and/or anynum tabs) then (;)
            ;
_____DETAILS_BEGIN_____4t_ if( is_comment or is_empty ){ _____SUMMARY_END_____
               continue
            } _____DETAILS_END_____
            
            ;----------------------------------------------------
            ; (settings[) encountered
            ;
            ;    (settings), case insensitive
            ;    followed by ([), spaces before, between, or after are ignored
            ;
_____DETAILS_BEGIN_____4t_ else if( RegExMatch(A_LoopReadLine, match_settings) ){ _____SUMMARY_END_____
            
_____DETAILS_BEGIN_____5t_ if( counter_settings == 0 
               and counter_actions   != 1
               and counter_commands  != 1 )
               { _____SUMMARY_END_____
                  ; Found "Settings[" && not in the middle of "Commands[" nor "Actions["
                  counter_settings := 1
                  continue
               } _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  ; either 
                  ;         section actions[  is open but not closed
                  ;         section commands[ is open but not closed
                  ;         duplicate line settings[ encountered
                  ;           when section settings[ is either already open or finished 
               } _____DETAILS_END_____
            } _____DETAILS_END_____
            ;----------------------------------------------------
            ; (commands[) encountered
            ;
            ;    (commands), case insensitive
            ;    followed by ([), spaces before, between, or after are ignored
            ;
_____DETAILS_BEGIN_____4t_ else if( RegExMatch(A_LoopReadLine, match_commands) ){ _____SUMMARY_END_____

_____DETAILS_BEGIN_____5t_ if( counter_commands == 0 
               and counter_settings  != 1
               and counter_actions   != 1 )
               { _____SUMMARY_END_____
                  ; Found "Commands[" && not in the middle of "Settings[" nor "Actions["
                  counter_commands := 1
                  continue
               } _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  ; either 
                  ;         section settings[ is open but not closed
                  ;         section actions[  is open but not closed
                  ;         duplicate line commands[ encountered
                  ;           when section commands[ is either already open or finished 
               } _____DETAILS_END_____
            } _____DETAILS_END_____
            ;----------------------------------------------------
            ; (actions[) encountered
            ;
            ;    (actions), case insensitive
            ;    followed by ([), spaces before, between, or after are ignored
            ;
_____DETAILS_BEGIN_____4t_ else if( RegExMatch(A_LoopReadLine, match_actions) ){ _____SUMMARY_END_____
            
_____DETAILS_BEGIN_____5t_ if( counter_actions == 0 
               and counter_commands != 1
               and counter_settings != 1 )
               { _____SUMMARY_END_____
                  ; Found "Actions[" && not in the middle of "Commands[" nor "Settings["
                  counter_actions := 1
                  continue
               } _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  ; either 
                  ;         section commands[  is open but not closed
                  ;         section settings[ is open but not closed
                  ;         duplicate line actions[ encountered
                  ;           when section actions[ is either already open or finished 
               } _____DETAILS_END_____
            } _____DETAILS_END_____
            
            ;----------------------------------
            ; (]) encountered while inside either
            ;
            ;    (settings[),
            ;    (commands[), or
            ;    (actions[)
            ;
_____DETAILS_BEGIN_____4t_ else if( RegExMatch(A_LoopReadLine, match_close_set_group) ){ _____SUMMARY_END_____
               
               ; ? set counter to 2 if just closed that section, 
               ; : otherwise leave unaltered
               counter_settings := (counter_settings==1) ? 2 : counter_settings
               counter_commands := (counter_commands==1) ? 2 : counter_commands
               counter_actions  := (counter_actions ==1) ? 2 : counter_actions
            } _____DETAILS_END_____
            
            ;----------------------------------
            ; (anything else) encountered while inside either
            ;
            ;    (settings[),
            ;    (commands[), or
            ;    (actions[)
            ;
_____DETAILS_BEGIN_____4t_ else{ _____SUMMARY_END_____
            
_____DETAILS_BEGIN_____5t_ if( counter_settings == 1 ){ _____SUMMARY_END_____
                  FILE_HELPER.Init_Parse_Savefile_SettingsLine( A_LoopReadLine )
               }                _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else
               if( counter_commands == 1 ){ _____SUMMARY_END_____
                  FILE_HELPER.Init_Parse_Savefile_CommandLine( A_LoopReadLine )
               } _____DETAILS_END_____
               
_____DETAILS_BEGIN_____5t_ else
               if( counter_actions == 1 ){ _____SUMMARY_END_____
                  FILE_HELPER.Init_Parse_Savefile_ActionLine( A_LoopReadLine )
               } _____DETAILS_END_____
            }  _____DETAILS_END_____
            
         } _____DETAILS_END_____
         ; msgbox %str%
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         
         
      } _____DETAILS_END_____
   return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Init_Parse_Savefile_SettingsLine( full_line_text ) { _____SUMMARY_END_____
   global _ICON_INDEX
   
      match_set_icon      := "i)^[ \t]*icon[ \t]*:[ \t]*(\d+)[ \t]*$"
      match_set_hot_pop   := "i)^[ \t]*hotkey_for_commandline_popup[ \t]*:[ \t]*((\w+[ \t]*)+)$"
      match_set_hot_quit  := "i)^[ \t]*hotkey_for_quit[ \t]*:[ \t]*((\w+[ \t]*)+)$"
   
      ; extract text, ignoring leading spaces before first non-whitepace character
      line := RegExReplace(full_line_text, "(^[ \t]*)(.*)", "$2") 
      
      int_icon     := RegExReplace(line, match_set_icon,     "$1", found_icon)
      str_hot_pop  := RegExReplace(line, match_set_hot_pop,  "$1", found_pop )
      str_hot_quit := RegExReplace(line, match_set_hot_quit, "$1", found_quit)
      
_____DETAILS_BEGIN_____2t_ if( found_icon ){ _____SUMMARY_END_____
         _ICON_INDEX := int_icon 
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if( found_pop 
      or       found_quit )
      { _____SUMMARY_END_____
      
         which_hotkey := (found_pop) ? "commandline_popup" : "quit"
         ssv_key_list := (found_pop) ? str_hot_pop : str_hot_quit 
         ; ssv similar to csv, space separated values
         
         FILE_HELPER.Init_Parse_Settings_Hotkey(which_hotkey, ssv_key_list, line)
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Parse_Savefile_CommandLine( full_line_text ) { _____SUMMARY_END_____
   global _ACTIONS
   global _COMMANDS
   
      ;-----------------------------
      ; Command syntax in savefile:
      ;
      ;    Command: decimal
      ;
      ; Example:
      ;
      ;   godot: 1
      ;-----------------------------
      
      ;---------------------------------------------------------------------
      ; Remove leading and trailing tabs around the "Command:##" phrase 
      ;
      line := RegExReplace(full_line_text, "(^[ \t]*)(.*)[ \t]*$", "$2") 
      
      match_command_colon_actionID_optionallyAlsoDisableFlag := ""
        . "i)^[ \t]*(\\BEGIN_LITERAL\\)?(.*)\:[ \t]*(QUIT|SETTINGS|[\d]+)[ \t]*(DISABLED|disable|;|x)?$"

      
      RegExMatch( line
              , match_command_colon_actionID_optionallyAlsoDisableFlag
              , matched_subpattern_ )
      
      ;--------------------------------------------------------------------
      ; `matched_subpattern_1` is just to catch the flag "\BEGIN_LITERAL\"
      ; which tells parser to include spaces after the flag
      ; as part of the Command's text.
      ;--------------------------------------------------------------------
      
      cmd          := matched_subpattern_2
      aID          := matched_subpattern_3
      disable_flag := matched_subpattern_4
      
      cmd_enabled := true
      
_____DETAILS_BEGIN_____2t_ if("DISABLE" = disable_flag
      or "Disabled" = disable_flag
      or ";" = disable_flag
      or "x" = disable_flag ){ _____SUMMARY_END_____
         cmd_enabled := false
      } _____DETAILS_END_____
      
_____DETAILS_BEGIN_____2t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
         ; add to list of things to notify user about
         
         FILE_HELPER.init__ar_duplicate_commands_found.Push( {"cmd":cmd, "line":line} )
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         _COMMANDS[cmd] := { "action_id":aID, "enabled":cmd_enabled }
      } _____DETAILS_END_____
      
      ; debug_output :=  "Command matched`n "
      ; debug_output  .= "1 [" matched_subpattern_1 "] `n "
      ; debug_output  .= "2 [" matched_subpattern_2 "] `n "
      ; debug_output  .= "3 [" matched_subpattern_3 "] `n "
      ; debug_output  .= "4 [" cmd_enabled "] `n "
      ; msgBOX % debug_output
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Parse_Savefile_ActionLine( full_line_text ) { _____SUMMARY_END_____
   global _ACTIONS
   global _COMMANDS
   
   
      ;--------------------------------------------------------------------
      ; Command syntax in savefile:
      ;
      ;    Action, Folder or File, "Path", (Optionally "arguments" if file)
      ;
      ; Example:
      ;
      ;   1, Folder, "C:/[Godot]/"
      ;--------------------------------------------------------------------
      
      ;-------------------------------------------------------
      ; Get contents of line without leading spaces and tabs.
      ;
      line := RegExReplace(full_line_text, "(^[ \t]*)(.*)[ \t]*$", "$2") 
      
                    ;-------------------------------------------
      ch_quote := """"  ; AutoHotkey Info:
                    ;-------------------------------------------
                    ; Two quotes not separated by a space ("") 
                    ; within a string resolves to a single (").
                    ; Added this var for improved readability.
                    ;-------------------------------------------
      
      
      ;-----------------------------------------------------------------------
      ; RegEx Key 
      ;-----------------------------------------------------------------------
      ; ? quantifier: match preceeding token zero or one times 
      ; * quantifier: match preceeding token zero or more times 
      ; [ \t]       : match a character from this group, space or tab 
      ; [\d]        : match any decimal digit, 0-9
      ; [^"]        : match any character which is not a quote character (")
      ; a|bc|d      : match if find one case from the|alternatives|list
      ;-----------------------------------------------------------------------
      
      match_program_launcher_behaviour_action := ""
        ; match either SETTINGS or QUIT (case insensitive from the "i)" flag)
        ; surrounded by zero or more spaces and tabs 
        ; and nothing else on the line.
        . "i)^[ \t]*(SETTINGS|QUIT)[ \t]*$"
         
      match_csv_actionID_appOrFolder_path_optionallyAlsoArg := ""
      
        ; match leading spaces and tabs ([ \t]), zero or more (*)
        . "i)^[ \t]*"     
        
        ; match ActionID, integer digits ([\d]) one or more (+)
        . "([\d]+)"       
        ;  ^  $captureGroup1
        
        ; match comma (,) after ActionID
        ; surrounded by zero or more (*) spaces and tabs ([ \t])
        . "[ \t]*,[ \t]*" 
        
        ; match ActionType (case insensitive from the "i)" flag)
        ; if this position contains one|of|the|following
        . "(Folder|Application|App)"
        ;  ^  $captureGroup2
        
        ; match comma (,) after ActionType
        ; surrounded by zero or more (*) spaces and tabs ([ \t])
        . "[ \t]*,[ \t]*" 
        
        ; match 
        ;    (") quote character,
        ;    then any number(*) of non-quote characters ([^"]), 
        ;    then (") quote character
        . ch_quote "([^" ch_quote "]*)" ch_quote  
        ;           ^  $captureGroup3
        
        ; (capture group 4)
        ; (match comma (,) after ActionPath
        ;  surrounded by zero or more (*) spaces and tabs ([ \t])
        ;  then match anything else (.*) til the end of the line)
        ; ) and find this parenthesized pattern exactly zero or one times (?) 
        . "([ \t]*,[ \t]*(.*))?$"
        ;                ^  $captureGroup5
        

      ;---------------------------------------------------------------
      ; Equivalent to assigining from this string:
      ;
      ;    match_csv_actionID_appOrFolder_path_optionallyAlsoArg := ""
      ;
      ;    . "i)^[ \t]*([\d]+)[ \t]*,[ \t]*(Folder|Application|App)[ \t]*,[ \t]*""([^""]*)""([ \t]*,[ \t]*(.*)[ \t]*)?$"
      ;
      ;---------------------------------------------------------------
      
_____DETAILS_BEGIN_____2t_ if( found_match := RegExMatch( line
              , match_csv_actionID_appOrFolder_path_optionallyAlsoArg
              , matched_subpattern_ ) ) { _____SUMMARY_END_____
      
         aID            := matched_subpattern_1
         appOrFolder    := matched_subpattern_2
         aPathUnquoted  := matched_subpattern_3
         aArg           := matched_subpattern_5
              
         appOrFolder := (   appOrFolder =  "Application"
                     or appOrFolder == "App"         ) 
                        ? "app" 
                        : appOrFolder
         appOrFolder := (   appOrFolder ==  "Folder" ) 
                        ? "folder" 
                        : appOrFolder
         
_____DETAILS_BEGIN_____3t_ if( "" != aPathUnquoted ){ _____SUMMARY_END_____
            aPathUnquoted:= FILE_HELPER.Fn_Standardize_Path_String(aPathUnquoted, appOrFolder)   
         } _____DETAILS_END_____
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else
      if( found_match := RegExMatch( line
            , match_program_launcher_behaviour_action
            , matched_subpattern_ ) ) { _____SUMMARY_END_____
      
         aID            := matched_subpattern_1
         appOrFolder    := ""
         aPathUnquoted  := ""
         aArg           := ""
         
_____DETAILS_BEGIN_____3t_ if( aID = "quit" ){ _____SUMMARY_END_____
            aID := "QUIT"
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else 
         if( aID = "settings" ){ _____SUMMARY_END_____
            aID := "SETTINGS"
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
_____DETAILS_BEGIN_____2t_ if( _ACTIONS.HasKey(aID) ){ _____SUMMARY_END_____
         ; add to list of things to notify user about
         FILE_HELPER.init__ar_duplicate_actions_found.Push( {"action_id":aID, "line":line} )
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         _ACTIONS[aID] := { ""
            .   "type" : appOrFolder
             ,  "path" : aPathUnquoted 
             ,  "arg"  : aArg          }
      } _____DETAILS_END_____
      
      ; debug_output :=  "Action matched`n "
      ; debug_output  .= "1 [" matched_subpattern_1 "] `n "
      ; debug_output  .= "2 [" matched_subpattern_2 "] `n "
      ; debug_output  .= "3 [" matched_subpattern_3 "] `n "
      ; debug_output  .= "4 [" matched_subpattern_5 "] `n "
      ; msgBOX % debug_output

      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Parse_Settings_Hotkey( hotkey_for:="commandline_popup|quit"
      , ssv_key_list:=""
      , full_line:="" )
   { _____SUMMARY_END_____
   
   global _hotkey_for_commandline_popup
   global _hotkey_for_settings
   global _hotkey_for_reload
   global _hotkey_for_quit
   
   
      ; Called exclusively from Initialize_Settings_And_Load_Saved_Commands
      ; p1: hotkey is either for quit or commandline popup
      ; p2: space sperated value list of keys to use for hotkey
      ;--------------------------------------------------------------------
      
      found_shift := ""
      found_ctrl  := ""
      found_win   := ""
      found_alt   := ""
      found_key   := ""
      error_msg__changingInvalidHotkey   := false 
      
      str_for_output__all_found := "" 
      
_____DETAILS_BEGIN_____2t_ Loop, parse, ssv_key_list, %A_Tab%%A_Space%
      { _____SUMMARY_END_____
_____DETAILS_BEGIN_____3t_ if( A_LoopField = "SHIFT")
         { _____SUMMARY_END_____
            found_shift := "+"
            
            str_for_output__all_found .= "shift "
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else if( A_LoopField = "CTRL"
         or  A_LoopField = "control" )
         { _____SUMMARY_END_____
            found_ctrl := "^"
            
            str_for_output__all_found .= "ctrl "
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else if( A_LoopField = "WIN"
         or  A_LoopField = "WINKEY" 
         or  A_LoopField = "WINDOWS" 
         or  A_LoopField = "WINDOWSKEY" )
         { _____SUMMARY_END_____
            found_win := "#"
            
            str_for_output__all_found .= "win "
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else if( A_LoopField = "ALT" )
         { _____SUMMARY_END_____
            found_alt := "!"
            
            str_for_output__all_found .= "alt "
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else if( found_key == "" )
         { _____SUMMARY_END_____
            found_key := A_LoopField
            str_for_output__all_found .= found_key " "
         } _____DETAILS_END_____
_____DETAILS_BEGIN_____3t_ else{ _____SUMMARY_END_____
            error_msg__changingInvalidHotkey := true
         }                   _____DETAILS_END_____
      } _____DETAILS_END_____
      
      ;---------------------------------------
      ; if no modifiers, exit app for safety
      ;
_____DETAILS_BEGIN_____2t_ If( found_shift == ""
      and found_ctrl  == ""
      and found_win   == ""
      and found_alt   == "" )
      { _____SUMMARY_END_____
         found_key := ""
      } _____DETAILS_END_____
      
      ;-------------------------------
      ; Hotkey successfully found
      ;  or successfully assigned by fudging away additional keys
      ;   
_____DETAILS_BEGIN_____2t_ if( found_key != "" )
      { _____SUMMARY_END_____
         hotkey_for_fn_will_be := found_shift 
                            .  found_ctrl
                            .  found_win
                            .  found_alt
                            .  found_key
         
         ;-----------------------------------------------------------------------
         ; Hotkey list had more than one key which wasn't a modifier key (+^#!).
         ;
         ; Use any modifiers listed, and the first encountered non-modifier key.
         ;
         ;  
         ;  For example,
         ;
         ;     _hotkey_for_quit: ctrl win q u i t 
         ;
         ;  would be condensed to,
         ;   
         ;     _hotkey_for_quit: ctrl win q
         ;
_____DETAILS_BEGIN_____3t_ if( error_msg__changingInvalidHotkey ){ _____SUMMARY_END_____
            str_which := ""
_____DETAILS_BEGIN_____4t_ if(hotkey_for =="commandline_popup"){ _____SUMMARY_END_____
               str_which :=  "_hotkey_for_commandline_popup"
            } _____DETAILS_END_____
_____DETAILS_BEGIN_____4t_ if(hotkey_for =="quit"){ _____SUMMARY_END_____
               str_which :=  "_hotkey_for_quit"
            } _____DETAILS_END_____
            str_for_usr_output := "_program_launcher.ahk`n`n"
            str_for_usr_output .= "--------------`nOops`n--------------`n"
            str_for_usr_output .= "Your ( " str_which " ) line`n"
            str_for_usr_output .= "in _program_launcher_settings.ini`n"
            str_for_usr_output .= "has more than one non-modifier key.`n`n"
            str_for_usr_output .= "This would take a lot more code to account for.`n`n"
            str_for_usr_output .= "Your settings file says:`n"
            str_for_usr_output .= "   " full_line "`n`n"
            str_for_usr_output .= "_program_launcher.ahk will pretend it says:`n"
            str_for_usr_output .= "   " str_which ": " str_for_output__all_found "`n`n"
            str_for_usr_output .= "This hotkey will be reassigned to:.`n`n"
            str_for_usr_output .= "   " . hotkey_for_fn_will_be . "`n`n"
            str_for_usr_output .= "---------------------`n"
            str_for_usr_output .= "Modifier keys:`n"
            str_for_usr_output .= "---------------------`n"
            str_for_usr_output .= "[+] = Shift`n"
            str_for_usr_output .= "[^] = Control`n"
            str_for_usr_output .= "[#] = Win`n"
            str_for_usr_output .= "[ ! ] = Alt`n`n"
            str_for_usr_output .= "See: https://www.autohotkey.com/docs/KeyList.htm`n`n"
            
            MSGBOX, 48, [Error] Hotkey for Popup [in _program_launcher_settings.ini], % str_for_usr_output
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      ;-------------------------------
      ; Hotkey parse failure
      ; 
      ;   ExitApp if it was the popup hotkey 
      ;   Ignore and continue with no hotkey for others
      ;   
_____DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
_____DETAILS_BEGIN_____3t_ if( hotkey_for == "commandline_popup" ){ _____SUMMARY_END_____
            str_for_usr_output := "_program_launcher.ahk`n`n"
            str_for_usr_output .= "--------------`n[ERROR]`n--------------`n"
            str_for_usr_output .= "Couldn't process the setting ""_hotkey_for_commandline_popup""`n"
            str_for_usr_output .= "in _program_launcher_settings.ini`n`n"
            str_for_usr_output .= "_program_launcher.ahk expects a line like this:`n`n"
            str_for_usr_output .= "  settings[`n"
            str_for_usr_output .= "    _hotkey_for_commandline_popup: ctrl win space`n"
            str_for_usr_output .= "  ]`n`n"
            str_for_usr_output .= "With one or more modifier keys and one non-modifier.`n"
            str_for_usr_output .= "See https://www.autohotkey.com/docs/KeyList.htm`n`n"
            str_for_usr_output .= "See details in _program_launcher.ahk or `n"
            str_for_usr_output .= "_program_launcher_settings.ini for help.`n`n"
            str_for_usr_output .= "If you can't get it to work,`n"
            str_for_usr_output .= "try removing the entire line beginning with `n`n"
            str_for_usr_output .= "   _hotkey_for_commandline_popup: (...)`n`n"
            str_for_usr_output .= "and the default setting `n`n"
            str_for_usr_output .= "   Control Win Space`n`n"
            str_for_usr_output .= "will be used.`n`n"
            str_for_usr_output .= "Program will now exit, sorry.`n"
            MSGBOX, 16, [ FATAL ERROR ], % str_for_usr_output
            
            ExitApp
         } _____DETAILS_END_____
         
_____DETAILS_BEGIN_____3t_ if( hotkey_for == "quit" ){ _____SUMMARY_END_____
            str_for_usr_output := "_program_launcher.ahk`n`n"
            str_for_usr_output .= "--------------`nOops`n--------------`n"
            str_for_usr_output .= "Couldn't process the setting ""_hotkey_for_quit""`n"
            str_for_usr_output .= "in _program_launcher_settings.ini`n`n"
            str_for_usr_output .= "_program_launcher.ahk expects a line like this:`n`n"
            str_for_usr_output .= "  settings[`n"
            str_for_usr_output .= "    _hotkey_for_quit: ctrl win q`n"
            str_for_usr_output .= "  ]`n`n"
            str_for_usr_output .= "With one or more modifier keys and one non-modifier.`n"
            str_for_usr_output .= "See https://www.autohotkey.com/docs/KeyList.htm`n`n"
            str_for_usr_output .= "See details in _program_launcher.ahk or `n"
            str_for_usr_output .= "_program_launcher_settings.ini for help.`n`n"
            str_for_usr_output .= "If you can't get _program_launcher.ahk to run`n"
            str_for_usr_output .= "and you don't care about having a Quit hotkey,`n"
            str_for_usr_output .= "try removing the entire line beginning with: `n`n"
            str_for_usr_output .= "   _hotkey_for_commandline_popup: (...)`n`n"
            str_for_usr_output .= "Alternatively this line should work:`n`n"
            str_for_usr_output .= "   _hotkey_for_commandline_popup: ctrl win q`n`n"
            str_for_usr_output .= "`n`n"
            str_for_usr_output .= "Program will continue,`n"
            str_for_usr_output .= "with no hotkey assigned to Quit.`n`n"
            str_for_usr_output .= "To Exit:`n"
            str_for_usr_output .= "Right-click the Notification Tray icon`n"
            str_for_usr_output .= "and choose quit.`n`n"
            MSGBOX, 48, % "[X] Couldn't read line _hotkey_for_quit in settings file", % str_for_usr_output
            
            ExitApp
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      
      
      ;-------------------------------
      ; Hotkey assignment, 
      ; and save var for use elsewhere.
      ;   
_____DETAILS_BEGIN_____2t_ if( hotkey_for == "commandline_popup" ){ _____SUMMARY_END_____
         _hotkey_for_commandline_popup := hotkey_for_fn_will_be
         Hotkey, %_hotkey_for_commandline_popup%, ProgramLauncherPopupCommand
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ if( hotkey_for == "quit" ){ _____SUMMARY_END_____
         _hotkey_for_quit := hotkey_for_fn_will_be
         Hotkey, %_hotkey_for_quit%, ProgramLauncherQuit

   ; msgBOX hotkey for quit %_hotkey_for_quit%
      } _____DETAILS_END_____

      
      
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Init_Validate_and_Prompt_User_if_Errors() { _____SUMMARY_END_____
   global 
      
      ar_commands_without_valid_actions := []
      
      ;-------------------------------------------------------------
      ; If user hasn't defined "SETTINGS" or "QUIT" as an action, 
      ; that's okay, add them manually here to make both available.
      ;
      ; Do this before checking Commands for valid actions.
      ;
_____DETAILS_BEGIN_____2t_ if( !_ACTIONS.HasKey("SETTINGS") ){ _____SUMMARY_END_____
         _ACTIONS["SETTINGS"] := { ""
            .   "type" : ""
             ,  "path" : "" 
             ,  "arg"  : ""     }     
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ if( !_ACTIONS.HasKey("QUIT") ){ _____SUMMARY_END_____
         _ACTIONS["QUIT"] := { ""
            .   "type" : ""
             ,  "path" : "" 
             ,  "arg"  : "" }    
      } _____DETAILS_END_____
      
      ;----------------------------------------------------------------
      ; Now that all the Commands have been read from the savefile.ini 
      ; if any Command links to a non-existant Action 
      ; remove the Command and notify the user.
      ;
_____DETAILS_BEGIN_____2t_ for cmd, cmd_dat in _COMMANDS{ _____SUMMARY_END_____
         
         aID := cmd_dat["action_id"]
         
_____DETAILS_BEGIN_____3t_ if( !_ACTIONS.HasKey(aID) ){ _____SUMMARY_END_____
            ar_commands_without_valid_actions.Push(cmd)
            _COMMANDS.Delete(cmd)
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      
      ;--------------------------------------------------------------------
      ; If any Command phrases were encountered more than once 
      ; parser ignored the duplicates above, and made a list of them.
      ; 
      ; Inform the user which entry was imported, and which were ignored.
      ;
_____DETAILS_BEGIN_____2t_ if( 0 < FILE_HELPER.init__ar_duplicate_commands_found.Count() ){ _____SUMMARY_END_____

         ar_valid_cmds    := {}     ; only used here temporarily
         str_valid_cmds   := ""
         str_invalid_cmds := ""
         
         ;-----------------------------------------------------------------------
         ; Get a list of all valid Commands (which also have ignored duplicates)
         ;
_____DETAILS_BEGIN_____3t_ for i, dupe in FILE_HELPER.init__ar_duplicate_commands_found { _____SUMMARY_END_____
            ; FILE_HELPER.init__ar_duplicate_commands_found.Push( {"cmd":cmd, "line":line} )
            
            dupeCmd  := dupe["cmd"]
            dupeLine := dupe["line"]
_____DETAILS_BEGIN_____4t_ if( !ar_valid_cmds.HasKey(dupeCmd) ){ _____SUMMARY_END_____
               
               str_valid_cmds  .= "`t"
               str_valid_cmds  .= dupeCmd ": " 
               str_valid_cmds  .= _COMMANDS[dupeCmd]["action_id"] " "
_____DETAILS_BEGIN_____5t_ if( false == _COMMANDS[dupeCmd]["enabled"] ){ _____SUMMARY_END_____
                  str_valid_cmds  .= "DISABLED"
               } _____DETAILS_END_____
               str_valid_cmds  .= "`n"
               ar_valid_cmds[ dupeCmd ] := true
            } _____DETAILS_END_____
         } _____DETAILS_END_____
         
         
         ;-------------------------------------------------
         ; Get a list of all the ignored invalid Commands 
         ;
_____DETAILS_BEGIN_____3t_ for i, dupe in FILE_HELPER.init__ar_duplicate_commands_found { _____SUMMARY_END_____
            str_invalid_cmds  .= "`t" dupe["line"] "`n"
         } _____DETAILS_END_____
         
         ;----------------------------------;
         ;          Inform user             ;
         ;                                  ;
         msg_for_usr :=  "_program_launcher.ahk`n`n"
         msg_for_usr  .= "--------------`nOops`n--------------`n`n"
         msg_for_usr  .= "Duplicate Commands were found.`n"
         msg_for_usr  .= "The first time a Command is found, it's kept. `n`n"
         msg_for_usr  .= "The following Commands were loaded:`n`n"
         msg_for_usr  .= str_valid_cmds
         msg_for_usr  .= "`nThe following duplicate lines were ignored:`n`n"
         msg_for_usr  .= str_invalid_cmds
         
         Msgbox, 48, Error in Settings.ini, %msg_for_usr%
      
      } _____DETAILS_END_____
      
      ; [~]  TODO 
      ;
      ; Some Actions have identical configurations.
      ;
      ; Would you like to remove the duplicates?
      ;
      ; (Any Command which references a duplicate Action
      ;  will be rewired to the resulting unique Action.)

_____DETAILS_BEGIN_____2t_ if( 0 < FILE_HELPER.init__ar_duplicate_actions_found.Count() ){ _____SUMMARY_END_____

         ar_valid_acts    := {}
         str_valid_acts   := ""
         str_invalid_acts := ""
         
         ch_quote := """"
         
_____DETAILS_BEGIN_____3t_ for i, dupe in FILE_HELPER.init__ar_duplicate_actions_found { _____SUMMARY_END_____
         
            ; FILE_HELPER.init__ar_duplicate_actions_found.Push( {"action_id":aID, "line":line} )
            
            dupeAct  := dupe["action_id"]
            dupeLine := dupe["line"]
            
_____DETAILS_BEGIN_____4t_ if( !ar_valid_acts.HasKey(dupeAct) ){ _____SUMMARY_END_____
               
               str_valid_acts  .= "`t"
               str_valid_acts  .= dupeAct ", " 
               str_valid_acts  .= _ACTIONS[dupeAct]["type"] ", "
               str_valid_acts  .= ch_quote
               str_valid_acts  .= _ACTIONS[dupeAct]["path"]
               str_valid_acts  .= ch_quote
_____DETAILS_BEGIN_____5t_ if( "" != _ACTIONS[dupeAct]["arg"] ){ _____SUMMARY_END_____
                  str_valid_acts  .= ", "
                  str_valid_acts  .= _ACTIONS[dupeAct]["arg"]
               } _____DETAILS_END_____
               str_valid_acts  .= "`n"
               ar_valid_acts[ dupeAct ] := true
            } _____DETAILS_END_____
         } _____DETAILS_END_____
         
         ar_valid_acts := ""
         
_____DETAILS_BEGIN_____3t_ for i, dupe in FILE_HELPER.init__ar_duplicate_actions_found { _____SUMMARY_END_____
            str_invalid_acts  .= "`t" dupe["line"] "`n"
         } _____DETAILS_END_____
         
         
         msg_for_usr :=  "_program_launcher.ahk`n`n"
         msg_for_usr  .= "--------------`nOops`n--------------`n`n"
         msg_for_usr  .= "Duplicate Actions were found.`n"
         msg_for_usr  .= "The first time an Actions is found, it's kept. `n`n"
         msg_for_usr  .= "The following Actions were loaded:`n`n"
         msg_for_usr  .= str_valid_acts
         msg_for_usr  .= "`nThe following duplicate lines were ignored:`n`n"
         msg_for_usr  .= str_invalid_acts
         
         Msgbox, 48, Error in Settings.ini, %msg_for_usr%
      
      } _____DETAILS_END_____
      
      
      msg_for_usr :=  ""
      msg_for_usr  .= ""
      
      msg_for_usr :=  ""
      msg_for_usr  .= ""
      
      return
   
   } _____DETAILS_END_____






_____DETAILS_BEGIN_____1t_ Change_Savefile__Enable_Command( command_to_enable ) { _____SUMMARY_END_____
      
      ;-------------------------------------------------------------------
      ; Syntax Reference
      ;-------------------------------------------------------------------
      ; class:    FILE_HELPER
      ; function: Change_Savefile( p1,p2,p3,p4 )
      ;
      ; p1:  mode                      action|command
      ; p2:  purpose                   add|delete|edit|enable|disable
      ; p2:  action_id__or__cmd        new Action's ID 
      ; p2:  cmd_name_before_rename    only needed for edit Command popups
      ;-------------------------------------------------------------------
      
      p1 := "command"
      p2 := "enable"
      p3 := command_to_enable
      p4 := ""
      FILE_HELPER.Change_Savefile( p1,p2,p3,p4 )
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Change_Savefile__Disable_Command( command_to_disable ) { _____SUMMARY_END_____
      
      ;-------------------------------------------------------------------
      ; Syntax Reference
      ;-------------------------------------------------------------------
      ; class:    FILE_HELPER
      ; function: Change_Savefile( p1,p2,p3,p4 )
      ;
      ; p1:  mode                      action|command
      ; p2:  purpose                   add|delete|edit|enable|disable
      ; p2:  action_id__or__cmd        new Action's ID 
      ; p2:  cmd_name_before_rename    only needed for edit Command popups
      ;-------------------------------------------------------------------
      
      p1 := "command"
      p2 := "disable"
      p3 := command_to_disable
      p4 := ""
      FILE_HELPER.Change_Savefile( p1,p2,p3,p4 )
      
      return
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Change_Savefile( mode:="action|command|setting"
      , purpose:="add|delete|edit|enable|disable"     ; only for Commands:  enable|disable
      , action_id__or__cmd :="passed from popup"      ; only for Commands and Actions
      , cmd_name_before_rename := ""                  ; only for Commands
      , setting_to_change := "" )                     ; only for Settings:  {"setting_name":"", "new_value":""}
   { _____SUMMARY_END_____
   global _savefile_path
   global _ACTIONS
   global _COMMANDS
      
      
_____DETAILS_BEGIN_____2t_ if( !FileExist(_savefile_path) ){ _____SUMMARY_END_____
         ; savefile deleted or moved or renamed since _Program_Launcher.ahk was run.
         MSGBOX, 16, [ SUPER ERROR ], Savefile not found where app last found it.`nOops. Need to implement stuff here. [~]
         return 
      }  _____DETAILS_END_____
      
      
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         PURPOSE:
            
            ADD
            
               This is the only function which does not need 
               to match a pre-existing line in the savefile.
               For add, we just need to find the end of 
               the section (]) of either (Actions[) or (Commands[)
               then add the new line just before the (]).
                  Thus:
                  The add functionality needs to watch for 
                  (a) beginning of the relavant Section ([)
                  (b) ending    of the relavant Section (])
            
            DELETE
            EDIT
            ENABLE  (applicable only to Commands)
            DISABLE (applicable only to Commands)
            
               Each of these functions needs to find the
               specific line corresponding to a pre-existing
               Command or Action in the Savefile. 
               They all need to watch for: 
                  (a) beginning of the relavant Section ([)
                  (b) the matching pre-existing entry in the Savefile 
               Then each diverges in modification from there.
            
         ===============================================
         Steps: 
         ===============================================
         
         (1) Ensure Savefile still exists.
         
         (2) Read Savefile into program memory 
         
            (2.1) Depending on parameter mode, look for the section:
               'actions['   or
               'commands[' 
               
               (2.2) Look for the matching action_id or cmd
               
               (2.3) If parameter purpose is 
               
                  (a) "edit",  then modify line 
                  (b) "delete", then remove line 
         
         (3)   Overwrite Savefile with new data. 
               
         Done.
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      match_target_section            := ""
      match_line_to_compare           := ""
      match_line__use_capture_group   := ""
      
      
_____DETAILS_BEGIN_____2t_ if( "action" == mode ){ _____SUMMARY_END_____
         match_target_section := "i)^[ \t]*ACTIONS[ \t]*\[[ \t]*$"
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if("command" == mode){ _____SUMMARY_END_____
         match_target_section := "i)^[ \t]*COMMANDS[ \t]*\[[ \t]*$"
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if("setting" == mode){ _____SUMMARY_END_____
         match_target_section := "i)^[ \t]*SETTINGS[ \t]*\[[ \t]*$"
      } _____DETAILS_END_____
      
      match_lines_beginning_with_semi := "^[ \t]*[;].*"
      match_entirely_whitespace_lines := "^[ \t]*$"
      
      match_close_section    := "i)^[ \t]*\][ \t]*$"
      counter_for_target_section := 0
      
      
      revised_file_data := ""
      
      is_insertion_point_changed_yet := false
      
      ;---------------------------------------------
      ; Read _program_launcher_settings.ini, 
      ; one line at a time.
      ;
_____DETAILS_BEGIN_____2t_ Loop, Read, %_savefile_path%
      { _____SUMMARY_END_____
      
         ;---------------------------------------------------------------------
         ; If we've already modified the Action or Command's target line
         ; and added the new data to the var revised_file_data,
         ; then skip the logic and copy the rest of the file to this var 
         ;
_____DETAILS_BEGIN_____3t_ if( true == is_insertion_point_changed_yet ){ _____SUMMARY_END_____
         
            revised_file_data .= A_LoopReadLine "`n"
            continue
            
         } _____DETAILS_END_____
         
         is_comment := RegExMatch(A_LoopReadLine, match_lines_beginning_with_semi)
         is_empty   := RegExMatch(A_LoopReadLine, match_entirely_whitespace_lines)
         is_empty   := (A_LoopReadLine=="" or is_empty)
         
_____DETAILS_BEGIN_____3t_ if( is_comment or is_empty ){ _____SUMMARY_END_____
            revised_file_data .= A_LoopReadLine "`n"
            continue
         }  _____DETAILS_END_____
         
         ;----------------------------------------------------
         ; NECESSARY FOR PURPOSES: 
         ;
         ;    All.
         ;
         ;----------------------------------------------------
         ;
         ; Found  (actions[) 
         ; or     (commands[) 
         ; or     (settings[) 
         ;
         ; (insertion's target section encountered)
         ;
_____DETAILS_BEGIN_____3t_ if( RegExMatch(A_LoopReadLine, match_target_section) ){ _____SUMMARY_END_____

               counter_for_target_section := 1
               
         } _____DETAILS_END_____
         ;----------------------------------------------------
         ; NECESSARY FOR PURPOSES: 
         ;
         ;    "add"  (any mode)
         ;
         ;----------------------------------------------------
         ;
         ; (]) encountered while inside either
         ;
         ;    (actions[),  or
         ;    (commands[), or
         ;    (settings[)
         ;
_____DETAILS_BEGIN_____3t_ else if( RegExMatch(A_LoopReadLine, match_close_section) ){ _____SUMMARY_END_____
            
_____DETAILS_BEGIN_____4t_ if( 1 == counter_for_target_section){ _____SUMMARY_END_____
               
_____DETAILS_BEGIN_____5t_ if( "add" == purpose ){ _____SUMMARY_END_____
                  
                  p1 := mode 
                  p2 := action_id__or__cmd
                  new_entry_to_insert := FILE_HELPER.Change_Helper__TargetLine__Create(p1, p2)
                  
                  revised_file_data .= new_entry_to_insert
                  revised_file_data .= "`n"
                  revised_file_data .= "]"
                  revised_file_data .= "`n"
                  
                  ;====================================================
                  ; Turn on flag to speed up the rest of the file loop 
                  ;====================================================
                  
                  is_insertion_point_changed_yet := true
                  
                  continue 
               } _____DETAILS_END_____
               ;----------------------------------------------------
               ; When editing a setting, 
               ; if it isn't present in the Savefile yet, then:
               ; 
               ;    - Add it at the end of the (settings[) section.
               ;    - Close the section (])
               ;    - Finish collecting the rest of the file into 
               ;       revised_file_data, and write the file.
               ;
_____DETAILS_BEGIN_____5t_ else
               if( "setting" == mode ){ _____SUMMARY_END_____
                  
                  p1 := mode 
                  p2 := setting_to_change ; {"setting_name":__, "new_value":__}
                  
                  edited_line := FILE_HELPER.Change_Helper__TargetLine__Create( p1, p2 )
                  
                  revised_file_data .= edited_line
                  revised_file_data .= "`n"
                  revised_file_data .= "]"
                  revised_file_data .= "`n"
                  
                  ;====================================================
                  ; Turn on flag to speed up the rest of the file loop 
                  ;====================================================
                  
                  is_insertion_point_changed_yet := true
                  
                  continue 
               } _____DETAILS_END_____
               
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
         ;-------------------------------------------------------
         ; NECESSARY FOR PURPOSES: 
         ;
         ;    "delete"  (any mode)
         ;    "edit"    (any mode)
         ;    "enable"    (applicable only to Commands) 
         ;    "disable"   (applicable only to Commands) 
         ;
         ;-------------------------------------------------------
         ;
         ; Found line containing Action or Command 
         ; while inside 
         ;
         ;    (actions[)    or 
         ;    (commands[)   or
         ;    (settings[) 
         ;
_____DETAILS_BEGIN_____3t_ else
         if( counter_for_target_section == 1 ){ _____SUMMARY_END_____
            
            p1 := mode
            p2 := A_LoopReadLine
            p3 := action_id__or__cmd
            
_____DETAILS_BEGIN_____4t_ if( "command" == mode 
            and "edit"    == purpose ){ _____SUMMARY_END_____
            
               ;-----------------------------------------------------------
               ; If the Command's text was renamed, 
               ; we need to look for the previous version in the Savefile.
               ;
               p3 := cmd_name_before_rename
               
            } _____DETAILS_END_____
_____DETAILS_BEGIN_____4t_ else
            if( "setting" == mode ){ _____SUMMARY_END_____
            
               ;-----------------------------------------------------------
               ; If the Command's text was renamed, 
               ; we need to look for the previous version in the Savefile.
               ;
               p3 := setting_to_change["setting_name"]
               
            } _____DETAILS_END_____
            
            found_it := FILE_HELPER.Change_Helper__IsCurrentLineTheTargetLine( p1,p2,p3 )
            
_____DETAILS_BEGIN_____4t_ if( found_it ){ _____SUMMARY_END_____
               
_____DETAILS_BEGIN_____5t_ if("delete" == purpose){ _____SUMMARY_END_____
               
                  ;======================================================
                  ; Delete by omission, 
                  ; skip adding to revised_file_data this loop iteration.
                  ;======================================================
                  
                  
                  ;====================================================
                  ; Turn on flag to speed up the rest of the file loop 
                  ;====================================================
                  
                  is_insertion_point_changed_yet := true 
                  
                  continue
                  
               } _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else if("edit" == purpose){ _____SUMMARY_END_____
                  
                  ;============================================================
                  ; Generate a new line for this entry in the Savefile 
                  ; based on current data in _ACTIONS and _COMMANDS.
                  ;
                  ; Note about editing a Command here:
                  ;   We already ensured that this is the correct line above. 
                  ;   So we don't need to pass in the old name for examination,
                  ;   only the new command text to insert in the Savefile.
                  ;============================================================
                  
                  p1 := mode 
                  p2 := action_id__or__cmd
_____DETAILS_BEGIN_____6t_ if("setting" == mode){ _____SUMMARY_END_____
                     p2 := setting_to_change ; {"setting_name":__, "new_value":__}
                  } _____DETAILS_END_____
                  edited_line := FILE_HELPER.Change_Helper__TargetLine__Create( p1, p2 )
                  
                  revised_file_data .= edited_line
                  revised_file_data .= "`n"
                  
                  ;====================================================
                  ; Turn on flag to speed up the rest of the file loop 
                  ;====================================================
                  
                  is_insertion_point_changed_yet := true
                  
                  continue 
                  
               } _____DETAILS_END_____
_____DETAILS_BEGIN_____5t_ else if( "command" == mode
                        and (   "enable"  == purpose
                             or "disable" == purpose )  )
               { _____SUMMARY_END_____
                  
                  ;=================================================================
                  ; Generate an edited line for this Command's entry in the Savefile 
                  ; to store its current enabled or disabled state, by:
                  ;
                  ;    either appending a trailing "DISABLED" string
                  ;    or by removing the trailing "DISABLED" string.
                  ;=================================================================
                  
                  p1 := purpose 
                  p2 := A_LoopReadLine
                  edited_line := FILE_HELPER.Change_Helper__TargetLine__ToggleCommand( p1, p2 )
                  
                  revised_file_data .= edited_line
                  revised_file_data .= "`n"
                  
                  ;====================================================
                  ; Turn on flag to speed up the rest of the file loop 
                  ;====================================================
                  
                  is_insertion_point_changed_yet := true
                  
                  continue
               
               } _____DETAILS_END_____
               
            } ; if found (target Action ID) or (target Command) _____DETAILS_END_____
            
         } ; if loop line is within Section "Actions[" or "Commands[" _____DETAILS_END_____
         
         
         ;----------------------------------------------------------
         ; Didn't find the target Action or Command to modify yet.
         ;
         ; For everything else, 
         ; copy current line to our file data var, 
         ; continue to next line.
         ;
         revised_file_data .= A_LoopReadLine "`n"
         
         
      } ; end of file loop _____DETAILS_END_____
      
      ; msgbox newfile`n%revised_file_data%
_____DETAILS_BEGIN_____2t_ if( "" != revised_file_data ){ _____SUMMARY_END_____
         
         FileDelete, %_savefile_path%
         FileAppend, %revised_file_data%, %_savefile_path%
         
      } _____DETAILS_END_____
         
      
      
      
      
      
      return is_insertion_point_changed_yet
   } ; Change_Savefile() _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Change_Helper__IsCurrentLineTheTargetLine( mode, current_line, id_or_cmd_or_setting ) { _____SUMMARY_END_____
   ; No globals needed.
   ;
   ; This function only exists outside the file loop 
   ; to improve readability & organize complexity 
   ; (and possibly to benefit anyone new to AutoHotkey or programming).
   ;---------------------------------------------------------------------------
   
      is_this_the_destination := false 
      
_____DETAILS_BEGIN_____2t_ if( "action" == mode ){ _____SUMMARY_END_____
         
         ;------------------------------------------------
         ; Each Action entry in the Savefile 
         ; has a unique ID at the beginning of the line, 
         ; followed by a (,) comma.
         ;
         ; This function receieved a parameter holding 
         ; the Action ID to alter in the savefile.
         ;
         ; So this leading sequence of one or more digits
         ;
         ;     ([\d]+)
         ;
         ; is all we need to ensure the target line 
         ; matches the given Action ID parameter.
         ;
         ; The leading "U)" portion is the "Ungreedy" flag, 
         ; telling the regular expression to look 
         ; for the smallest substring which satisfies our 
         ; match string. 
         ;
         ; Without this "Ungreedy" flag, 
         ; a more verbose regular expression match string 
         ; is required. 
         ;
         ; Enclosing the one or more digits [\d]+ 
         ; in parenthesis signifies that we want 
         ; everything between the open and close parenthesis
         ; to count as a "Match Group".
         ;
         ; A successful call to AutoHotkey's RegExMatch() 
         ; creates a variable for each match group.
         ; In this case, we only have one match group
         ; (containing the Action ID).
         ;
         ; The output variable MatchGroup 
         ; contains our Action ID plus the trailing comma.
         ;
         ; The output variable MatchGroup1 
         ; contains our Action ID by itself.
         ;------------------------------------------------
         
         match_unique_token := "" 
         . "U)^[ \t]*([\d]+)[ \t]*,"
         
         ;~ capture_group_for_unique_token := "$1"
         
         
         unique_token := ""
         
         RegExMatch( current_line
                   , match_unique_token
                   , MatchGroup )
         
         unique_token := MatchGroup1
                                 
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if("command" == mode){ _____SUMMARY_END_____
         
         ;------------------------------------------------
         ; Each Command entry in the Savefile 
         ; has a unique text at the beginning of the line, 
         ; followed by a (:) colon.
         ;
         ; If this Command has just been renamed, 
         ; we first need to find its old entry 
         ; with its old name in the Savefile.
         ;
         ; This function receieved a parameter holding 
         ; the Command's last-saved unique text.
         ;
         ; Unlike the above regular expression match string
         ; to find the Action ID, Commands can have a wide 
         ; variety of leading text. The full Command 
         ; match string is used here. 
         ;
         ; The second capture group will contain each 
         ; Command's text, and will be identical to our 
         ; parameter when the proper line is found. 
         ;
         ;[~] TODO
         ;------------------------------------------------
         
         match_unique_token := "" 
         . "i)^[ \t]*(\\BEGIN_LITERAL\\)?(.*):[ \t]*(QUIT|SETTINGS|[\d]+)[ \t]*(DISABLED|disable|;|x)?$"
         
         capture_group_for_unique_token := "$2"
         
         unique_token := RegExReplace(  current_line
                                         , match_unique_token
                                         , capture_group_for_unique_token )
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if("setting" == mode){ _____SUMMARY_END_____
         
         match_unique_token := "" 
         . "i)^[ \t]*(" id_or_cmd_or_setting ")[ \t]*:[ \t]*(\d+)[ \t]*$"
         
         capture_group_for_unique_token := "$1"
         
         unique_token := RegExReplace(  current_line
                                         , match_unique_token
                                         , capture_group_for_unique_token )
      } _____DETAILS_END_____
      
      
_____DETAILS_BEGIN_____2t_ if( unique_token == id_or_cmd_or_setting ){ _____SUMMARY_END_____
         is_this_the_destination := true 
      } _____DETAILS_END_____
      
      return is_this_the_destination
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Change_Helper__TargetLine__Create( mode, id_or_cmd_or_setting ) { _____SUMMARY_END_____
   global _ACTIONS
   global _COMMANDS
      new_savefile_line_to_insert := ""
   
      ;=======================================
      ; Create Line to Insert into Savefile
      ;=======================================
      
_____DETAILS_BEGIN_____2t_ if( "action" == mode ){ _____SUMMARY_END_____
      
         action_id := id_or_cmd_or_setting
         
         ActionID     := ""
         FolderOrApp  := ""
         ActionPath   := ""
         ActionArg    := ""
         
         quote_character := """"
         
         ; Unique ID #
         ActionID :=  action_id
         ActionID  .= ", "
         
         ; "Folder" 
_____DETAILS_BEGIN_____3t_ if( "folder" == _ACTIONS[action_id]["type"] ){ _____SUMMARY_END_____
         
            FolderOrApp :=  "Folder"
            FolderOrApp  .= ", "
            
         } _____DETAILS_END_____
         ; or "App"
_____DETAILS_BEGIN_____3t_ else if( "app" == _ACTIONS[action_id]["type"] ){ _____SUMMARY_END_____
         
            FolderOrApp :=  "App"
            FolderOrApp  .= ",    "
            
            ; (Optional) Arguments for App
_____DETAILS_BEGIN_____4t_ if( "" != _ACTIONS[action_id]["arg"] ){ _____SUMMARY_END_____
            
               ActionArg :=  ", "
               ActionArg  .= _ACTIONS[action_id]["arg"]
               
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
         
         ; Quoted Path
         ActionPath :=  quote_character
         ActionPath  .= _ACTIONS[action_id]["path"]
         ActionPath  .= quote_character
         
         
         new_savefile_line_to_insert := "" 
            . "`t"                          ; Add a leading tab each time for visual consistency.
            . ActionID                       ; Add Action ID         followed by a comma (,) and spaces.
            . FolderOrApp                   ; Add "Folder" or "App" followed by a comma (,) and spaces.
            . ActionPath                    ; Add Action's Path, surrounded by double-quote (") characters.
            . ActionArg                     ; If present add a comma and one space (, )
                                            ;  and custom arguments to call when App is run.
            
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else
      if( "command" == mode ){ _____SUMMARY_END_____
      
         cmd := id_or_cmd_or_setting
         
         action_id := _COMMANDS[cmd]["action_id"]
         
         begin_literal_flag := "" ; not needed if cmd doesn't begin with spaces
         
_____DETAILS_BEGIN_____3t_ if( RegExMatch(cmd, "^[ \t]+.*") ){ _____SUMMARY_END_____
            begin_literal_flag := "\BEGIN_LITERAL\"
         } _____DETAILS_END_____
         
         cmd_len := StrLen( cmd )
         
         padding := FILE_HELPER.Fn_Calculate_Number_of_Tabs_Between_CommandColon_and_ActionID( cmd_len )
         ; padding := FILE_HELPER.Fn_Calculate_Number_of_Spaces_Between_CommandColon_and_ActionID( cmd_len )
         
         new_savefile_line_to_insert := "" 
            . "`t"                          ; Add a leading tab each time for visual consistency.
            . begin_literal_flag            ; Only present if user's Command text begins with spaces.
            . cmd                           ; Add User's Command text.
            . ":" padding                   ; Add colon (:) + padding for visual consistency (configured for Notepad++).
            . action_id                       ; Add Action ID the Command's text triggers when typed in Program Launcher.
         
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else
      if( "setting" == mode ){ _____SUMMARY_END_____
         setting_name := id_or_cmd_or_setting["setting_name"]
         new_value := id_or_cmd_or_setting["new_value"]
         
         
         new_savefile_line_to_insert := "" 
            . "`t"                          ; Add a leading tab each time for visual consistency.
            . setting_name                  ; Add setting name
            . ": "                          ; Add a colon and a space (: )
            . new_value                     ; Add value for setting
            
      } _____DETAILS_END_____
      
      
      return new_savefile_line_to_insert
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Change_Helper__TargetLine__ToggleCommand( purpose, target_line ) { _____SUMMARY_END_____

      new_savefile_line_to_insert := ""
   
      match_command_colon_actionID_optionallyAlsoDisableFlag := ""
        . "i)^([ \t]*(\\BEGIN_LITERAL\\)?(.*)\:[ \t]*(QUIT|SETTINGS|[\d]+))[ \t]*(DISABLED|disable|;|x)?$"
      
      text_without_disableFlag := RegExReplace( target_line
         , match_command_colon_actionID_optionallyAlsoDisableFlag
         , "$1" )
         
_____DETAILS_BEGIN_____2t_ if( "disable" == purpose ){ _____SUMMARY_END_____

         ;=====================================================
         ; Append "DISABLED" to Command's line 
         ; store to our file data var to write after this loop 
         ;=====================================================
         
         new_savefile_line_to_insert := text_without_disableFlag "`t`t" "DISABLED"

         ; msgBOX %   target_line "`t`t" "DISABLED"
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else 
      if( "enable" == purpose ){ _____SUMMARY_END_____
         
            
         new_savefile_line_to_insert := text_without_disableFlag
         
         ; msgBOX %   text_without_disableFlag
      } _____DETAILS_END_____
      
      return new_savefile_line_to_insert
   } _____DETAILS_END_____
   

_____DETAILS_BEGIN_____1t_ Fn_Standardize_Path_String(path, path_type) { _____SUMMARY_END_____
    
      ;======================================================
      ; format Path string to maintain visual consistency
      ;======================================================
      
      ;-----------------------------------------------------
      ; format path to remove leading & trailing whitespace
      ;-----------------------------------------------------
      formatted_path := Trim(path)
      
      ;------------------------------------------------------
      ; convert "/"s to "\"s 
      ;  because Windows is weird, and this is conventional.
      ;------------------------------------------------------
      formatted_path := RegExReplace(formatted_path,"[/]","\")
      
      ;------------------------------------------------
      ; append trailing "\" to directory if not there 
      ;------------------------------------------------
_____DETAILS_BEGIN_____2t_ if( "folder" = path_type ){ _____SUMMARY_END_____
         
_____DETAILS_BEGIN_____3t_ if( RegExMatch(formatted_path, "[^\\]$") ){ _____SUMMARY_END_____
            formatted_path := formatted_path . "\"
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      return formatted_path
   }    _____DETAILS_END_____


   
_____DETAILS_BEGIN_____1t_ Fn_Calculate_Number_of_Spaces_Between_CommandColon_and_ActionID( cmd_length ) { _____SUMMARY_END_____
   
      space_string := ""
      
      ; Add 1 to the length to account for the colon (:) before tabs begin
      cmd_length := cmd_length + 1 
      
_____DETAILS_BEGIN_____2t_ if( 28 <= cmd_length ){ _____SUMMARY_END_____
         space_string := " "
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if( 2 <= cmd_length ){ _____SUMMARY_END_____
      
         empty_space_to_fill := 28 - cmd_length
         
_____DETAILS_BEGIN_____3t_ Loop, %empty_space_to_fill%
         { _____SUMMARY_END_____
            space_string .= " "
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      
      return space_string
   } _____DETAILS_END_____
   
   
   ;~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
   ; [~] TODO
   ;
   ; Add a setting where if changed, 
   ; on launch Program Launcher will reformat savefile 
   ; for either notepad.exe (which uses 16 spaces for 1 tab)
   ; or for standard 4 spaces for 1 tab 
   ; or for standard 3 spaces for 1 tab 
   ;
   ; to allow for smoother experience in user's text editor of choice. 
   ;
   ;~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
   
_____DETAILS_BEGIN_____1t_ Fn_Calculate_Number_of_Tabs_Between_CommandColon_and_ActionID( cmd_length ) { _____SUMMARY_END_____
   
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         number of characters           number of tabs 
         including                      to use 
         command + colon (:)
         ______________________   ___________________________
         
         a:                            # (some action id), 7 tabs
         bbbbbbbbbb:                    # (some action id), 5 tabs 
         
         2:                          7
         3.:                         7         2 ch or less, 7 tabs
         4..:                        6
         5...:                       6
         6....:                      6
         7.....:                     6        6 ch or less, 6 tabs
         8......:                    5
         9.......:                   5
         10.......:                  5
         11........:                 5       10 ch or less, 5 tabs
         12.........:                4
         13..........:               4
         14...........:              4
         15............:             4       14 ch or less, 4 tabs
         16.............:            3
         17..............:           3
         18...............:          3
         19................:         3       18 ch or less, 3 tabs
         20.................:        2
         21..................:       2
         22...................:      2
         23....................:     2       22 ch or less, 2 tabs
         24.....................:    1
         25......................:   1
         26.......................:  1
         27........................: 1
         28.........................:1
         
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      format_for_notepadPlusPlus := true 
      format_for_notepadDotExe   := false
      
      tab_string := ""
      
      ; Add 1 to the length to account for the colon (:) before tabs begin
      cmd_length := cmd_length + 1 
      
      textEditorTabWidth := ""
      
_____DETAILS_BEGIN_____2t_ if( format_for_notepadPlusPlus ){ _____SUMMARY_END_____
         textEditorTabWidth := 4.0
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else 
      if( format_for_notepadDotExe ){ _____SUMMARY_END_____
         textEditorTabWidth := 8.0
      } _____DETAILS_END_____
      
_____DETAILS_BEGIN_____2t_ if( 24 <= cmd_length ){ _____SUMMARY_END_____
         tab_string := "`t"
      } _____DETAILS_END_____
_____DETAILS_BEGIN_____2t_ else if( 2 <= cmd_length ){ _____SUMMARY_END_____
         empty_space_to_fill := 28 - cmd_length
         num_spaces_with_remainder := empty_space_to_fill / textEditorTabWidth
         
         ;---------------------------------------------------------
         ; AutoHotkey Documentation:
         ; Ceil : 
         ;   "Returns Number rounded up to the nearest integer 
         ;    (without any .00 suffix)."
         ;---------------------------------------------------------
         ; https://www.autohotkey.com/docs/commands/Math.htm#Ceil
         ;---------------------------------------------------------
         
         number_of_tabs := Ceil( num_spaces_with_remainder )
         ; msgbox num tabs %number_of_tabs%
         
_____DETAILS_BEGIN_____3t_ Loop, %number_of_tabs%
         { _____SUMMARY_END_____
            tab_string .= "`t"
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      
      return tab_string
   } _____DETAILS_END_____


} ; end of class: FILE_HELPER  _____DETAILS_END_____


;-------------------------------------------;
;  The remaining classes are located        ;
;  in program_launcher_settings_window.ahk  ;
;-------------------------------------------;


;===============================;
; </>   end of Class section    ;
;===============================;


;-----------------------------------------------------------------------------------------------


;================================================;
;                                                ;
;          Text for Default Savefile             ;
;                                                ;
;================================================;

_____DETAILS_BEGIN_____0t_ Default_Save_File:
{ _____SUMMARY_END_____
   _savefile__default_content := "
   (
      ;====================================================================
      ; file:     _program_launcher_saved_phrases.ini
      ; purpose:  _program_launcher.ahk's saved data + tutorial
      ;====================================================================


             ;____________________________;
             ;                            ;
             ;          SETTINGS          ;
             ;____________________________;


      SETTINGS[
         icon: 95
         hotkey_for_commandline_popup: ctrl win space
         hotkey_for_quit: ctrl win alt q
      ]



          ;______________________________________;
          ;                                      ;
          ;              SAVED DATA              ;
          ;______________________________________;
          ;                                      ;
          ;          COMMANDS + ACTIONS          ;
          ;______________________________________;
          

      COMMANDS[
         config:                      SETTINGS
         quit:                        QUIT
         c:                           1
         notepad:                     2
         calc:                        3
         paint:                       4
      ]

      ACTIONS[
         SETTINGS
         QUIT
         1, Folder, ""C:\""
         2, App,    ""C:\Windows\System32\notepad.exe""
         3, App,    ""C:\Windows\System32\calc.exe""
         4, App,    ""C:\Windows\System32\mspaint.exe""
      ]




      ;====================================================================
      ; About the program:                            _program_launcher.ahk
      ;====================================================================
      ;
      ;
      ;  ------------------
      ;  What it does:
      ;  ------------------
      ;
      ;  _program_launcher.ahk is a small utility 
      ;  to reduce the number of steps to
      ;
      ;     () open programs or
      ;     () navigate to folders.
      ;
      ;  You can register words or phrases as [commands]
      ;  which _program_launcher.ahk will associate with an [action].
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
      ;     Register the command ""Show me my muisc"" 
      ;     -> to open the folder C:/Music in a new window.
      ;     
      ;     Register (also) the command ""mu""
      ;     -> to open the folder C:/Music in a new window.
      ;  
      ;  Currently, commands can only be one line long, but can contain: 
      ;  
      ;     () any alphanumeric text
      ;     () spaces
      ;     () symbols `~!@#$%^&*()_+-=[]\{}|;':"",./<>?
      ;
      ;  Actions fall into three categories:
      ;
      ;     (1) Open a folder in a new window.
      ;     (2) Open an application.
      ;     (3) _program_launcher.ahk functions: 
      ;         () Quit 
      ;         () Settings
      ;
      ;
      ;  ------------------
      ;  How to use it:
      ;  ------------------
      ;
      ;  Run _program_launcher.ahk
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
      ;     (1.3)  Hit <Enter> or press ""OK"".
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
      ;     (2.3)  Hit <Enter> or press ""OK"".
      ;
      ;     (2.4)  Enjoy!
      ;  
      ;
      ;
      ;  -------------------------------
      ;  How do I know if it's running?
      ;  -------------------------------
      ;
      ;  Run _program_launcher.ahk.
      ;  You will see its icon appear in Window's ""Notificaiton Area"" 
      ;  (located at the right end of the Windows Taskbar, just before the clock).
      ;
      ;  If you hover your mouse over this script's icon in the Notificaiton Area,
      ;  a tooltip will appear saying ""_program_launcher.ahk"".
      ;
      ;
      ;  -------------------
      ;  How do I close it?
      ;  -------------------
      ;
      ;  To close _program_launcher.ahk either:
      ;
      ;  (1) Right click its icon in the Notificaiton Tray and click ""Exit"". 
      ;
      ;  (2) Quit using a command:
      ;         
      ;      (2.1)  Press the hotkey to display the commandline popup
      ;             (by default, this hotkey is Ctrl+Win+Space). 
      ;      (2.2)  Type 'q' or 'quit' or 'exit' without quotes (').
      ;      (2.3)  Hit enter or click ""OK"".
      ;      (2.4)  The program will stop running. 
      ;
      ;   
      ;====================================================================


      ;====================================================================
      ; About this config file:         _program_launcher_saved_phrases.ini
      ;====================================================================
      ;
      ;  ------------------
      ;  Commented lines : 
      ;  ------------------
      ;
      ;     _program_launcher.ahk will ignore any line
      ;     in this config file if it starts with ';'
      ;  
      ;     Feel free to keep, alter, move, or remove any commented lines.
      ;     It won't affect _program_launcher.ahk's behavior.
      ;  
      ;  -----------
      ;  Settings :
      ;  -----------
      ;   
      ;  Setting name:               ""icon""
      ;  Value for setting:          Integer number.
      ;
      ;    How it works: 
      ;
      ;      This number corresponds to a Shell32.dll icon number.
      ;      This script will use this icon
      ;      (1) in the Windows Notification Tray 
      ;      (2) in the window title bars for _program_launcher.ahk's
      ;          (2.a) commandline popup
      ;          (2.b) configuration window
      ;  
      ;  
      ;  Setting name:               ""hotkey_for_commandline_popup""
      ;  Value for setting:          Key names separated by spaces.
      ;
      ;    How it works: 
      ;    
      ;      When this hotkey is pressed
      ;      _program_launcher.ahk displays its commandline popup.
      ;
      ;
      ;  Setting name:               ""hotkey_for_quit""
      ;  Value for setting:          Key names separated by spaces.
      ;
      ;    How it works: 
      ;    
      ;      When this hotkey is pressed
      ;      _program_launcher.ahk exits.
      ;
      ;
      ;   ---------------------
      ;   Commands + Actions : 
      ;   ---------------------
      ;     
      ;   Commands can be registered to actions in two ways:
      ;
      ;      (1) Add them manually to this settings file, 
      ;          then refresh _program_launcher.ahk.
      ;
      ;          Press the the hotkey associated with 
      ;          [hotkey_for_commandline_popup]
      ;          
      ;          Type 'r' or 'reload', and hit enter.
      ;
      ;      (2) Add them using the settings window.
      ;
      ;          Open _program_launcher.ahk's command prompt 
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
      ;   _program_launcher.ahk handles two action types, either :
      ;     (1) launch a specific explorer folder, or
      ;     (2) launch a program (optionally with a passed default path)
      ;  
      ;====================================================================


      ;====================================================================
      ; Help
      ;====================================================================
      ;
      ; ------------------------------
      ; How do I back up my settings?
      ; ------------------------------
      ;
      ; (1) Using Windows Explorer
      ;     copy and paste the file ""_program_launcher_saved_phrases.ini"" 
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
      ;     ""_program_launcher_saved_phrases.ini.backup123""
      ;     or any name you prefer.
      ;   
      ;     As long as the backup's name doesn't exactly match
      ;     ""_program_launcher_saved_phrases.ini"", 
      ;     the backup will be ignored.
      ;
      ; 
      ; ----------------------------------------------------
      ; How to I restore the default settings and commands?
      ; ----------------------------------------------------
      ;
      ; _program_launcher.ahk can auto-generate this file.
      ;
      ; NOTE: This step will not auto-generate your custom commands and actions.
      ;       Be sure to make a backup file first. 
      ;
      ;   (a) Move or copy
      ;      _program_launcher.ahk to a directory without
      ;      _program_launcher_saved_phrases.ini.
      ;      
      ;      When you run _program_launcher.ahk 
      ;      the default version of this settings file will be auto-generated.
      ;
      ;   (b) Alternatively
      ;====================================================================
      
      
      
      
      
      
   )"
   
   ;---------------------------------------------------------------------------------
   ;    Remove leading tabs from continuation section variable.
   ;---------------------------------------------------------------------------------
   ;
   ; To skip this step, 
   ; I could have made the long continuation section above 
   ; flush with the left of the document (with no indentations)
   ;
   ; I like to keep things indented though. 
   ;
   ; Here's the process for the next few lines:
   ;
   ;   (1)   Look at the number of tabs at the very beginning 
   ;       of the savefile content variable.
   ;
   ;       Save these leading tabs in a variable named detected_leading_tabs
   ;
   ;   (2) Get the number of tabs by getting the length of the string.
   ;
   ;   (3) For each line in the variable _savefile__default_content
   ;      remove the number of tabs detected in step (2).
   ;
   ;
   ; Additional step in part (3): 
   ;
   ;     Convert each default linefeed newline      ("`n") 
   ;     into a carriage return + linefeed newline  ("`r`n")
   ;    
   ;    Without this step, the RegularExpression doesn't properly work with the 
   ;    
   ;       begining of line anchor     ("^") 
   ;       and end of line anchor      ("$")
   ;
   ; Read more about the necessity of this conversion here:
   ;    https://autohotkey.com/board/topic/115426-multiline-regexreplace/#entry668977
   ;---------------------------------------------------------------------------------
   
   ;-------;
   ;  (1)  ;
   ;-------;
   RegExMatch(_savefile__default_content, "^([\t]*)", detected_leading_tabs)
   
   ;-------;
   ;  (2)  ;
   ;-------;
   num_tabs_to_rm := StrLen(detected_leading_tabs)
   
   ;-------;
   ;  (3)  ;
   ;-------;
   
   _savefile__default_content := RegExReplace(_savefile__default_content, "`n", "`r`n")
   _savefile__default_content := RegExReplace(_savefile__default_content, "Um)^\t{" num_tabs_to_rm "}(.*)$","$1")
   
   return
   
} _____DETAILS_END_____









#Include program_launcher_settings_window.ahk
   
   







