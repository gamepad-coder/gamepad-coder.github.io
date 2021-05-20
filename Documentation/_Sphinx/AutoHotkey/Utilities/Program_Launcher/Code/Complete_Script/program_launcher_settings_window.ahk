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
;  program_launcher_settings_window.ahk                                 ;
;-----------------------------------------------------------------------;
;                                                                       ;
;                                                     version 2         ;
;                                                                       ;
;  This file contains the GUI interface for program_launcher.ahk.       ;
;                                                                       ;
;  To open this GUI config window:                                      ;
;                                                                       ;
;     (1) Run program_launcher.ahk,                                     ;
;     (2) Use the command to open the settings,                         ;
;         (by default, the command is "config", no quotes).             ;
;                                                                       ;
;         This script's code will be used to show the user              ;
;         a settings window which facilitates modifying                 ;
;         the settings.ini file.                                        ;
;                                                                       ;
;   This file cannot be run in isolation.                               ;
;   It's really just the second half of program_launcher.ahk,           ;
;   but separated into a second file to improve readability.            ;
;-----------------------------------------------------------------------;


_____DETAILS_BEGIN_____0t_ class GuiConfigMain { _____SUMMARY_END_____

   ;----------------------------------------------------------------------
   ; These text strings are specific to the checkbox at the bottom 
   ; of Tab1 of this window. These vars won't be altered, only accessed.
   ;
   static CheckboxShowAll_TextForChecked  := "SHOW ALL   (Uncheck to hide disabled commands)   "
   static CheckboxShowAll_TextForUnchecked := "SHOW ALL   (Check to also show disabled commands)"
   
   
   static _plucked_command := ""
   static _plucked_action  := ""
   
   static _is_gui_baked := false


_____DETAILS_BEGIN_____1t_ __New() { _____SUMMARY_END_____
   ; global 
      
      ;------------------------------;
      ; Global vars to use elsewhere
      ;
      
   
      GuiConfigMain.Initialize_Gui_gVariables()
      
      GuiConfigMain.Init_Config_Gui_and_TabControl()
      GuiConfigMain.Init_Config_1st_Tab()
      GuiConfigMain.Init_Config_2nd_Tab()
      GuiConfigMain.Init_Config_3rd_Tab()
      GuiConfigMain.Init_Config_4th_Tab()
      
      GuiConfigMain.Fn_Action_Buttons_Disable()
      
      ;==================================;
      ; Render + Display main GUI window ;
      ;==================================;
      
      Gui, ConfigMain:Show
   
      ; _is_MainGui_baked := true 
      GuiConfigMain.GUI_EVENT_OnSize( "Gui up and running" )
      
      GuiConfigMain.Init_ReadProgramArraysIntoGui()
      
      GuiConfigMain._is_gui_baked := true 
      
      return this
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ __Delete() { _____SUMMARY_END_____
   ; global 
   
      ; Clear static class members between Config Window instances.
            
      GuiConfigMain._plucked_command := ""
      GuiConfigMain._plucked_action  := ""
      
      ; Clear static function variables in OnSize() function
      
      GuiConfigMain.GUI_EVENT_OnSize( "RESET" )
      GuiConfigMain._is_gui_baked := false
      
      Gui ConfigMain: Destroy
      
      return
   } _____DETAILS_END_____
   
   ;============================================================
   ;         GuiConfigMain (Main Window)  
   ;============================================================

   
_____DETAILS_BEGIN_____1t_ Initialize_Gui_gVariables() { _____SUMMARY_END_____
   global
   
      ;-------------------------------------------------------------------------
      ; 
      ; It's a good practice to clear global variables 
      ; for GUIs which are created multiple times over the lifespan of a script.
      ; 
      ;-------------------------------------------------------------------------      
      
      GuiConfigMain_Tabs                              := ""
      
      GuiConfigMain_ListViewCmds                      := ""
      GuiConfigMain_ButtonNewCmd                      := ""
      GuiConfigMain_ButtonEditCmd                     := ""
      GuiConfigMain_ButtonDeleteCmd                   := ""
      GuiConfigMain_CheckboxShowAll                   := ""
      
      GuiConfigMain_ListViewActions                   := ""
      GuiConfigMain_ButtonNewAction                   := ""
      GuiConfigMain_ButtonEditAction                  := ""
      GuiConfigMain_ButtonDeleteAction                := ""
      
      GuiConfigMain_Settings_ABOUT                    := ""
      GuiConfigMain_Settings_ButtonExport             := ""
      GuiConfigMain_Settings_ButtonImportAsDisabled   := ""  
      GuiConfigMain_Settings_ButtonImportAsEnabled    := ""
      GuiConfigMain_Settings_Info                     := ""
       
      
      return
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Init_Config_Gui_and_TabControl() { _____SUMMARY_END_____
   global
   
      ;========================;
      ; Create main GUI window ;
      ;========================;
      
        title_for_GuiConfigMain_Window := "_program_launcher.ahk - Configuration"
      options_for_GuiConfigMain_Window := A_Space "+Label" "GuiConfigMain.GUI_EVENT_On"
      options_for_GuiConfigMain_Window .= A_Space "+Resize +MinSize420x375"

      Gui, ConfigMain:New
         , %options_for_GuiConfigMain_Window%
         , %title_for_GuiConfigMain_Window%


      ;--------------------------------;
      ; Ensures future "Gui," commands 
      ; add specifically to the Gui 
      ; using the name "ConfigMain:". 
      ;
      Gui, ConfigMain:Default
         
         
      ;=========================================================;
      ; Hidden Button to allow detection of <Enter> key events  ;
      ;=========================================================;
     
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonHiddenDefault"
      options  .= A_Space "+Hidden +Default w0 h0"
      Gui, ConfigMain:Add, Button
         , %options%
         , ""


      ;================================
      ; Add Tab Container with 3 tabs
      ; - Commands
      ; - Actions
      ; - Settings
      ;================================

         text := "Commands|Actions|Settings|   ?   "
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_Tabs"
      options  .= A_Space "v" "GuiConfigMain_Tabs"
         
         
      Gui, ConfigMain:Add, Tab3
         , %options%
         , %text%
         
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Config_1st_Tab() { _____SUMMARY_END_____
   global
   
     ;[1][1][1][1][1][1][1][1][1][1][1][1][1]~
     ;---------------TAB SWITCH---------------
     ;
     ; 1st Tab will receive 
     ; Gui Controls added after this line
     ;
     ;---------------TAB SWITCH---------------
     ;[1][1][1][1][1][1][1][1][1][1][1][1][1]~
      
      Gui, Tab, 1      

      
      ;=======================;
      ; ListView for Commands ;
      ;=======================;

        ;------------------------------------------------------------
        ; Note:
        ;   The style "LV0x10000" is LVS_EX_DOUBLEBUFFER, 
        ;   and (in some cases) helps reduce flikering upon redrawing
        ;------------------------------------------------------------
        ; Read More Here:
        ;   https://autohotkey.com/board/topic/89323-listview-and-flashing-on-redrawing-or-editing/
        ;   https://www.autohotkey.com/docs/misc/Styles.htm#ListView
        ;------------------------------------------------------------
      
      text_column1 := "Command     "
      text_column2 := "|->"
      text_column3 := "|Action ID"
      text_column4 := "|Action Type"
      text_column5 := "|Action Path"
      text_column6 := "|Action Arg for Programs"
      text := text_column1
           .  text_column2
           .  text_column3
           .  text_column4
           .  text_column5
           .  text_column6
           
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ListViewCommands" 
      options  .= A_Space "v"           "GuiConfigMain_ListViewCmds" 
      options  .= A_Space "+checked +ReadOnly +AltSubmit -Multi" 
      options  .= A_Space "r20 w700" 
      options  .= A_Space "+LV0x10000" 
      
      Gui, ConfigMain:Add, ListView
         , %options%
         ,    %text%
      

      ;================================;
      ; Button to create a new Command ;
      ;================================;
      
         text := "[ + ] New Command"
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonNewCmd"
      options  .= A_Space "v"           "GuiConfigMain_ButtonNewCmd"
      options  .= A_Space "section"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
      
      ;================================;
      ; Button to Edit a Command ;
      ;================================;
      
         text := "[ : ] Edit Selected`nCommand"
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonEditCmd"
      options  .= A_Space "v"           "GuiConfigMain_ButtonEditCmd"
      options  .= A_Space "ys"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
         
      ;================================;
      ; Button to Delete a Command ;
      ;================================;
      
         text := "[ x ] Delete Selected`nCommand"
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonDeleteCmd"
      options  .= A_Space "v"           "GuiConfigMain_ButtonDeleteCmd"
      options  .= A_Space "ys"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
      
      
      ;===========================;
      ; CheckBox to toggle        ;
      ; - display all             ;
      ; - or just display enabled ;
      ;===========================;

         text := GuiConfigMain.CheckboxShowAll_TextForChecked
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_CheckboxShowAll" 
      options  .= A_Space "v"           "GuiConfigMain_CheckboxShowAll"
      options  .= A_Space "xs y+10"
      options  .= A_Space "Checked" "1"
      
      Gui, ConfigMain:Add, CheckBox
         , %options%
         ,    %text%
      
      
      return 
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Init_Config_2nd_Tab() { _____SUMMARY_END_____
   global
   
     ;[2][2][2][2][2][2][2][2][2][2][2][2][2]~
     ;---------------TAB SWITCH---------------
     ;
     ; 2nd Tab will receive 
     ; Gui Controls added after this line
     ;
     ;---------------TAB SWITCH---------------
     ;[2][2][2][2][2][2][2][2][2][2][2][2][2]~
      
      Gui, Tab, 2   


      ;=======================;
      ; ListView for Actions ;
      ;=======================;

      gui_name     := "ConfigMain"
      goto_name    := "GuiConfigMain.GUI_EVENT_ListViewActions"
      control_name := "GuiConfigMain_ListViewActions"
      REUSABLE_GUI_CONTROLS.create_listview_of_actions( gui_name
         , goto_name
         , control_name )
      

      
      ;================================;
      ; Button to create a new Action  ;
      ;================================;
      
         text := "[ + ] New Action "
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonNewAction"
      options  .= A_Space "v"           "GuiConfigMain_ButtonNewAction"
      options  .= A_Space "section"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%


      ;================================;
      ; Button to Edit an Action       ;
      ;================================;
      
         text := "[ : ] Edit Selected`nAction"
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonEditAction"
      options  .= A_Space "v"           "GuiConfigMain_ButtonEditAction"
      options  .= A_Space "ys x137"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
         
      ;================================;
      ; Button to Delete an Action     ;
      ;================================;
      
         text := "[ x ] Delete Selected`nAction"
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonDeleteAction"
      options  .= A_Space "v"           "GuiConfigMain_ButtonDeleteAction"
      options  .= A_Space "ys"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
      
         
      ;================================;
      ; Button to Run an Action        ;
      ;================================;
      
      Gui, Tab, 
      
         text := "Run selected Action now."
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_ButtonRunAction"
      options  .= A_Space "v"           "GuiConfigMain_ButtonRunAction"
      options  .= A_Space "ym x600"
      options  .= A_Space "+Hidden"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
      
      
      return 
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Config_3rd_Tab() { _____SUMMARY_END_____
   global 
   
     ;[3][3][3][3][3][3][3][3][3][3][3][3][3]~
     ;---------------TAB SWITCH---------------
     ;
     ; 3rd Tab will receive 
     ; Gui Controls added after this line
     ;
     ;---------------TAB SWITCH---------------
     ;[3][3][3][3][3][3][3][3][3][3][3][3][3]~
      
      Gui, Tab, 3   
      


      ;========================================;
      ; Button to change Application icon      ;
      ;========================================;
      
         text :=  "Change Window Icon."
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_Settings_ButtonIcon"
      options  .= A_Space "v" "GuiConfigMain_Settings_ButtonIcon"
      options  .= A_Space "y+30 x+35"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
         

      ;========================================;
      ; Button to create a backup of settings  ;
      ;========================================;
      
         text :=  "Export a backup file."
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_Settings_ButtonExport"
      options  .= A_Space "v" "GuiConfigMain_Settings_ButtonExport"
      ; options  .= A_Space "y+12"
      options  .= A_Space "y+30"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
         
      
      ;==========================================;
      ; Button to import settings (disable cmds) ;
      ;==========================================;
      
         text := "Import a backup file (but disable all imported commands)."
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_Settings_ButtonImportAsDisabled"
      options  .= A_Space "v" "GuiConfigMain_Settings_ButtonImportAsDisabled"
      options  .= A_Space " y+12"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%
      
      
      ;==========================================;
      ; Button to import settings (enable cmds)  ;
      ;==========================================;
      
         text := "Import a backup file (and enable all imported commands)."
      options :=  A_Space "g" "GuiConfigMain.GUI_EVENT_Settings_ButtonImportAsEnabled"
      options  .= A_Space "v" "GuiConfigMain_Settings_ButtonImportAsEnabled"
      options  .= A_Space " y+12"
      
      Gui, ConfigMain:Add, Button
         , %options%
         ,    %text%


      ;=========================================
      ; Add `Text` Label:
      ;-----------------------------------------
      ; Inform User Drag-n-Drop is possible here
      ;=========================================

         text :=  ""
         text  .= "  Auto-Save:`n`n"
         text  .= "     Actions, Commands, and Settings are automatically saved `n"
         text  .= "     the moment you change them (add, edit, enable/disable, delete).`n`n"
         text  .= "     Actions, Commands, and Settings are saved to`n"
         text  .= "     _program_launcher_settings.ini.`n`n"
         text  .= "  On this tab :`n`n"
         text  .= "     You can make a backup of this settings file,`n"
         text  .= "     or add settings into your current save file`n"
         text  .= "     by importing data from a backup."
         ; text  .= "`n`n`n"
         
      options :=  A_Space "v" "GuiConfigMain_Settings_Info"
      options  .= A_Space "Border "
      options  .= A_Space "y+30 w700 r10"
      options  .= A_Space "x20"
      options  .= A_Space "+ReadOnly"
      
      Gui, Font,s12
      
      Gui, ConfigMain:Add, Edit
         , %options%
         , %text% 
      
      Gui, Font
         

      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Init_Config_4th_Tab() { _____SUMMARY_END_____
   global 
   
     ;[3][3][3][3][3][3][3][3][3][3][3][3][3]~
     ;---------------TAB SWITCH---------------
     ;
     ; 3rd Tab will receive 
     ; Gui Controls added after this line
     ;
     ;---------------TAB SWITCH---------------
     ;[3][3][3][3][3][3][3][3][3][3][3][3][3]~
      
      Gui, Tab, 4
      
      
      ;=========================================
      ; Add `Edit` readonly Label: about 
      ;=========================================
      
         text := GuiConfigMain.Fn_AboutTab_Get_Text()
      options :=  A_Space "v" "GuiConfigMain_Settings_ABOUT"
      options  .= A_Space "Border "
      options  .= A_Space "y+30"
      options  .= A_Space "+Readonly"
         
      Gui, Font,s12, Courier New
      
      Gui, ConfigMain:Add, Edit
         , %options%
         , %text% 
         
      Gui, Font

      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_ReadProgramArraysIntoGui() { _____SUMMARY_END_____
   global

      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewCommands_Activate()
      
      ;------------------;
      ; syntax reference ; 
      ;-----------------------------------------------------------------;
      ;   _COMMANDS := { "godot" : {"action_id":1, "enabled":true} }    ;
      ;-----------------------------------------------------------------;
_____IF_DETAILS_BEGIN_____2t_ for cmd, cmd_info in _COMMANDS { _____SUMMARY_END_____

         action      := ""
         action_type := ""
         action_path := ""
         action_arg  := ""
         
         cmd_action_id  := cmd_info["action_id"]
         cmd_is_enabled := cmd_info["enabled"]
         
         
         ;------------------------------------------------------
         ; AutoHotkey Docs, Ternary Operator: 
         ; https://www.autohotkey.com/docs/Variables.htm#ternary
         ;
         lv_cmd_options := (true==cmd_is_enabled) ? "+Check" : "-Check"
         
            
         ;==================================
         ; Get the Command's Action Data
         ;==================================
         
_____IF_DETAILS_BEGIN_____3t_ if( _ACTIONS.HasKey(cmd_action_id) ){ _____SUMMARY_END_____
            action := _ACTIONS[cmd_action_id]
            action_type := action["type"]
            action_path := action["path"]
            action_arg  := action["arg"]
            ; msgbox does have action id
         } _____DETAILS_END_____
         
         ;======================================================
         ; Add the Command to GuiConfigMain's Command ListView 
         ;======================================================
         
_____IF_DETAILS_BEGIN_____3t_ if( cmd_action_id!="" and action_type!="" and action_path!="" ){ _____SUMMARY_END_____
            
            LV_Add(lv_cmd_options   ; Check row if Command is enabled
               , cmd                 ; row 1
               , ""                  ; row 2
               , cmd_action_id       ; row 3
               , action_type         ; row 4
               , action_path         ; row 5
               , action_arg )        ; row 6
            
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else if( "SETTINGS" = cmd_action_id
         or       "QUIT"     = cmd_action_id ){ _____SUMMARY_END_____
            
            LV_Add(lv_cmd_options   ; Check row if Command is enabled
               , cmd                 ; row 1
               , ""                  ; row 2
               , cmd_action_id       ; row 3
               , ""                  ; row 4
               , ""                  ; row 5
               , "" )                ; row 6
               
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else{ ;error; _____SUMMARY_END_____
            error_msg :=  "Error in Initialization of Main.LV.Cmds `n "
            error_msg  .= "cmd_action_id [" cmd_action_id "] `n "
            error_msg  .= "action_type   ["  action_type  "] `n "
            error_msg  .= "action_path   ["  action_path  "] `n "
            MSGBOX, , Error, %error_msg%
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      LV_ModifyCol(3, "Sort")
      GuiConfigMain.ListViewCommands_ReadjustAllCols()
      GuiConfigMain.ListViewActions_ReadjustAllCols()
      
      return
   } _____DETAILS_END_____

   
   ;-----------------------------------------------
   ; <Enter> key pressed.
   ;-----------------------------------------------
   ; Crude workaround recommended by the AHK Docs.
   ;
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonHiddenDefault() { _____SUMMARY_END_____
   global

      ;------------------------------------------
      ; Refreshes the variable GuiConfigMain_Tabs
      ; which stores the current tab name
      ;------------------------------------------

      Gui, ConfigMain:Submit, NoHide 

_____IF_DETAILS_BEGIN_____2t_ if( GuiConfigMain_Tabs == "Commands" ){ _____SUMMARY_END_____

         ;-----------------------------------------------------
         ; Edit the currently selected Command (if selection)
         ;-----------------------------------------------------
         
         ; GuiConfigMain.Create_Popup_Command()
         GuiConfigMain.Create_Popup("command")
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else if( GuiConfigMain_Tabs == "Actions" ){ _____SUMMARY_END_____

         ;-----------------------------------------------------
         ; Edit the currently selected Action (if selection)
         ;-----------------------------------------------------
      
         ; GuiConfigMain.Create_Popup_Action()
         GuiConfigMain.Create_Popup("action")
      } _____DETAILS_END_____
   return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnSize( FLAG:="" ) { _____SUMMARY_END_____
   global
      
      ;=====================================================
      ;         Upon resizing the GUI window, 
      ;        
      ;         readjust Control :
      ;           - placement 
      ;           - width  (where applicable) 
      ;           - height (where applicable) 
      ;        
      ;         to maintain a consistent layout.
      ;=====================================================
      
      ;-------------------------------------------------
      ; Static variables in a function 
      ; will retain their value between function calls.
      ;-------------------------------------------------
      
      static is_MainGui_baked := false 
      static GuiHeight 
      static GuiWidth
      
      static offset_y_from_tabcontainer := "" 
      static ar_offset_from_bottom := []
      static ar_offset_from_right  := []
      static ar_reposition_ctrls := [ ""
            .     "GuiConfigMain_CheckboxShowAll"
               , "GuiConfigMain_ButtonNewCmd" 
               , "GuiConfigMain_ButtonEditCmd" 
               , "GuiConfigMain_ButtonDeleteCmd" 
               , "GuiConfigMain_ButtonNewAction" 
               , "GuiConfigMain_ButtonEditAction" 
               , "GuiConfigMain_ButtonDeleteAction" ]      
      static ar_resize_ctrls := [ ""
            .     "GuiConfigMain_Tabs" 
               , "GuiConfigMain_ListViewCmds"
               , "GuiConfigMain_ListViewActions"
               , "GuiConfigMain_Settings_Info"
               , "GuiConfigMain_Settings_ABOUT" ]      
         
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
      
      GuiConfigMain_Tabs                              := ""
      GuiConfigMain_ListViewCmds                      := ""
      GuiConfigMain_ButtonNewCmd                      := ""
      GuiConfigMain_ButtonEditCmd                     := ""
      GuiConfigMain_ButtonDeleteCmd                   := ""
      GuiConfigMain_CheckboxShowAll                   := ""
      GuiConfigMain_ButtonNewAction                   := ""
      GuiConfigMain_ButtonEditAction                  := ""
      GuiConfigMain_ButtonDeleteAction                := ""
      GuiConfigMain_Settings_ABOUT                    := ""
      GuiConfigMain_Settings_ButtonExport             := ""
      GuiConfigMain_Settings_ButtonImportAsDisabled   := ""  
      GuiConfigMain_Settings_ButtonImportAsEnabled    := ""
      GuiConfigMain_Settings_Info                     := ""
      
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      ;---------------------------------------------------------------------
      ; NOTE:
      ;---------------------------------------------------------------------
      ;
      ; The Gui Event "OnSize" is called when a window is first rendered
      ; but A_GuiHeight and A_GuiWidth aren't present 
      ; when we call this function manually with 
      ;    
      ;    GuiConfigMain.GUI_EVENT_OnSize("Some Flag")
      ; 
      ; As soon as these are initialized, we'll store a copy 
      ; in these function static vars.
      ; 
      ; This will allow us to reference these dimensions 
      ; when we call this "OnSize" event function manually
      ;---------------------------------------------------------------------
      ;
_____IF_DETAILS_BEGIN_____2t_ if( "" != A_GuiHeight 
      and "" != A_GuiWidth ){ _____SUMMARY_END_____
         GuiHeight := A_GuiHeight
         GuiWidth := A_GuiWidth
      } _____DETAILS_END_____
      
      
     ;******************************************************************************
     ;
     ;                     Manual Function Calls with Flags
     ;
     ;******************************************************************************
      
      ;==========================================
      ; Initialize static vars & control offsets
      ;==========================================
      
_____IF_DETAILS_BEGIN_____2t_ if( "Gui up and running" == FLAG){ _____SUMMARY_END_____
         is_MainGui_baked  := true 
         
         ;----------------------------------------------
         ; Controls in Tab Containers 
         ; have a hidden additional offset 
         ;
         ; Hacky offset found through trial-and-error 
         ;
         c := "GuiConfigMain_ListViewCmds"
         GuiControlGet, TabContainer, Pos, %c%
         offset_y_from_tabcontainer := TabContainerY - 6
         
         ;-----------------------------------------------------------------
         ; For each Control where we only need to adjust its y-coordinate
         ;-----------------------------------------------------------------
         ; (1) Find how far away from the bottom it is initially.
         ; (2) Upon window resize, 
         ;     reposition the y-coordinate to maintain this offset consistently.
         ;
_____IF_DETAILS_BEGIN_____3t_ for i, c in ar_reposition_ctrls
         { _____SUMMARY_END_____
            GuiControlGet, ctrl_, Pos, %c%
            
            offset_from_bottom := GuiHeight - (ctrl_y  - offset_y_from_tabcontainer)
            ar_offset_from_bottom[c] := offset_from_bottom               
         } _____DETAILS_END_____
         
         ;-----------------------------------------------------------------
         ; For each Control where we only need to stretch the height
         ;-----------------------------------------------------------------
         ; (1) Find the amount of space between the bottom of the control 
         ;     and the bottom of the window (all these Controls are 
         ;     positioned at the top of the window, so keep that in mind
         ;     if altering or reusing this code).
         ; (2) Upon window resize, stretch Control's height 
         ;     to maintain this bottom offset consistently.
         ;
_____IF_DETAILS_BEGIN_____3t_ for i, c in ar_resize_ctrls
         { _____SUMMARY_END_____
            GuiControlGet, ctrl_, Pos, %c%
         
            offset_from_bottom := GuiHeight - ctrl_h
            ar_offset_from_bottom[c] := offset_from_bottom      
         }       _____DETAILS_END_____
         
         c := "GuiConfigMain_ButtonRunAction"
         GuiControlGet, ctrl_, Pos, %c%
         ar_offset_from_right[c] := GuiWidth - ctrl_x
         
         ;----------------------------------------------------
         ; When called manually, 
         ; A_GuiHeight and A_GuiWidth 
         ; will not be populated by AutoHotkey Event handling
         ;
         return 

      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else if( "RESET" == FLAG ){ _____SUMMARY_END_____
         is_MainGui_baked  := false
         GuiHeight := ""
         GuiWidth := ""
         return
      } _____DETAILS_END_____
      
      
     ;******************************************************************************
     ;
     ;                    AutoHotkey Event calls to OnSize()
     ;
     ;******************************************************************************

      ;==========================================
      ; Adjust size and positioning of Controls
      ; when Gui Window is resized.
      ;==========================================
         
_____IF_DETAILS_BEGIN_____2t_ if( true == is_MainGui_baked) ; ensures this is only called after our static vars are initialized
      { _____SUMMARY_END_____
         
         ;---------------------------------
         ; Adjust y-position of 
         ;
         ; GuiConfigMain_CheckboxShowAll
         ; GuiConfigMain_ButtonNewCmd 
         ; GuiConfigMain_ButtonNewAction
         ;---------------------------------
         
_____IF_DETAILS_BEGIN_____3t_ for j, c in ar_reposition_ctrls
         { _____SUMMARY_END_____
            offset :=  ar_offset_from_bottom[c]
            destination_y := A_GuiHeight - offset
            
            ; GuiControl, ConfigMain: MoveDraw, %c%, % "y" destination_y
            GuiControl, ConfigMain: Move,     %c%, % "y" destination_y               
         } _____DETAILS_END_____
         
         c := "GuiConfigMain_ButtonRunAction"
         offset :=  ar_offset_from_right[c]
         destination_x := A_GuiWidth - offset
         GuiControl, ConfigMain: Move,     %c%, % "x" destination_x      
         
         
         ;---------------------------------
         ; Adjust Size of 
         ;
         ; Tab box 
         ; ListView: Commands 
         ; ListView: Actions
         ;---------------------------------
         
         c := "GuiConfigMain_ListViewCmds"
         GuiControlGet, ctrl_LV_, Pos, %c%
         offset_LV :=  ar_offset_from_bottom[c]
         
         c := "GuiConfigMain_Tabs"
         GuiControlGet, ctrl_tab_, Pos, %c%
         offset_tab :=  ar_offset_from_bottom[c]
         
         c := "GuiConfigMain_Settings_Info"
         offset_info :=  ar_offset_from_bottom[c]
         
         options_LV := ""
         options_tab := ""
         
            options_tab .= " h" A_GuiHeight - offset_tab            
            options_LV  .= " h" A_GuiHeight - offset_LV
            options_info .= " h" A_GuiHeight - offset_info
            
            options_LV  .= " w" A_GuiWidth - (ctrl_LV_X * 2)            
            options_tab .= " w" A_GuiWidth - (ctrl_tab_X * 2)
            
            options_info  .= " w" A_GuiWidth - (ctrl_LV_X * 2)
            options_about .= " w" A_GuiWidth - (ctrl_LV_X * 2)
            
         
         c := "GuiConfigMain_ListViewCmds"
         ; GuiControl, ConfigMain: MoveDraw,     %c%, %options_LV%
         GuiControl, ConfigMain: Move,     %c%, %options_LV%
         
         
         c := "GuiConfigMain_ListViewActions"
         ; GuiControl, ConfigMain: MoveDraw,     %c%, %options_LV%
         GuiControl, ConfigMain: Move,     %c%, %options_LV%
      
         c := "GuiConfigMain_Settings_Info"
         ; GuiControl, ConfigMain: MoveDraw,     %c%, %options_info%
         GuiControl, ConfigMain: Move,     %c%, %options_info%
         
         c := "GuiConfigMain_Settings_ABOUT"
         about_text := GuiConfigMain.Fn_AboutTab_Get_Text(A_GuiWidth)
         ; GuiControl, ConfigMain: , %c%, ""
         GuiControl, ConfigMain: , %c%, %about_text%
         ; msgbox %about_text%
_____IF_DETAILS_BEGIN_____3t_ if( A_GuiWidth < 585){ _____SUMMARY_END_____
            ; GuiControl, ConfigMain: MoveDraw,     %c%, %options_info%
            GuiControl, ConfigMain: Move,     %c%, %options_about%
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else{ _____SUMMARY_END_____
            GuiControl, ConfigMain: Move,     %c%, w527
         } _____DETAILS_END_____
         
         
         
         c := "GuiConfigMain_Tabs"
         GuiControl, ConfigMain: MoveDraw,     %c%, %options_tab%
         ; GuiControl, ConfigMain: Move,     %c%, %options_tab%
         
         
         ;---------------------------------------------------------------------------------
         ; Calling these readjust functions here 
         ; will prevent a horizontal scroll bar from appearing when unnecessary.
         ;
         ; However, adding these lines causes the ListView headers for the columns 
         ; to frequently fail to repaint (due to rapid MoveDraw calls).
         ;
         ;      GuiConfigMain.ListViewActions_ReadjustAllCols()
         ;      GuiConfigMain.ListViewCommands_ReadjustAllCols()
         ;---------------------------------------------------------------------------------
         
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnEscape() { _____SUMMARY_END_____
   global
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnClose() { _____SUMMARY_END_____
   global
   
         _o_Gui_Config_Main := ""
         
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnDropFiles() { _____SUMMARY_END_____
   global
   
      ;---------------------------------------------------------------------
      ; AutoHotkey Docs for GuiDropFiles
      ;---------------------------------------------------------------------
      ; A_EventInfo and ErrorLevel:
      ;   Both contain the number of files dropped.
      ;---------------------------------------------------------------------
      ; A_GuiEvent:
      ;   Contains the names of the files that were dropped, 
      ;   with each filename except the last terminated by a linefeed (`n).
      ;---------------------------------------------------------------------
      ; https://www.autohotkey.com/docs/commands/Gui.htm#GuiDropFiles
      ;---------------------------------------------------------------------
      
      Gui, ConfigMain:Submit, NoHide 
      
_____IF_DETAILS_BEGIN_____2t_ if( GuiConfigMain_Tabs == "Actions" ){ _____SUMMARY_END_____
      
         ;--------------------------------------------
         ; Populate GUI data with drag-n-dropped file.
         ;--------------------------------------------
         ; User dropped 1 file onto GuiConfigPopup GUI 
         ;--------------------------------------------
_____IF_DETAILS_BEGIN_____3t_ if( A_EventInfo == 1 ){ _____SUMMARY_END_____
            
            is_dragNdrop_valid := FileExist(A_GuiEvent)
      
_____IF_DETAILS_BEGIN_____4t_ if( "" !=  is_dragNdrop_valid ){ _____SUMMARY_END_____
            
_____IF_DETAILS_BEGIN_____5t_ if( _o_Gui_Config_Popup == "" ){ _____SUMMARY_END_____
                  _o_Gui_Config_Popup := new GuiConfigPopup("action"
                                                , "add"
                                                , NA_lv_row:=""
                                                , silent:=true)
                  
_____IF_DETAILS_BEGIN_____6t_ if( InStr(is_dragNdrop_valid, "D") ){ _____SUMMARY_END_____
                     ; populate as dir 
                     
                     GuiControl,, GuiConfigPopup_ActionConfig_RadioFolder, 1
                     GuiControl,, GuiConfigPopup_ActionConfig_RadioApp   , 0
                     
                     GuiControl,, GuiConfigPopup_ActionConfig_InputPath, %A_GuiEvent%
                  } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____6t_ else { _____SUMMARY_END_____
                     ; populate as file 
                     
                     GuiControl,, GuiConfigPopup_ActionConfig_RadioFolder, 0
                     GuiControl,, GuiConfigPopup_ActionConfig_RadioApp   , 1
                     
                     GuiControl,, GuiConfigPopup_ActionConfig_InputPath, %A_GuiEvent%
                  } _____DETAILS_END_____
                  _o_Gui_Config_Popup.Submit_Changes()
                  _o_Gui_Config_Popup := ""
               } _____DETAILS_END_____
            } _____DETAILS_END_____
         } _____DETAILS_END_____
         ;----------------------------------------------------
         ; Unsupported.
         ;----------------------------------------------------
         ; User dropped more than 1 file onto GuiConfigPopup GUI 
         ;----------------------------------------------------
_____IF_DETAILS_BEGIN_____3t_ else if( A_EventInfo > 1 ){ _____SUMMARY_END_____
            str_for_usr_output := "_program_launcher.ahk`n`n"
            str_for_usr_output .= "--------------`nOops`n--------------`n"
            str_for_usr_output .= """Edit a Command"" can't process more than one file.`n`n"
            str_for_usr_output .= "Ensure you only have one file selected `n"
            str_for_usr_output .= "in Windows Explorer.`n`n"
            str_for_usr_output .= "Then try to drag-and-drop it onto this window again.`n"
            
            MsgBox,, % "[X] Can't process more than one file for a path.", %str_for_usr_output%
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ GUI_EVENT_Tabs() { _____SUMMARY_END_____
   global 
      
      ;------------------------------------------
      ; Refreshes the variable GuiConfigMain_Tabs
      ; which stores the current tab name
      ;------------------------------------------

      Gui, ConfigMain:Submit, NoHide 
      
_____IF_DETAILS_BEGIN_____2t_ if( GuiConfigMain_Tabs == "Actions" ){ _____SUMMARY_END_____
         GuiControl, ConfigMain: -Hidden, GuiConfigMain_ButtonRunAction
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         GuiControl, ConfigMain: +Hidden, GuiConfigMain_ButtonRunAction
      } _____DETAILS_END_____
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_ListViewActions() { _____SUMMARY_END_____
   global
      
      ;-----------------------------------------------------
      ; If events are being triggered
      ; while the popup is altering or inserting new entries
      ; ignore event.
      ;
_____IF_DETAILS_BEGIN_____2t_ if("" != _o_Gui_Config_Popup ){ _____SUMMARY_END_____
         return
      } _____DETAILS_END_____
      
      ; msgbox A_EventInfo %A_EventInfo%
_____IF_DETAILS_BEGIN_____2t_ if (A_GuiEvent = "DoubleClick")
      { _____SUMMARY_END_____
         ; GuiConfigMain.Create_Popup_Action()
         GuiConfigMain.Create_Popup("action")
      } _____DETAILS_END_____

      ;--------------------------------------
      ; user has edited first field of a row 
_____IF_DETAILS_BEGIN_____2t_ if (A_GuiEvent = "e")
      { _____SUMMARY_END_____
         GuiConfigMain.ListViewActions_ReadjustAllCols()
      } _____DETAILS_END_____
      
      ;--------------------------
      ; An Item Changed
      ;
_____IF_DETAILS_BEGIN_____2t_ if ( "I" = A_GuiEvent ){ _____SUMMARY_END_____
         
         ;===================================================
         ; ENABLE / DISABLE state changed for a Command
         ;===================================================
         
         ;-------------------------------------------
         ; Event was either Select (S) or Deselect (s)
         ;
_____IF_DETAILS_BEGIN_____3t_ if( InStr(ErrorLevel, "S") ){ _____SUMMARY_END_____
            
            ; Tells future ListView operations to operate on this specific ListView control
            GuiConfigMain.ListViewActions_Activate()
         
            ;-------------------------------------------
            ; Get Action ID for that row in the ListView 
            ;
            sel_act_id := ""
            LV_GetText(sel_act_id, A_EventInfo, 1)
            
            ;---------------------------------------------------
            ; If a row is selected, 
            ; ErrorLevel will contain a "S" in its string.
            ;
            ; If a row is deselected, 
            ; ErrorLevel will contain a "s" in its string.
            ;---------------------------------------------------
            
            was_item_selected   := InStr(ErrorLevel, "S", CaseSensitive:=true)
            ;~ was_item_deselected := InStr(ErrorLevel, "s", CaseSensitive:=true)
            
            
            ;=====================================================================
            ;                             WARNING
            ;=====================================================================
            ;
            ;    Additionally using else if(was_item_deselected)... branches:
            ;  
            ;       will sometimes (randomly) incorrectly break 
            ;       the "Edit Action" / "Delete Action" buttons 
            ;       when the user has selected a valid, editable Action entry. 
            ;  
            ;    This is due to rapid calling of ListView 
            ;    event functions, and the lag in response time
            ;    will sometimes result in the program glitching into a 
            ;    state desynchronized with the logic here.
            ;  
            ;    The following if logic was therefore carefully chosen:
            ;    
            ;    (A)  It always enables the buttons when a valid entry is selected
            ;         (without the same event triggering any other code branches)
            ;  
            ;    (B)  It only calls disable when either:
            ;         - all entries are deselected or
            ;         - an entry for QUIT or SETTINGS is selected
            ;         (without the same event triggering any other code branches)
            ;  
            ;  
            ;  As great as AutoHotkey is for simple User Interfaces, 
            ;  this is perhaps its biggest shortcoming.
            ;
            ;  When you've debugged your code, but you're still 
            ;  encountering unexpected behavior, look to your Event functions.
            ;=====================================================================
            
            
            ;--------------------------------------------------------------
            ; If QUIT or SETTINGS selected, disable edit + delete buttons.
            ; If anything else selected, enable edit + delete buttons.
            ;
_____IF_DETAILS_BEGIN_____4t_ if( was_item_selected ){ _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____5t_ if( "QUIT"     != sel_act_id 
               and "SETTINGS" != sel_act_id ){ _____SUMMARY_END_____
                  GuiConfigMain.Fn_Action_Buttons_Enable()
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  allow_run := false 
_____IF_DETAILS_BEGIN_____6t_ if( "QUIT" == sel_act_id ){ _____SUMMARY_END_____
                     allow_run := true
                  } _____DETAILS_END_____
                  GuiConfigMain.Fn_Action_Buttons_Disable( allow_run )
               } _____DETAILS_END_____
            } _____DETAILS_END_____
            
            ;---------------------------------
            ; If nothing is selected
            ; disable edit + delete buttons.
            ;
_____IF_DETAILS_BEGIN_____4t_ if( 0 == LV_GetNext(0) ){ _____SUMMARY_END_____
               GuiConfigMain.Fn_Action_Buttons_Disable()               
            } _____DETAILS_END_____
            
            
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_ListViewCommands() { _____SUMMARY_END_____
   global
      
      ;-----------------------------------------------------
      ; If events are being triggered
      ; while the popup is altering or inserting new entries
      ; ignore event.
      ;
_____IF_DETAILS_BEGIN_____2t_ if("" != _o_Gui_Config_Popup ){ _____SUMMARY_END_____
         return
      } _____DETAILS_END_____
      
      ;------------------------------------------
      ; If Gui not initialized yet, 
      ; don't respond to checkmark events.
      ;
_____IF_DETAILS_BEGIN_____2t_ if(false == GuiConfigMain._is_gui_baked){ _____SUMMARY_END_____
         return
      } _____DETAILS_END_____
      
      ;-----------------------------------
      ; User Double-Clicked 
      ; either a row or a blank space.
      ;
_____IF_DETAILS_BEGIN_____2t_ if ( "DoubleClick" = A_GuiEvent )
      { _____SUMMARY_END_____
         GuiConfigMain.Create_Popup("command")
      } _____DETAILS_END_____

      ;--------------------------------------
      ; user has edited first field of a row 
      ;
_____IF_DETAILS_BEGIN_____2t_ if ( "e" = A_GuiEvent )
      { _____SUMMARY_END_____
         GuiConfigMain.ListViewCommands_ReadjustAllCols()
      } _____DETAILS_END_____

      ;--------------------------
      ; An Item Changed
      ;
_____IF_DETAILS_BEGIN_____2t_ if ( "I" = A_GuiEvent ){ _____SUMMARY_END_____
         
         ;===================================================
         ; ENABLE / DISABLE state changed for a Command
         ;===================================================
         
         ;-------------------------------------------
         ; Event was either Checkmark (C) or Uncheckmark (c)
         ;
_____IF_DETAILS_BEGIN_____3t_ if( InStr(ErrorLevel, "c") ){             _____SUMMARY_END_____
            
            ; Tells future ListView operations to operate on this specific ListView control
            GuiConfigMain.ListViewCommands_Activate()
         
            ;-------------------------------------------
            ; Get command for that row in the ListView 
            ;
            cmd := ""
            LV_GetText(cmd, A_EventInfo,1)
            
            ;---------------------------------------------------
            ; If a row is selected, 
            ; ErrorLevel will contain a "S" in its string.
            ;
            ; If a row is deselected, 
            ; ErrorLevel will contain a "s" in its string.
            ;---------------------------------------------------
            
            was_item_checked := InStr(ErrorLevel, "C", CaseSensitive:=true)
            was_item_unchecked := InStr(ErrorLevel, "c", CaseSensitive:=true)
            
_____IF_DETAILS_BEGIN_____4t_ if( was_item_checked ){ _____SUMMARY_END_____
               GuiConfigMain.Fn_EnableCommand( cmd )
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ if( was_item_unchecked ){ _____SUMMARY_END_____
               GuiConfigMain.Fn_DisableCommand( cmd )
            }                _____DETAILS_END_____
            
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonRunAction() { _____SUMMARY_END_____
   global run_action_id
   
      GuiConfigMain.ListViewActions_Activate()
      
      which_row := LV_GetNext(0)      
      
_____IF_DETAILS_BEGIN_____2t_ if( 0 != which_row ){ _____SUMMARY_END_____
         LV_GetText(action_id_is, which_row, 1)
         run_action_id := action_id_is 
         gosub RunActionID
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonNewAction() { _____SUMMARY_END_____
   global

      ; GuiConfigMain.Create_Popup_Action_Add()
      GuiConfigMain.Create_Popup("action", "add")

      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonEditAction() { _____SUMMARY_END_____
   global
   
      GuiConfigMain.Create_Popup("action", "edit")
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonDeleteAction() { _____SUMMARY_END_____
   global
   
      GuiConfigMain.ListViewActions_Activate()
      
      ;===============================================
      ; Get the row# of the selected ListView item.
      ;===============================================
      
      which_row := LV_GetNext(0)
      
_____IF_DETAILS_BEGIN_____2t_ if( 0 == which_row ){ _____SUMMARY_END_____
         ; User pressed Delete Action button with no selection.
         return
      } _____DETAILS_END_____
      
      action_id := ""
      LV_GetText(action_id, which_row, 1)
      
      
      aID   := action_id
      aType := _ACTIONS[aID]["type"]
      aPath := _ACTIONS[aID]["path"]
      aArg  := _ACTIONS[aID]["arg"]
      
      ;~ ar_cmds_which_use_this_action     := []
      string_cmds_which_use_this_action := ""
      
_____IF_DETAILS_BEGIN_____2t_ for cmd, cmd_dat in _COMMANDS{ _____SUMMARY_END_____
         
_____IF_DETAILS_BEGIN_____3t_ if( aID == cmd_dat["action_id"] ){ _____SUMMARY_END_____
            ; msgbox command has aid [%aID%]
            ;~ ar_cmds_which_use_this_action.Push(cmd)
            string_cmds_which_use_this_action .= cmd "`n`n"
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      
      msgbox_type_ok_cancel := 1
      msgbox_icon_question  := 32
      msgbox_default_button := 256
      
      msgbox_options := msgbox_type_ok_cancel
                  + msgbox_icon_question
                  + msgbox_default_button
      
      
      
      msgbox_prompt :=  ""
      msgbox_prompt  .= "Delete Action[" aID "] ?`n`n"
      msgbox_prompt  .= "    Type:`t" aType "`n"
      msgbox_prompt  .= "    Path:`t" aPath "`n"
      msgbox_prompt  .= ("" != aArg) 
                     ? "    Arg:`t" aArg 
                     : ""
      
      msgbox_prompt  .= "`n`n"
      
      msgbox_prompt  .= "(This Action and any Commands which use it`n"
      msgbox_prompt  .= "  will all be erased from your savefile.)`n`n"
                  
      ;~ if( ar_cmds_which_use_this_action.Count() > 0 )
_____IF_DETAILS_BEGIN_____2t_ if( StrLen(string_cmds_which_use_this_action) > 0 ){ _____SUMMARY_END_____
         msgbox_prompt  .= "`n"
         msgbox_prompt  .= "------------------------------------------------------`n"
         msgbox_prompt  .= "WARNING    `n`n"
         msgbox_prompt  .= "The following Commands use Action[" aID "]`n"
         msgbox_prompt  .= "and will also be deleted: `n"
         msgbox_prompt  .= "------------------------------------------------------`n`n"
         msgbox_prompt  .= string_cmds_which_use_this_action
         
      } _____DETAILS_END_____
                     
      
      msgbox_title := "DELETE"
      
      MsgBox, % msgbox_options, % msgbox_title, %msgbox_prompt%
      
      IfMsgBox, Cancel
         return 
_____IF_DETAILS_BEGIN_____2t_ IfMsgBox, OK
      { _____SUMMARY_END_____
         ; delete all cmds in string_cmds_which_use_this_action
         ; delete action
         
_____IF_DETAILS_BEGIN_____3t_ if( StrLen(string_cmds_which_use_this_action) > 0 ){ _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____4t_ Loop, Parse, string_cmds_which_use_this_action, `n`n
            { _____SUMMARY_END_____
               GuiConfigMain.Fn_DeleteCommand( A_LoopField )
            } _____DETAILS_END_____
         } _____DETAILS_END_____
         
         GuiConfigMain.Fn_DeleteAction( aID )
      
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Fn_Action_Buttons_Enable() { _____SUMMARY_END_____
   
      GuiConfigMain.ListViewActions_Activate()
      GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonEditAction
      GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonDeleteAction
      GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonRunAction
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Fn_Action_Buttons_Disable( flag_allow_run:=false ) { _____SUMMARY_END_____
   
      GuiConfigMain.ListViewActions_Activate()
      GuiControl, ConfigMain: Disable, GuiConfigMain_ButtonEditAction
      GuiControl, ConfigMain: Disable, GuiConfigMain_ButtonDeleteAction
      
_____IF_DETAILS_BEGIN_____2t_ if(false == flag_allow_run){ _____SUMMARY_END_____
         GuiControl, ConfigMain: Disable, GuiConfigMain_ButtonRunAction
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonRunAction         
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonNewCmd() { _____SUMMARY_END_____
   global

      ; GuiConfigMain.Create_Popup_Command_Add()
      GuiConfigMain.Create_Popup("command", "add")
      
   return 
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonEditCmd() { _____SUMMARY_END_____
   global
   
      GuiConfigMain.Create_Popup("command", "edit")
      
      return
   } _____DETAILS_END_____

; [~] TODO: new option checkbox: Show confirmation warning before deleting an Action or Command.

_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonDeleteCmd() { _____SUMMARY_END_____
   global
   
      GuiConfigMain.ListViewCommands_Activate()
      
      ;===============================================
      ; Get the row# of the selected ListView item.
      ;===============================================
      
      which_row := LV_GetNext(0)
      
_____IF_DETAILS_BEGIN_____2t_ if( 0 == which_row ){ _____SUMMARY_END_____
         ; User pressed Delete Command button with no selection.
         return
      } _____DETAILS_END_____
      
      cmd_txt := ""
      LV_GetText(cmd_txt, which_row, 1)
      
      msgbox_type_ok_cancel := 1
      msgbox_icon_question  := 32
      msgbox_default_button := 256
      
      msgbox_options := msgbox_type_ok_cancel
                  + msgbox_icon_question
                  + msgbox_default_button
      
      msgbox_prompt :=  ""
      msgbox_prompt  .= "Delete the following Command?`n`n"
      msgbox_prompt  .= "`t" cmd_txt "`n`n`n"
      msgbox_prompt  .= "( This Command will be erased from your savefile,`n"
      msgbox_prompt  .= "  but its Action will not be removed. )`n`n"
      
      msgbox_title := "DELETE"
      MsgBox, % msgbox_options, % msgbox_title, %msgbox_prompt%
      
      IfMsgBox, Cancel
         return 
         
      IfMsgBox, OK
         GuiConfigMain.Fn_DeleteCommand( cmd_txt )
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Fn_Command_Buttons_Enable() { _____SUMMARY_END_____
   
      GuiConfigMain.ListViewCommands_Activate()
      GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonEditCommand
      GuiControl, ConfigMain: Enable, GuiConfigMain_ButtonDeleteCommand
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Fn_Command_Buttons_Disable() { _____SUMMARY_END_____
   
      GuiConfigMain.ListViewCommands_Activate()
      GuiControl, ConfigMain: Disable, GuiConfigMain_ButtonEditCommand
      GuiControl, ConfigMain: Disable, GuiConfigMain_ButtonDeleteCommand
      
      return
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_CheckboxShowAll() { _____SUMMARY_END_____
   global

      ;----------------------------------------------------
      ; Change label depending on state.
      ;----------------------------------------------------
      ;
      ; When Checkbox is on, 
      ;
      ; - ListView will display: 
      ;   all Commands
      ;
      ; - GuiConfigMain_CheckboxShowAll will display text:
      ;   SHOW ALL   (Uncheck to hide disabled commands)
      ;
      ; When Checkbox is off 
      ;
      ; - ListView will display: 
      ;   only enabled Commands
      ;
      ; - GuiConfigMain_CheckboxShowAll will display text:
      ;   SHOW ALL   (Check to also show disabled commands)
      ;
      ;----------------------------------------------------
      
      GuiControlGet,show_all_state,, GuiConfigMain_CheckboxShowAll
      
_____IF_DETAILS_BEGIN_____2t_ if( show_all_state ){ _____SUMMARY_END_____
         txt := GuiConfigMain.CheckboxShowAll_TextForChecked
         
         GuiConfigMain.ListViewCommands_ShowAll()
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else{ _____SUMMARY_END_____
         txt := GuiConfigMain.CheckboxShowAll_TextForUnchecked
         
         GuiConfigMain.ListViewCommands_ShowOnlyEnabled()
      } _____DETAILS_END_____
      
      GuiControl,, GuiConfigMain_CheckboxShowAll, %txt%
      
      return
   } _____DETAILS_END_____

   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Settings_ButtonIcon() { _____SUMMARY_END_____
   global 
   
_____IF_DETAILS_BEGIN_____2t_ if( "" == _o_Gui_Config_IconPicker ){ _____SUMMARY_END_____
         _o_Gui_Config_IconPicker := new GuiConfigIconPicker()
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Settings_ButtonExport() { _____SUMMARY_END_____
   global
   
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Settings_ButtonImportAsDisabled() { _____SUMMARY_END_____
   global
   
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Settings_ButtonImportAsEnabled() { _____SUMMARY_END_____
   global
   
      return
   } _____DETAILS_END_____
   
   


_____DETAILS_BEGIN_____1t_ ListViewActions_Activate() { _____SUMMARY_END_____
   global
      ;
      ; Word of warning:
      ; In this current implementation, OnSize() 
      ; will readjust the columns on a resize 
      ; (to prevent horizontal scrollbar when not needed).
      ;
      ; Be sure to call ListViewActions_Activate() 
      ;  or             ListViewCommands_Activate
      ; before any AutoHotkey ListView function.
      ;--------------------------------------------
      
      
      ;--------------------------------------------------------------------;
      ; This line ensures "Gui, " commands operate on the main GUI window  ;
      ;--------------------------------------------------------------------;
      Gui, ConfigMain:Default

      ;---------------------------------------------------;
      ; This line ensures ListView commands "LV_..()"     ;
      ; operate on this specific ListView                 ;
      ;---------------------------------------------------;
      Gui, ConfigMain:ListView, GuiConfigMain_ListViewActions
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ ListViewActions_ReadjustAllCols() { _____SUMMARY_END_____
   global
   
      ; see notes above in GuiConfigMain.ListViewCommands_ReadjustAllCols()
      
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewActions_Activate()
      
      ; Adjust all column widths to fit all contents without trailing "..."
      LV_ModifyCol(1,"AutoHdr")
      LV_ModifyCol(2,"AutoHdr")
      LV_ModifyCol(3,"AutoHdr")
      LV_ModifyCol(4,"AutoHdr")
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ ListViewActions_AddNewAction( p_actionID, p_actionType, p_actionPath, p_actionArg ) { _____SUMMARY_END_____
   global 
      
      ; msgBOX id[%p_actionID%] type[%p_actionType%] path[%p_actionPath%] ar[%p_actionArg%]
      
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewActions_Activate()
      
      options := "" 
      
      ; msgBOX %success%
      
      LV_Add( options
         , p_actionID
         , p_actionType
         , p_actionPath
         , p_actionArg )
      
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ ListViewCommands_Activate() { _____SUMMARY_END_____
   global
      ;
      ; Word of warning:
      ; In this current implementation, OnSize() 
      ; will readjust the columns on a resize 
      ; (to prevent horizontal scrollbar when not needed).
      ;
      ; Be sure to call ListViewActions_Activate() 
      ;  or             ListViewCommands_Activate
      ; before any AutoHotkey ListView function.
      ;--------------------------------------------
      
      ;--------------------------------------------------------------------;
      ; This line ensures "Gui, " commands operate on the main GUI window  ;
      ;--------------------------------------------------------------------;
      
      Gui, ConfigMain:Default

      ;---------------------------------------------------;
      ; This line ensures ListView commands "LV_..()"     ;
      ; operate on this specific ListView                 ;
      ;---------------------------------------------------;
      
      Gui, ConfigMain:ListView, GuiConfigMain_ListViewCmds
      
      
      ;----------------------------------------------------------------
      ; see:                                                          
      ; https://www.autohotkey.com/docs/commands/Gui.htm#MultiWin     
      ; https://www.autohotkey.com/docs/commands/Gui.htm#Default      
      ; https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn 
      ;----------------------------------------------------------------

      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ ListViewCommands_ReadjustAllCols() { _____SUMMARY_END_____
   global

      ;-----------------------------------------------------------
      ; These lines ensure the next ListView function ("LV_...()")
      ; will specifically use GuiConfigMain's ListView for Commands
      ;-----------------------------------------------------------
      
      GuiConfigMain.ListViewCommands_Activate()
      
      ;-------------------------------------------------------------------
      ; AutoHotkey Docs for ListView, ModifyCol, AutoHdr
      ;-------------------------------------------------------------------
      ; AutoHdr: 
      ;   Adjusts the column's width to fit 
      ;   its contents and the column's header text, 
      ;   whichever is wider. 
      ;-------------------------------------------------------------------
      ; https://www.autohotkey.com/docs/commands/ListView.htm#LV_ModifyCol
      ;-------------------------------------------------------------------
      
      LV_ModifyCol(1,"AutoHdr")
      LV_ModifyCol(2,"AutoHdr")
      LV_ModifyCol(3,"AutoHdr")
      LV_ModifyCol(4,"AutoHdr")
      LV_ModifyCol(5,"AutoHdr")
      LV_ModifyCol(6,"AutoHdr")
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ ListViewCommands_ShowOnlyEnabled() { _____SUMMARY_END_____
   global   
   
      ;------------------------------------------------------------------------------
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewCommands_Activate()
      
      i_lv_rows := LV_GetCount()
      ;-----------------------
      ; iterate ListView items
_____IF_DETAILS_BEGIN_____2t_ while(i_lv_rows > 0)
      { _____SUMMARY_END_____
         ;----------------------------------
         ; get the cmd in each ListView row
         LV_GetText(cmd, i_lv_rows)
         
         ;-----------------------------------------
         ; ensure cmd is present in _COMMANDS array 
_____IF_DETAILS_BEGIN_____3t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
            ; msgbox has key [%cmd%]
            ; if the Command is disabled,  
            ; then remove that Command's ListView entry
_____IF_DETAILS_BEGIN_____4t_ if( false == _COMMANDS[cmd]["enabled"] ){ _____SUMMARY_END_____
               LV_Delete( i_lv_rows )
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
         
         i_lv_rows := i_lv_rows - 1
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ ListViewCommands_ShowAll() { _____SUMMARY_END_____
   global
   
      ;------------------------------------------------------------------------------
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewCommands_Activate()
      
      ar_enabled := {}
      
      ;-----------------------
      ; iterate ListView items
_____IF_DETAILS_BEGIN_____2t_ Loop % LV_GetCount()
      { _____SUMMARY_END_____
         ;----------------------------------
         ; get the cmd in each ListView row
         LV_GetText(cmd, A_Index)
         
         ar_enabled[cmd] := true
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ for cmd, cmd_data in _COMMANDS { _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____3t_ if ar_enabled.HasKey(cmd){ _____SUMMARY_END_____
            continue
         } _____DETAILS_END_____
         
         lv_cmd_options := (true==cmd_data["enabled"]) ? "+Check" : "-Check"
         
         cmd_action_id  := cmd_data["action_id"]
         action_type    := _ACTIONS[cmd_action_id]["type"]
         action_path    := _ACTIONS[cmd_action_id]["path"]
         action_arg     := _ACTIONS[cmd_action_id]["arg"]
         
         LV_Add(lv_cmd_options   ; Check row if Command is enabled
            , cmd                 ; row 1
            , ""                  ; row 2
            , cmd_action_id       ; row 3
            , action_type         ; row 4
            , action_path         ; row 5
            , action_arg )        ; row 6
                  
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ ListViewCommands_UpdateAllWhichUseAction( p_actionID ) { _____SUMMARY_END_____
   global   
   
      aID   := p_actionID
      aType := _ACTIONS[aID]["type"]
      aPath := _ACTIONS[aID]["path"]
      aArg  := _ACTIONS[aID]["arg"]
      
      msgBOX id[%aID%] type[%aType%] path[%aPath%]
      
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewCommands_Activate()
      
      ; iterate ListView items
_____IF_DETAILS_BEGIN_____2t_ Loop % LV_GetCount()
      { _____SUMMARY_END_____
         ; get the cmd in each ListView row
         LV_GetText(cmd, A_Index)
         
         ; ensure cmd is present in _COMMANDS array 
_____IF_DETAILS_BEGIN_____3t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
         
            ; if the Command uses this updated Action 
            ; then update that Command's ListView entry with updated Action config
_____IF_DETAILS_BEGIN_____4t_ if( aID == _COMMANDS[cmd]["action_id"] ){ _____SUMMARY_END_____
               
               ;------------------------------------------------------
               ; AutoHotkey Docs, Ternary Operator: 
               ; https://www.autohotkey.com/docs/Variables.htm#ternary
               ;
               lv_cmd_options := (true==_COMMANDS[cmd]["enabled"]) ? "+Check" : "-Check"
               
               LV_Modify(A_Index
                  , lv_cmd_options     ; no options
                  , cmd                 ; row 1
                  ,                     ; row 2 is always empty
                  , aID                 ; row 3
                  , aType               ; row 4
                  , aPath               ; row 5
                  , aArg        )       ; row 6        
                  
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      return 
   } _____DETAILS_END_____



   
_____DETAILS_BEGIN_____1t_ Create_Popup(mode, purpose:="") { _____SUMMARY_END_____
   global      
   
      ; Parameters
      ;----------------------------------------------------
      ; mode    is either:    "command"  or  "action"
      ; purpose is either:        "add"  or  "edit"
      ;----------------------------------------------------
      
      plural := ("command"=mode) ? "Commands"   : "Actions"
      caps   := ("command"=mode) ? "Command"    : "Action"
      AR     := ("command"=mode) ? "_COMMANDS"  : "_ACTIONS"
      
      
      
      ;-----------------------------------------------------------------
      ; Here, ensure the next ListView function ("LV_...()")
      ; will specifically use the appropriate ListView in GuiConfigMain
      ;-----------------------------------------------------------------
      
      
_____COMMENT_DETAILS_BEGIN_____4t_ ;====================================================================
            ;
            ; Note:
            ;
            ; AutoHotkey Info : Dynamically Calling + Function References
            ;
            ;==================================================================== _____COMMENT_SUMMARY_END_____
            ;
            ; The line `GuiConfigMain[fn]()` will call one of these two functions
            ;
            ;    GuiConfigMain.ListViewCommands_Activate()
            ;    GuiConfigMain.ListViewActions_Activate()
            ;====================================================================
            ;
            ; Read more about how this works: 
            ;
            ;    https://www.autohotkey.com/boards/viewtopic.php?t=6354
            ;    https://www.autohotkey.com/docs/Objects.htm#Function_References
            ;    https://www.autohotkey.com/docs/Objects.htm#Usage_Objects 
            ;      -> end of first section begins with `x.y[z]()` example.
            ;==================================================================== _____COMMENT_DETAILS_END_____
            ;
      fn := "ListView" plural "_Activate"
      GuiConfigMain[fn]()
         
      
_____IF_DETAILS_BEGIN_____2t_ if("" == purpose){ _____SUMMARY_END_____
      
_____COMMENT_DETAILS_BEGIN_____3t_ ;-----------------------------------------------------------
         ; If LV_GetNext(0) succeeds, then a row is selected. 
         ;----------------------------------------------------------- _____COMMENT_SUMMARY_END_____
         ; The user either hit <Enter> or double-clicked that row.
         ; An "Edit Action/Command" popup will appear for this item.
         ;
         ;-----------------------------------------------------------
         ; If LV_GetNext(0) fails, then there is no selection.
         ;-----------------------------------------------------------
         ; The user either hit <Enter> w/o a selection or 
         ; double-clicked a blank area, not a row.
         ; A "New Action/Command" popup will appear.
         ;----------------------------------------------------------- _____COMMENT_DETAILS_END_____
         
_____IF_DETAILS_BEGIN_____3t_ if( 0 != LV_GetNext(0) ){ _____SUMMARY_END_____
            purpose := "edit"
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else{ _____SUMMARY_END_____
            purpose := "add"            
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ if( "command" == mode
      or  "action"  == mode)
      { _____SUMMARY_END_____
      
         ;=============================================
         ;   Create Popup to Add a (Command or Action)
         ;=============================================
_____IF_DETAILS_BEGIN_____3t_ if( "add" == purpose ){ _____SUMMARY_END_____
         
            ;------------------------------------------
            ; Create Popup, 
            ; if this global var is empty.
            ;------------------------------------------
            ;
_____IF_DETAILS_BEGIN_____4t_ if( _o_Gui_Config_Popup == "" ){ _____SUMMARY_END_____
               _o_Gui_Config_Popup := new GuiConfigPopup(mode, "add")
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ else{ ;error; _____SUMMARY_END_____
               MsgBox, 16,  [ PROGRAM ERROR ], % "Whoops, big bug, a Popup is already open!`n"
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
         ;=============================================
         ;   Create Popup to Edit a (Command or Action)
         ;=============================================
_____IF_DETAILS_BEGIN_____3t_ else 
         if( "edit" == purpose ){ _____SUMMARY_END_____
            
            
            ;===============================================
            ; Get the row# of the selected ListView item.
            ;===============================================
            
            which_row := LV_GetNext(0)
            
            
            ;================================
            ; Exit if no selection to edit.
            ;================================
            
_____IF_DETAILS_BEGIN_____4t_ if( 0 == which_row ){ _____SUMMARY_END_____
               
               return   ; User pressed "Edit Selected..." Button
                      ; with no selection. 
                      ; Ignore. 
            } _____DETAILS_END_____
            
            
            ;===============================================
            ; Get the selected row's 1st column, either: 
            ;   - the Action's  ID
            ;   - the Command's text
            ;===============================================
            
            LV_GetText(aID_or_cmd, which_row, 1)
            
            
_____COMMENT_DETAILS_BEGIN_____4t_ ;--------------------------------------------------------------
            ; AutoHotkey Info, using a %variable_name% stored in a string
            ;-------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
            ; Here, I'd like to showcase a language feature of AutoHotkey, 
            ; 
            ; where you can %resolve% a variable stored in a string 
            ; in order to dynamically change the variable a line uses.
            ;
            ; 
            ; The following logic :
            ; 
            ;    AR := ("command" == mode) ? "_COMMANDS" : "_ACTIONS"
            ;
            ;    if( %AR%.HasKey(aID_or_cmd) ){ .. }
            ;    
            ; serves to dynamically turn this if branch 
            ; into the following:
            ;    
            ;    if(  _ACTIONS.HasKey(row_cmd) ){ .. }
            ;    if( _COMMANDS.HasKey(row_cmd) ){ .. }
            ;    
            ;--------------------------------------------------------------
            ;    
            ; However, the following if branch 
            ; can alternatively be replaced with this instead :
            ; 
            ;    if("command" == mode){
            ;       valid_key := _COMMANDS.HasKey(row_cmd)
            ;    }
            ;    if("action" == mode){
            ;       valid_key := _ACTIONS.HasKey(row_cmd)
            ;    }
            ;    if( valid_key ){ ... }
            ;
            ;--------------------------------------------------------------
            ; AutoHotkey docs:
            ;
            ; https://www.autohotkey.com/docs/Functions.htm#DynCall
            ; https://www.autohotkey.com/docs/Variables.htm#operators
            ;               (see %Var% in the operators table ^)
            ;-------------------------------------------------------------- _____COMMENT_DETAILS_END_____
            
            ;===============================================
            ; Ensure the row is still valid in main array
            ;===============================================
            
            AR := ("command" == mode) ? "_COMMANDS" : "_ACTIONS"
            
_____IF_DETAILS_BEGIN_____4t_ if( %AR%.HasKey( aID_or_cmd ) ){ _____SUMMARY_END_____
               
               
               ;===============================================
               ; Store the (Action or Command)'s ListView data 
               ; for the Popup to access.
               ;===============================================
               
               row_dat := GuiConfigMain.Get_Associative_Array_Of_Selected_LV_Row_Data(which_row)
               
               
               ;==============================================================
               ; Pluck command for editing 
               ;   ( more details in Pluck_Selected_Command_From_COMMANDS() )
               ;==============================================================               
               
               ;-------------------------------------------------------------
               ; Call either 
               ;
               ;       GuiConfigMain.Pluck_Selected_Command_From_COMMANDS() 
               ;    or GuiConfigMain.Pluck_Selected_Action_From_ACTIONS()
               ;
               ;-------------------------------------------------------------
               ; See above note on Dynamically Calling Function References 
               ;-------------------------------------------------------------
               
               fn := "Pluck_Selected_" caps "_From" AR 
               GuiConfigMain[fn]( aID_or_cmd )
               
               
               ;=======================================;
               ;     Create Popup  :  Command Edit     ;
               ;=======================================;
               
_____IF_DETAILS_BEGIN_____5t_ if( _o_Gui_Config_Popup == "" ){ _____SUMMARY_END_____
                  _o_Gui_Config_Popup := new GuiConfigPopup(mode, "edit", row_dat)
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else{ ;then bug; _____SUMMARY_END_____
                  MsgBox, 16,  [ PROGRAM ERROR ], % "Whoops, a Popup is already open.`n"
               } _____DETAILS_END_____
               
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ else{ ;then bug; _____SUMMARY_END_____
               debug_out := "mode[" mode "] purpose[" purpose "] `n"
               debug_out .= "Trying to open config Popup window, `n"
               debug_out .= "but array " AR " does not have key[" aID_or_cmd "], `n"
               msgbox %debug_out%
            } _____DETAILS_END_____
            
         }             _____DETAILS_END_____
      
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
   
   
    
_____DETAILS_BEGIN_____1t_ Pluck_Selected_Command_From_COMMANDS(p_row_cmd) { _____SUMMARY_END_____
   global 
   
_____COMMENT_DETAILS_BEGIN_____1t_ ;-------------------------------------------------------------------------
   ; Note
   ;-------------------------------------------------------------------------
   ;
   ; _COMMANDS and _ACTIONS, keys + values, and edit Popups : 
   ;
   ;   On creating a Popup with purpose "edit", 
   ;   for either popup mode "action" or popup mode "command"
   ;   remove the entry from _ACTIONS or _COMMANDS.
   ;
   ;   Later after either (user cancels or user submits) the popup,
   ;   add the key + value back into _ACTIONS or _COMMANDS 
   ;   (which is potentially the same, or potentially entirely modified).
   ;
   ;------------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ; Why this implementation?
   ;-------------------------------------------------------------------------
   ;
   ; Short answer:
   ;
   ;   As with all algorithms, there's many ways to accomplish the same thing.
   ;   I liked the simplicity of implementation of this direction most.
   ;
   ;-------------------------------------------------------------------------
   ;
   ; Explanation:
   ;
   ;   When a preexisting Action or Command is edited, 
   ;   this implementation removes it from the main internal array 
   ;   which holds all the _ACTIONS{} or _COMMANDS{} at runtime.
   ;
   ;   Later, when a popup submits the user's edited changes, 
   ;   first the app checks the _COMMANDS or _ACTIONS array for conflicts
   ;   (depending on whether the _popup_mode is "command" or "action").
   ;   
   ;   Since no two Commands will ever have the same text, and 
   ;   since no two Actions will ever have exactly the same path data, and
   ;   since the app always removes the edited key value pair from 
   ;   _COMMANDS or _ARRAYS before editing, 
   ;   this not-a-duplicate verification can use the same logic 
   ;   as the logic for adding a new Command or Action.
   ;
   ; Benefit:
   ;
   ;   For instance, if the user edits a Command, and renames the Command, 
   ;   there's no need for additional logic which checks _COMMANDS 
   ;   for the old command key, compares it to what is potentially a new key 
   ;   then additionally checks for preexisting other Commands with the same key.
   ;
   ;   In this current implementation, since we remove the key upfront,
   ;   if the key doesn't exist, 
   ;      then we can immediately add it in, 
   ;      regardless of whether it's edited or brand new.
   ;
   ;   If the Command keeps the same name and only changes the Action configuration
   ;   then the key which was plucked from _COMMANDS can be added back in 
   ;   with a slightly different value for the corresponding Action data to trigger.
   ;   And no other logic is needed other than `if(!_COMMANDS.HasKey(cmd))`.
   ;
   ; Tradeoff:
   ;
   ;   This current design choice potentially has the drawback 
   ;   of being unintuitive at a glance, 
   ;   but the benefit of the simplicity of verification logic 
   ;   was appealing enough to me to go this route. 
   ;
   ;------------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
   
_____COMMENT_DETAILS_BEGIN_____2t_ ;=================================================================
      ; Pluck and save current row's command data                       
      ; from _COMMANDS array                                            
      ; into _plucked_command variable.                                 
      ;================================================================= _____COMMENT_SUMMARY_END_____
      ; How _plucked_command will be used:                              
      ;                                                                 
      ;   If user cancels,                                              
      ;     when GuiConfigPopup is closed                               
      ;     GUI_EVENT_GuiConfigPopup_OnClose will use _plucked_command  
      ;     to restore the command to the _COMMANDS array.              
      ;                                                                 
      ;   If user submits an edited command,                          
      ;     we'll assign new command data to the _COMMANDS array,       
      ;     and make _plucked_command empty to prevent                  
      ;       GUI_EVENT_GuiConfigPopup_OnClose from restoring it.         
      ;================================================================= _____COMMENT_DETAILS_END_____
      
      
      GuiConfigMain._plucked_command := { "" 
         .   "command":   p_row_cmd
           , "enabled":   _COMMANDS[p_row_cmd]["enabled"]
           , "action_id": _COMMANDS[p_row_cmd]["action_id"] }   
      
      ;-----------------------------------------------------------
      ; Deletes from the array storing all our Commands. 
      ;-----------------------------------------------------------
      ; Doing this allows both Popup->EditCmd + Popup->AddCmd 
      ; to use the same logic (_COMMANDS.HasKey()) to ensure
      ; the user's input won't become a duplicate entry.
      ;      
      _COMMANDS.Delete(p_row_cmd)
      
      return
   }    _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Discard_Plucked_Command() { _____SUMMARY_END_____
   global 
   
      ;----------------------------------------
      ; Remove backup of (now) edited command
      ;----------------------------------------
      ; Making this variable empty will prevent 
      ;
      ;   GUI_EVENT_GuiConfigPopup_OnClose and
      ;   GUI_EVENT_GuiConfigPopup_OnEscape
      ;
      ; from automatically restoring 
      ; the old version of this Command
      ;
      ; when the GuiConfigPopup GUI is closed.
      ;----------------------------------------
      
      GuiConfigMain._plucked_command := ""
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Restore_Plucked_Command_If_User_Cancelled() { _____SUMMARY_END_____
   global 
   
      ;-----------------------------------------------------------
      ; If user cancelled out of the GuiConfigPopup GUI
      ; then restore the original Command to the _COMMANDS array.
      ;-----------------------------------------------------------
      
_____IF_DETAILS_BEGIN_____2t_ if( "" != GuiConfigMain._plucked_command )
      { _____SUMMARY_END_____
         cmd        := GuiConfigMain._plucked_command["command"]
         is_enabled := GuiConfigMain._plucked_command["enabled"]
         aID        := GuiConfigMain._plucked_command["action_id"]
         
         _COMMANDS[cmd] := { "action_id":aID, "enabled":is_enabled }
         
         GuiConfigMain._plucked_command := ""
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

   
_____DETAILS_BEGIN_____1t_ Pluck_Selected_Action_From_ACTIONS(p_action_id) { _____SUMMARY_END_____
   global 
   
      ;------------------------------------------------------------
      ; same as GuiConfigMain.Pluck_Selected_Command_From_COMMANDS
      ;------------------------------------------------------------
      
      GuiConfigMain._plucked_action := { ""
         .   "action_id"  : p_action_id
           , "action_type": _ACTIONS[p_action_id]["type"]
           , "action_path": _ACTIONS[p_action_id]["path"]
           , "action_arg" : _ACTIONS[p_action_id]["arg"]   }
           
      _ACTIONS.Delete(p_action_id)
      
      return
   }    _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Discard_Plucked_Action() { _____SUMMARY_END_____
   global 
      GuiConfigMain._plucked_action := ""
      return
   }    _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Restore_Plucked_Action_If_User_Cancelled() { _____SUMMARY_END_____
   global 
      ;-----------------------------------------------------------
      ; If user cancelled out of the GuiConfigPopup GUI
      ; then restore the original Command to the _COMMANDS array.
      ;-----------------------------------------------------------
      
_____IF_DETAILS_BEGIN_____2t_ if( "" != GuiConfigMain._plucked_action )
      { _____SUMMARY_END_____
         aID   := GuiConfigMain._plucked_action["action_id"]
         aType := GuiConfigMain._plucked_action["action_type"]
         aPath := GuiConfigMain._plucked_action["action_path"]
         aArg  := GuiConfigMain._plucked_action["action_arg"]
         
         _ACTIONS[aID] := {"type":aType, "path":aPath, "arg":aArg}
         
         GuiConfigMain._plucked_action := ""
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____


   ;-------------------------------------------------------------------
   ; Only called for "edit" Popups, either mode ("action" or "command")
   ;
_____DETAILS_BEGIN_____1t_ Get_Associative_Array_Of_Selected_LV_Row_Data( selected_row ) { _____SUMMARY_END_____
   global 
   local  got_cmd, got_cmd_is_enabled 
   local  got_actionId, got_actionType, got_actionType, got_actionArg
   
_____COMMENT_DETAILS_BEGIN_____2t_ ;-----------------------------------------------------
      ; Parameter: selected_row
      ;----------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ;
      ; - ListView row ID (integer)
      ;   for the active ListView in GuiConfigMain
      ;   (either a row in GuiConfigMain_ListViewActions
      ;                 or GuiConfigMain_ListViewCmds).
      ;
      ; - This function will copy that row's data,
      ;   for the "edit" Popup to read.
      ;
      ; - When the "edit" Popup "Submits" its data 
      ;   it modifies the ListView row with this ID
      ;   to reflect the edited action or command.
      ; 
      ;----------------------------------------------------- _____COMMENT_DETAILS_END_____
      
      
      ;========================================================
      ; Create the associative array to hold the row's data in
      ; for Popup to reference
      ;========================================================
      
      row_dat := {}
      
      
      ;========================================
      ; Refresh the variable GuiConfigMain_Tabs
      ; which stores the current tab name
      ;========================================
      
      Gui, ConfigMain:Submit, NoHide 
      
      
      ;========================================
      ; Copy selected ListView Row's data 
      ;========================================
      
_____IF_DETAILS_BEGIN_____2t_ if( "Actions" == GuiConfigMain_Tabs ){ _____SUMMARY_END_____
         
         GuiConfigMain.ListViewActions_Activate()
         
         got_cmd            := "" ; not used for this type of config popup 
         got_cmd_is_enabled := "" ; not used for this type of config popup 
         
         LV_GetText(got_actionID,   selected_row,1)
         LV_GetText(got_actionType, selected_row,2)
         LV_GetText(got_actionPath, selected_row,3)
         LV_GetText(got_actionArg,  selected_row,4)
         
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else if( "Commands" == GuiConfigMain_Tabs ){ _____SUMMARY_END_____
         
         GuiConfigMain.ListViewCommands_Activate()
         
_____COMMENT_DETAILS_BEGIN_____3t_ ;-----------------------------------------------------------------
         ; AutoHotkey Docs:
         ;----------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
         ; LV_GetNext(StartingRowNumber, RowType)
         ;
         ;    "... the search begins at the row after StartingRowNumber"
         ;
         ;    "If RowType is omitted, 
         ;     the function searches for the next selected/highlighted row. 
         ;     Otherwise, specify "C" or "Checked" to find the next checked row; 
         ;     or "F" or "Focused" to find the focused row ..."
         ;
         ; https://www.autohotkey.com/docs/commands/ListView.htm#LV_GetNext
         ;----------------------------------------------------------------- _____COMMENT_DETAILS_END_____
         got_cmd_is_enabled := LV_GetNext(selected_row-1, "C")
         
         LV_GetText(got_cmd,        selected_row,1)
         ; column 2 is just an arrow "->" to visually separate cmd cols from action cols
         LV_GetText(got_actionID,   selected_row,3)
         LV_GetText(got_actionType, selected_row,4)
         LV_GetText(got_actionPath, selected_row,5)
         LV_GetText(got_actionArg,  selected_row,6)
            
      
      } _____DETAILS_END_____
   
      
      ;==========================================================
      ; Initialize the row_dat array with the ListView Row data 
      ;==========================================================
   
      row_dat["LV_id"]               := selected_row
      row_dat["row_cmd"]             := got_cmd
      row_dat["row_cmd_is_enabled"]  := got_cmd_is_enabled
      row_dat["row_actionID"]        := got_actionId
      row_dat["row_actionType"]      := got_actionType
      row_dat["row_actionPath"]      := got_actionPath
      row_dat["row_actionArg"]       := got_actionArg
      
      return row_dat
   } _____DETAILS_END_____
   
   
   
   
_____DETAILS_BEGIN_____1t_ Fn_EnableCommand( cmd ) { _____SUMMARY_END_____
   global 
   
_____IF_DETAILS_BEGIN_____2t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
            
         _COMMANDS[cmd]["enabled"] := true
         
         FILE_HELPER.Change_Savefile__Enable_Command( cmd )
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Fn_DisableCommand( cmd ) { _____SUMMARY_END_____
   global 
      
_____IF_DETAILS_BEGIN_____2t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
            
         _COMMANDS[cmd]["enabled"] := false
         
         FILE_HELPER.Change_Savefile__Disable_Command( cmd )
         
         ;----------------------------------------------
         ; If user has chosen to hide disabled commands
         ; (in GuiConfigMain's Commands ListView), 
         ;
         ; then hide this Command too.
         ;----------------------------------------------
         
         GuiControlGet,show_all_state,, GuiConfigMain_CheckboxShowAll
_____IF_DETAILS_BEGIN_____3t_ if( false == show_all_state ){ _____SUMMARY_END_____
            GuiConfigMain.ListViewCommands_ShowOnlyEnabled()
         } _____DETAILS_END_____
                  
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Fn_DeleteCommand( cmd_to_delete ) { _____SUMMARY_END_____
   global 
      
      GuiConfigMain.ListViewCommands_Activate()
      
      ; iterate ListView items
_____IF_DETAILS_BEGIN_____2t_ Loop % LV_GetCount()
      { _____SUMMARY_END_____
         ; get the cmd in each ListView row
         LV_GetText(cmd, A_Index, 1)
         
         ; ensure cmd is present in _COMMANDS array 
_____IF_DETAILS_BEGIN_____3t_ if( _COMMANDS.HasKey(cmd) ){ _____SUMMARY_END_____
            
_____IF_DETAILS_BEGIN_____4t_ if( cmd_to_delete == cmd ){ _____SUMMARY_END_____
               LV_Delete( A_Index )
               
               p1 := "command"
               p2 := "delete"
               p3 := cmd
               FILE_HELPER.Change_Savefile( p1, p2, p3 )
               break
            } _____DETAILS_END_____
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Fn_DeleteAction( action_id_to_delete ) { _____SUMMARY_END_____
   global 
   
      GuiConfigMain.ListViewActions_Activate()
      
      ; iterate ListView items
_____IF_DETAILS_BEGIN_____2t_ Loop % LV_GetCount()
      { _____SUMMARY_END_____
         ; get the ID in each ListView row
         LV_GetText(actionID, A_Index, 1)
         
         ; ensure ID is present in _ACTIONS array 
_____IF_DETAILS_BEGIN_____3t_ if( _ACTIONS.HasKey(actionID) ){ _____SUMMARY_END_____
            
_____IF_DETAILS_BEGIN_____4t_ if( action_id_to_delete == actionID ){ _____SUMMARY_END_____
               LV_Delete( A_Index )
               
               p1 := "action"
               p2 := "delete"
               p3 := action_id_to_delete
               FILE_HELPER.Change_Savefile( p1, p2, p3 )
               
               break
            } _____DETAILS_END_____
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____


_____DETAILS_BEGIN_____1t_ Fn_Change_to_Settings_Tab() { _____SUMMARY_END_____
   global 
   
      text := "Commands|Actions|Settings||   ?   "
      GuiControl, ConfigMain: Choose, GuiConfigMain_Tabs, 3
      
      return 
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ Fn_Settings_SetIcon( icon_id ) { _____SUMMARY_END_____
   global _ICON_INDEX
   
      setting := {"setting_name":"icon", "new_value":icon_id}
      
      FILE_HELPER.Change_Savefile(  "setting"
                           , "edit"
                           , NA_actionCommand :=""
                           , NA_commandName   :=""
                           , setting )
      _ICON_INDEX := icon_id 
      
      Menu, Tray, Icon, Shell32.dll, %_ICON_INDEX%
      
      gosub ReloadConfigurationWindow
      
      return
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Fn_AboutTab_Get_Text(g_width:="") { _____SUMMARY_END_____
      12spaces := "           "
      3nl      := "`n`n`n"
      2nl      := "`n`n"
      1nl      := "`n"
      
      text := "" 
      
_____IF_DETAILS_BEGIN_____2t_ if( "" != g_width 
      and g_width < 585 ){ _____SUMMARY_END_____
         12spaces := "    "
      } _____DETAILS_END_____
      
      
      
         text  :=  ""
         text   .= 12spaces   
         text   .= 12spaces "   gamepad-coder.github.io "
         text   .=    3nl
         text   .= 12spaces  "===========================" 12spaces
         text   .=    2nl
         text   .= 12spaces  "   _program_launcher.ahk"
         text   .=    2nl
         text   .= 12spaces  "==========================="
         text   .=    2nl
         text   .= 12spaces  "License:"
         text   .=    1nl
         text   .= 12spaces  "Community Commons Zero"
         text   .=    2nl
      
      ; msgBOX text is `n%text%
      
      return text
   } _____DETAILS_END_____
   
   ;============================================================
   ;         end of class:
   ;         GuiConfigMain (Main Window)  
   ;============================================================
} _____DETAILS_END_____

_____DETAILS_BEGIN_____0t_ class GuiConfigIconPicker { _____SUMMARY_END_____

   ;-----------------------------------------------------
   ; Preload "ImageList" of system icons upon app start 
   ; to prevent lag when this window is launched
   ; (stored in _LV_IconList).
   ;-----------------------------------------------------
   
   static _LV_IconList := "" ; Used across multiple window instances.
   static _icon_chosen := "" ; Unique per window instance
   

_____DETAILS_BEGIN_____1t_ __New() { _____SUMMARY_END_____
   global
      
      options_for_Popup :=  A_Space "+Label" "GuiConfigIconPicker.GUI_EVENT_On"
      options_for_Popup  .= A_Space "+Resize"
      options_for_Popup  .= A_Space "+MinSize300x475"
      
      title_for_Popup_Window := "Select Icon for Program Launcher :"
        
      Gui, IconConfig:New
         , %options_for_Popup% 
         ,   %title_for_Popup_Window%


      ; Preload fn should be run during config window launch to (potentially) reduce lag.
      ;
_____IF_DETAILS_BEGIN_____2t_ if("" == GuiConfigIconPicker._LV_IconList){ _____SUMMARY_END_____
         GuiConfigIconPicker.Preload_IconList()
      } _____DETAILS_END_____
      
      GuiConfigIconPicker.Init_AddControls()
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;--------------------------------------------------------------;
      ; Temporarily disable GuiConfigMain while this popup exists.   ;
      ;--------------------------------------------------------------; _____COMMENT_SUMMARY_END_____
      ;                                                              ;
      ; GuiConfigIconPicker will be a child window of GuiConfigMain, ;
      ; which will prevent GuiConfigMain                             ;
      ; from displaying on top of this popup.                        ;
      ;--------------------------------------------------------------; _____COMMENT_DETAILS_END_____
      
      Gui, IconConfig:+OwnerConfigMain
      Gui, IconConfig: Show
      
      Gui ConfigMain: +Disabled

      return this
      
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ __Delete() { _____SUMMARY_END_____
   global
   
      ;---------------------------------------
      ; Clear static class member variable 
      ;---------------------------------------
      
      GuiConfigIconPicker._icon_chosen := ""
      
      ;-----------------------------------------------------------------
      ; Re-enable GuiConfigMain, 
      ; now that GuiConfigIconPicker no longer needs prioritized focus.
      ;-----------------------------------------------------------------
      
      Gui ConfigMain: -Disabled
      
      ;------------------------------------
      ; Destroy GuiConfigIconPicker Window
      ;------------------------------------
      
      Gui IconConfig: Destroy
      
      return
   } _____DETAILS_END_____
      
_____DETAILS_BEGIN_____1t_ Preload_IconList() { _____SUMMARY_END_____
   global 
   
      ;----------------------------------------------------------
      ; Source:
      ;    "TreeView Large Icons - Is it possible?"
      ;   https://www.autohotkey.com/boards/viewtopic.php?t=65043
      ;----------------------------------------------------------
      
      option_use_large_images := true
      ImageListID_large := IL_Create(10, , option_use_large_images) 
      
      ;--------------------------------------------
      ; Load the ImageList with system icons.
      ;--------------------------------------------
_____IF_DETAILS_BEGIN_____2t_ Loop 329
      { _____SUMMARY_END_____
         IL_Add(ImageListID_large, "shell32.dll", A_Index)
      } _____DETAILS_END_____
      
      GuiConfigIconPicker._LV_IconList := ImageListID_large
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_AddControls() { _____SUMMARY_END_____
   global
   
   
        text  := "Use Selected Icon"
      options :=  A_Space "g" "GuiConfigIconPicker.GUI_EVENT_Button"
      options  .= A_Space "+Default"
      
      Gui, IconConfig:Add, Button
         , %options%
         , %text%
      
        text  :=  "Use Selected Icon"
      options :=  A_Space "g"    "GuiConfigIconPicker.GUI_EVENT_TreeView"
      options  .= A_Space "v"    "GuiConfigIconPicker_TreeView"
      options  .= A_Space "hwnd" "HwndIconPickerTreeView"
      options  .= A_Space "ImageList" GuiConfigIconPicker._LV_IconList
      
      Gui, IconConfig:Add, TreeView
         , %options%

      select_this_one := "" 
      TV_Delete()
      parent_id := 0
_____IF_DETAILS_BEGIN_____2t_ Loop 329 { _____SUMMARY_END_____
         tv_id := TV_Add("Icon " A_Index, %parent_id%, "Icon" A_Index) 
_____IF_DETAILS_BEGIN_____3t_ if( A_Index == _ICON_INDEX ){ _____SUMMARY_END_____
            select_this_one := tv_id 
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ if( select_this_one ){ _____SUMMARY_END_____
         TV_Modify( select_this_one )
      } _____DETAILS_END_____
      
      return      
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnEscape() { _____SUMMARY_END_____
   global
      GuiConfigIconPicker.GUI_EVENT_OnClose()
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnClose() { _____SUMMARY_END_____
   global
   
_____COMMENT_DETAILS_BEGIN_____2t_ ;------------------------------------------------------;
      ; Call the Destructor method for class GuiConfigPopup. ;
      ;------------------------------------------------------; _____COMMENT_SUMMARY_END_____
      ;                                                      ;
      ; GuiConfigPopup.__Delete() will:                      ;
      ;                                                      ;
      ; - push or revert changes                             ;
      ; - restore control to GuiConfigMain                   ;
      ; - delete and free any vars this object is using      ;
      ; - destroy the popup GUI                              ;
      ;------------------------------------------------------; _____COMMENT_DETAILS_END_____
      
      ;-----------------------------------------------------------------
      ; AutoHotkey Info 
      ;-----------------------------------------------------------------
      ; obj := "" 
      ;   Calls the object's __Delete() class destrutor 
      ;   if this is the last variable referencing the object instance 
      ;   (in this case, it is).
      ;-----------------------------------------------------------------
      
      _o_Gui_Config_IconPicker := ""
      return
      
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnSize() { _____SUMMARY_END_____
   global HwndIconPickerTreeView
   
      control_padding := 10
      
      op_w := A_GuiWidth
      op_h := A_GuiHeight
      
      
      ;; padding, probably
      op_w := op_w -(2*control_padding )
      op_h := op_h -(2*control_padding ) - 20
      
      op_x := control_padding
      op_y := control_padding + 20
      
      c1 := HwndIconPickerTreeView
      options_movedraw := "H" . op_h . " " . "W" . op_w . " "
      options_movedraw .= "X" . op_x . " " . "Y" . op_y
      GuiControl, MoveDraw, %c1%, % options_movedraw
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Button() { _____SUMMARY_END_____
   global 
      icon_id := GuiConfigIconPicker._icon_chosen
      GuiConfigIconPicker.SubmitIcon( icon_id )
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_TreeView() { _____SUMMARY_END_____
   global 
   
      ;---------------------------------------------------------------
      ; If event triggered because user double-clicked 
_____IF_DETAILS_BEGIN_____2t_ if ( "DoubleClick" = A_GuiEvent ){ _____SUMMARY_END_____
      
         ;------------------------------------------------------------
         ; Extract the icon number from selected TreeView Item's text.
         ;
         icon_id := GuiConfigIconPicker.Get_IconID_From_TreeViewID( A_EventInfo )
         
         ;---------------------------------------
         ; Submit icon choice upon double-click
         ;
         GuiConfigIconPicker.SubmitIcon( icon_id )
      } _____DETAILS_END_____
      ;---------------------------------------------------------------
      ; If event triggered because of TreeView item selection changed 
_____IF_DETAILS_BEGIN_____2t_ else if ( "S" == A_GuiEvent ){ _____SUMMARY_END_____
         
         ;------------------------------------------------------------
         ; Extract the icon number from selected TreeView Item's text.
         ;
         icon_id := GuiConfigIconPicker.Get_IconID_From_TreeViewID( A_EventInfo )
         
         ;--------------------------------------------------
         ; Store icon choice (referenced by submit button).
         ;
         GuiConfigIconPicker._icon_chosen := icon_id
         
      } _____DETAILS_END_____
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ SubmitIcon( icon_id ) { _____SUMMARY_END_____
   global
   
_____IF_DETAILS_BEGIN_____2t_ if( "" != icon_id 
      and  0 != icon_id ){ _____SUMMARY_END_____
         
         ;-----------------------------------------------------
         ; Tell main Gui to update settings to use this icon.
         ;
         GuiConfigMain.Fn_Settings_SetIcon( icon_id ) 
         
         ;---------------------------
         ; Close Icon Config Window.
         ;
         GuiConfigIconPicker.GUI_EVENT_OnClose()
         
      } _____DETAILS_END_____
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Get_IconID_From_TreeViewID( TreeViewItemID ) { _____SUMMARY_END_____
   global 
      
      ;------------------------------------------------------------
      ; TreeView IDs are not linear, 
      ; so we know which TreeView Item was clicked or selected,
      ; but we don't know what its position is within the treeview.
      ;
      ; So we need to extract the Icon ID 
      ; from the selected TreeView Item's text. 
      ;------------------------------------------------------------
      
      icon_id := "" 
      
      ;------------------------------------------------------
      ; First, we get the text of the selected TreeView Item 
      ;
      TV_GetText(tv_text, A_EventInfo)
      
      ;------------------------------------------------------------------
      ; Next we remove the leading "Icon " to store 
      ; only the trailing number at the end of the TreeView Item's text
      ;
      icon_id := RegExReplace(tv_text, "^Icon[ ]*", "")
      
      
      return icon_id
   } _____DETAILS_END_____

} _____DETAILS_END_____

_____DETAILS_BEGIN_____0t_ class GuiConfigPopup { _____SUMMARY_END_____

   static _popup_mode    := "" ; either:   "command" or "action"
   static _popup_purpose := "" ; either:   "add"     or "edit"
   
   static _LV_RowData_FromMainGui := {}
   

   static _isPathValid := ""   
   static _LV_selected_action_id := "" ; for Command 

   
   ;-------------------------------------------------------------------------------
   ; storing all the different text branches for this submit button 
   ; inside this associative array 
   ;
   ; can access using : 
   ; a := GuiConfigPopup.text["action_popup"]["add"]
   ; b := GuiConfigPopup.text["command_popup"]["edit"]["tab2"]
   ;
   static text := {    "" 
      . "action_popup"

         :{  "add"  : "Add NEW ACTION!" 
            ,"edit" : "Change this action!"}  
         
      , "command_popup"
      
         :{  "add"
               :{ "tab1"
                  :   "Add NEW ACTION and `n" 
                    . "assign to NEW COMMAND! "
                 ,"tab2"
                  :   "Use Action[] and `n" 
                    . "assign to NEW COMMAND!"}
         
            ,"edit"
               :{ "tab1"
                  :   "Add NEW ACTION and `n" 
                    . "   assign to this command!    "
                 ,"tab2"
                  :   "Use Action[] and `n" 
                    . "   assign to this command!    " }    } } 
   
   
   ;[~]
   ;======================================================================================
   ;         This class, GuiConfigPopup, is a grouping of functionality for 
   ;         the popup config windows (GUIS) generated for GuiConfigMain's first tab,
   ;         - "Edit a Command" or
   ;         - "New Command"
   ;         
   ;         Contained below is all the functionality needed
   ;         to process input & respond to UI events, 
   ;
   ;         and are grouped here primarily for organizational cleanliness.
   ;
   ;         To make this app simple to understand, 
   ;         I initially tried to use labels exclusively instead of functions or classes.
   ;         However, 
   ;         this led to a long long stream of labels with no clear visual oranization.
   ;         
   ;         
   ;======================================================================================

   

   ;====================================================;
   ; Creates the GUI to edit a command                  ;
   ;   When:                                            ;
   ;     - User double-clicks a Command or              ;
   ;     - User selects a Command and presses <Enter>   ;
   ;   in GuiConfigMain's Tab "Commands"                      ;
   ;====================================================;
_____DETAILS_BEGIN_____1t_ __New(mode, purpose, row_data_if_editing:="", silent:=false ) { _____SUMMARY_END_____
   global
      
      
      GuiConfigPopup._popup_mode              := mode 
      GuiConfigPopup._popup_purpose           := purpose
      
      GuiConfigPopup._LV_RowData_FromMainGui  := row_data_if_editing
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  Syntax reference: _____BLOCK_COMMENT_SUMMARY_END_____
         
            row_dat["LV_id"]               := selected_row
            row_dat["row_cmd"]             := got_cmd
            row_dat["row_cmd_is_enabled"]  := got_cmd_is_enabled
            row_dat["row_actionID"]        := got_actionId
            row_dat["row_actionType"]      := got_actionType
            row_dat["row_actionPath"]      := got_actionPath
            row_dat["row_actionArg"]       := got_actionArg
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      GuiConfigPopup.Initialize_Gui_gVariables()
      
      GuiConfigPopup.Init_Config_GuiWindow_Options()      
      GuiConfigPopup.Init_AddControls_1()
      GuiConfigPopup.Init_AddControls_2_Both_ConfigNewAction()
      GuiConfigPopup.Init_AddControls_3_Cmd_SecondTab()
      GuiConfigPopup.Init_AddControls_4_Both_SubmitButton()

      
_____COMMENT_DETAILS_BEGIN_____2t_ ;--------------------------------------------------------------------;
      ; Note:                                                              ;
      ;--------------------------------------------------------------------; _____COMMENT_SUMMARY_END_____
      ;                                                                    ;
      ;   The name "PopupConfig" is arbitrarily used here                  ;
      ;   to tell commands like                                            ;
      ;                                                                    ;
      ;     - "Gui, ArbitraryGuiName:Add, .." and                          ;
      ;     - "GuiControl, ArbitraryGuiName: %stringSubCommand%            ;
      ;       , ArbitraryControlName, %someVar%"                           ;
      ;                                                                    ;
      ;   which GUI they should specifically operate upon.                 ;
      ;                                                                    ;
      ;   This "PopupConfig" just a name, not a variable                   ;
      ;   and should not be confused with:                                 ;
      ;                                                                    ;
      ;     - "GuiConfigPopup",                                            ;
      ;        which is the class organizing all these functions together  ;
      ;                                                                    ;
      ;     - nor with "_o_Gui_Config_Popup",                              ;
      ;       which is an instatiated object of the class "GuiConfigPopup".;
      ;                                                                    ;
      ;--------------------------------------------------------------------; _____COMMENT_DETAILS_END_____
      
      ;==========================================================;
      ; Render + Display GuiConfigPopup's GUI window             ;
      ;==========================================================;
      
      ;----------------------------------------------------------;
      ; Temporarily disable GuiConfigMain while                  ;
      ; this popup exists (so the ListView order                 ;
      ; cannot be changed/rearranged while editing)              ;
      ;                                                          ;
      ; GuiConfigPopup will be a child window of GuiConfigMain,  ;
      ; which will prevent GuiConfigMain                         ;
      ; from displaying on top of this popup.                    ;
      ;==========================================================;

      
      Gui, PopupConfig:+OwnerConfigMain
      
_____IF_DETAILS_BEGIN_____2t_ if( false == silent ){ _____SUMMARY_END_____
      
         Gui, PopupConfig: Show
         
         Gui ConfigMain: +Disabled
      
      } _____DETAILS_END_____

      
      ;---------------------------------------------------------------
      ; Manual call to OnSize() with this flag:
      ;    Initializes the functions static variables which 
      ;    store previous window width and height between Event calls.
      GuiConfigPopup.GUI_EVENT_OnSize("Gui up and running")
      
      ;----------------------------------
      ; Fine tuning of Control Widths 
      ; and 
      ; initializes the label reporting 
      ; whether the file path is valid
      GuiConfigPopup.Init_Config_Controls_After_Render()
      
      
      return this
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ __Delete() { _____SUMMARY_END_____
   global 
      
      ; If PopupCommand successfully edited a command, this will be ignored.
      ; If PopupCommand was cancelled by User, then this will restore the command.
      
_____IF_DETAILS_BEGIN_____2t_ if( "action" == GuiConfigPopup._popup_mode ){ _____SUMMARY_END_____
         GuiConfigMain.Restore_Plucked_Action_If_User_Cancelled()
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ if( "command" == GuiConfigPopup._popup_mode ){ _____SUMMARY_END_____
         GuiConfigMain.Restore_Plucked_Command_If_User_Cancelled()
      } _____DETAILS_END_____
      
      
      ;--------------------------------------------------
      ; Clear instance class member vars 
      ;
      ;  (used for storing gui's recent size & comparing 
      ;  to current w+h upon gui window "OnSize()" event)
      ;--------------------------------------------------
      
      GuiConfigPopup._popup_mode    := "" 
      GuiConfigPopup._popup_purpose := ""
      
      GuiConfigPopup.GUI_EVENT_OnSize("RESET")
      
      GuiConfigPopup._isPathValid                 := ""
      GuiConfigPopup._LV_selected_action_id       := ""
      
            
      ;---------------------------------------------------
      ; Readjust main GUI's ListView columns for Commands 
      ;---------------------------------------------------
      
      GuiConfigMain.ListViewCommands_ReadjustAllCols()
      
      ;--------------------------------------------------------
      ; Re-enable GuiConfigMain, 
      ; now that GuiConfigPopup no longer needs prioritized focus.
      ;--------------------------------------------------------
      
      Gui ConfigMain: -Disabled
      Gui PopupConfig: Destroy
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Initialize_Gui_gVariables() { _____SUMMARY_END_____
   global   
      
      GuiConfigPopup_Cmd_InputCommandName          := ""
      GuiConfigPopup_Cmd_Tabs                      := ""      ; see footnote[1]
      GuiConfigPopup_Cmd_Tab2_ListViewActions      := ""
      
      GuiConfigPopup_ActionConfig_TextDragAndDrop  := ""
      GuiConfigPopup_ActionConfig_RadioFolder      := ""
      GuiConfigPopup_ActionConfig_RadioApp         := ""
      GuiConfigPopup_ActionConfig_InputPath        := ""
      GuiConfigPopup_ActionConfig_LabelVerified    := ""
      GuiConfigPopup_ButtonSubmit                  := ""
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;-------------------------------------------------------------------------
      ; footnote[1]
      ;-------------------------------------------------------------------------
      ; GuiConfigPopup_Cmd_Tabs
      ;------------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ; Used for dynamically changing the submit button for Add|Edit Command.
      ; If not cleared here, it will persist between popups, 
      ; and exiting an "Edit Command" popup on the 2nd tab 
      ; would glitch future "Add Command" or "Edit Command" popups
      ;   (causing the text for the second tab's submit button 
      ;   to display incorrectly on the 1st tab)
      ; when they open (by default) to the 1st tab.
      ;
      ; Hence it's a good practice to clear global variables 
      ; for GUIs which are created multiple times over the lifespan of a script.
      ;------------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Config_GuiWindow_Options() { _____SUMMARY_END_____
   global 
   
      ;========================================================
      ; Configure a GUI popup to [Add|Edit] a [Command|Action]
      ;========================================================
      
         minsize := ("command" == this._popup_mode) 
                     ? "+MinSize340x567" 
                     : "+MinSize275x425"
                     
         options_for_Popup :=  A_Space "+Label" "GuiConfigPopup.GUI_EVENT_On"
         options_for_Popup  .= A_Space "+Resize"
         options_for_Popup  .= A_Space minsize
         
         title_mode    := ("command" == this._popup_mode) 
                        ? "COMMAND" 
                        : "ACTION"
         title_purpose := ("add" == this._popup_purpose)
                        ? "add new!"
                        : "edit..."
         
         title_for_Popup_Window := title_mode "  -  " title_purpose
           
         Gui, PopupConfig:New
            , %options_for_Popup% 
            ,   %title_for_Popup_Window%
            
      return
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;----------------------------------------------------------------------
      ; AutoHotkey Info : Ternary Operator
      ;---------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ; myVar := (ifThisEvalsToTrue) ? thenAssignThis : otherwiseAssignThis
      ;----------------------------------------------------------------------
      ; https://www.autohotkey.com/docs/Variables.htm#ternary
      ;---------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_AddControls_1() { _____SUMMARY_END_____
   global 
   
      ;=======================================================;
      ; These Controls:                                       ;
      ;=======================================================;
      ;   - `Text` Label "Command:" for input field           ;
      ;   - `Edit` Input field for Command                    ;
      ;   - `Tab3` Tab container for action selection         ;
      ;      to assign to Command                             ;
      ;                                                       ;
      ;=======================================================;
      ; are only present for these Popups:                    ;
      ;=======================================================;
      ;   - Command Add                              
      ;   - Command Edit                             
      ;
_____IF_DETAILS_BEGIN_____2t_ if("command" == this._popup_mode){ _____SUMMARY_END_____
      
         ;===================================
         ; Add `Text` labled "Command:" and  
         ; Add `Edit` user input for Command 
         ;===================================

            ;-----------------------------------------
            ; Label "Command:" before user input field 
            ;-----------------------------------------
            
_____IF_DETAILS_BEGIN_____4t_ if("add" == this._popup_purpose){ _____SUMMARY_END_____
               text := "Type the text for your new Command :"
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ else if("edit" == this._popup_purpose){ _____SUMMARY_END_____
               text := "Command :"
            } _____DETAILS_END_____
            
            options := "y+15 cBlue"
            
            Gui, PopupConfig:Add, Text
               , %options%
               ,    %text%
            
            ;--------------------------------------
            ; User input field 
            ;--------------------------------------
            
               ;-----------------------------------------
               ; If editing a command, 
               ;   then this `Edit` Control uses 
               ;   var LV Row's command as initial text
               ;
               text := GuiConfigPopup._LV_RowData_FromMainGui["row_cmd"]
            options :=  A_Space "v" "GuiConfigPopup_Cmd_InputCommandName"
            options  .= A_Space "-Multi -WantTab"
            options  .= A_Space "w500"
            options  .= A_Space "y+10"
            
            
            Gui, PopupConfig:Add, Edit
               , %options%
               ,    %text%

            ;------------------------------------------
            ; Label "Choose the Action it will trigger" 
            ; after Command input area
            ; just before Tab container for Actions
            ;------------------------------------------
            
               text := "Choose the Action it will trigger :" 
            options := A_Space "y+20 cBlue"
            Gui, PopupConfig:Add, Text
               , %options%
               , %text%
         
         
         ;================================
         ; Add Tab Container with 2 tabs
         ; - Add New Action
         ; - Use Existing Action
         ;================================

               text := "Add New Action|Use Existing Action"
            options :=  A_Space "v" "GuiConfigPopup_Cmd_Tabs"
            options  .= A_Space "g" "GuiConfigPopup.GUI_EVENT_Cmd_TabChanged"
            options  .= A_Space "w500"
            options  .= A_Space "y+10"
               
               
            ; Gui, PopupConfig:Add, Tab3, w600 h500 vGuiConfigPopup_Cmd_Tabs
            Gui, PopupConfig:Add, Tab3
               , %options%
               ,    %text%
         
      } _____DETAILS_END_____

      ;===============================================================;
      ; This "Text" Control labeled "Create/Configure Action:"        ;
      ; is only present for these Popups:                             ;
      ;===============================================================;
      ;   - Action Add
      ;   - Action Edit
      ;
_____IF_DETAILS_BEGIN_____2t_ else if("action" == this._popup_mode){ _____SUMMARY_END_____
         
         row_actionID := GuiConfigPopup._LV_RowData_FromMainGui["row_actionID"]
         
            text := ("add" == this._popup_purpose)
                   ? "Create a new Action :"
                   : "Configure Action[" row_actionID "] :"
                   
         options :=  A_Space "cBlue"
         options  .= A_Space "y+15"
         
         Gui, PopupConfig:Add, Text
            , %options%
            , %text%
      } _____DETAILS_END_____
      return
      
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_AddControls_2_Both_ConfigNewAction() { _____SUMMARY_END_____
   global 
   
      ;=========================================================================;
      ; The following Controls:                                                 ;
      ;   - `Text` Control informing about "Drag-n-Drop"                        ;
      ;   - `Radio` Control choice between "Open Folder" or "Open Application"  ;
      ;   - series of Controls to choose Action's Path (to folder or app)       ;
      ;=========================================================================;
      ; are present for all Popups:                                             ;
      ;=========================================================================;
      ;   - Action Add                                                          ;
      ;   - Action Edit                                                         ;
      ;   - Command Add                                                         ;
      ;   - Command Edit                                                        ;
      ;=========================================================================;
      
      
_____IF_DETAILS_BEGIN_____2t_ if("command" == this._popup_mode){ _____SUMMARY_END_____
      
        ;----------------------------TAB SWITCH----------------------------
        ;
        ; `Tab` present for Command Add & Command Edit.
        ;
        ; GuiConfigPopup's 
        ; 1st Tab will receive Gui Controls added after the following line:

         Gui, Tab, 1      

        ;
        ;----------------------------TAB SWITCH----------------------------
        
      } _____DETAILS_END_____

      
      
      ;=========================================
      ; Add `Text` Label:
      ;-----------------------------------------
      ; Inform User Drag-n-Drop is possible here
      ;=========================================

            text :=  "`n"
            text  .= "Note:`n`n"
            text  .= "   You can drag and drop a single file or folder   `n"
            text  .= "onto of any portion of this window`n"
            text  .= "to populate the fields below."
            text  .= "`n`n"
         
         options :=  A_Space "v" "GuiConfigPopup_ActionConfig_TextDragAndDrop"
         options  .= A_Space "Border Center"
         options  .= A_Space "y+20"
            
         Gui, PopupConfig:Add, Text
            , %options%
            , %text% 



      ;===============================
      ; Add `Radio` choice: 
      ;    () Open Folder
      ;    () Open Application
      ;===============================

         ;-----------------------------------------
         ; Display "Type:" before radio choice 
         ;-----------------------------------------
         
            text := "Action Type :"
         options :=  A_Space "y+20"
         options  .= A_Space "cTeal"
            
         Gui, PopupConfig:Add, Text
            ,%options%
            , %text%

         row_actionType := GuiConfigPopup._LV_RowData_FromMainGui["row_actionType"]
         
         ;-----------------------------------------
         ; `Radio` choice: Open Folder
         ;-----------------------------------------

            text   := "Open Folder" 
         options   :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ActionConfig_RadioChanged" 
         options    .= A_Space "v"           "GuiConfigPopup_ActionConfig_RadioFolder" 
         ; options    .= A_Space "y+15" 
         options    .= A_Space "y+10" 
         
_____IF_DETAILS_BEGIN_____3t_ if( "folder" = row_actionType ){ _____SUMMARY_END_____
            options   .= A_Space "+Checked" 
         } _____DETAILS_END_____
         
         Gui, PopupConfig:Add, Radio
            , %options%
            , %text%

         ;-----------------------------------------
         ; `Radio` choice: Open Application
         ;-----------------------------------------

            text      := "Open Application" 
         options      :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ActionConfig_RadioChanged" 
         options       .= A_Space "v"           "GuiConfigPopup_ActionConfig_RadioApp" 
         
_____IF_DETAILS_BEGIN_____3t_ if( "app" = row_actionType ){ _____SUMMARY_END_____
            options   .= A_Space "+Checked" 
         } _____DETAILS_END_____
         
         Gui, PopupConfig:Add, Radio
            , %options%
            ,    %text%



      ;================================================================
      ; Add Controls to Configure Action's Path 
      ;----------------------------------------------------------------
      ;   - `Text`   : Display "Path" 
      ;   - `Button` : Open file or folder picker
      ;   - `Edit`   : Input field for path (to Folder or Application)
      ;   - `Text`   : Display "(valid folder)" or "(valid path)"
      ;================================================================

            text := "Path :"
         ; options :=  A_Space "y+30"
         options :=  A_Space "y+20"
         options  .= A_Space "cTeal"
         
         Gui, PopupConfig:Add, Text
            , %options%
            ,    %text%
         
         
            text := "Browse"
         options :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ActionConfig_BrowseButton"
         options  .= A_Space "-Default"
         options  .= A_Space "section"
         ; options  .= A_Space "y+15"
         options  .= A_Space "y+10"
         
         Gui, PopupConfig:Add, Button
            , %options%
            ,    %text%


            text := GuiConfigPopup._LV_RowData_FromMainGui["row_actionPath"]
         options :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ActionConfig_InputPath"
         options  .= A_Space "v" "GuiConfigPopup_ActionConfig_InputPath"
         options  .= A_Space "-Multi -WantTab"
         options  .= A_Space "ys w400"

         Gui, PopupConfig:Add, Edit
            , %options%
            ,    %text%

            ;--------------------------------------------------
            ; The "(valid folder)" "(valid file)" label 
            ;  will be dynamically populated every time 
            ;  the path is checked for an existing file/folder.
            ; 
            text := "" 
         options := A_Space "v" "GuiConfigPopup_ActionConfig_LabelVerified"
         options .= A_Space "w120"
         
         Gui, PopupConfig:Add, Text
            , %options%


      ;================================================================
      ; Add Controls to Configure Action's Arguments if App 
      ;----------------------------------------------------------------
      ;   - `Text`   : Display "Arguments" 
      ;   - `Edit`   : Input field for Arguments to call App with
      ;================================================================

            text := "Arguments :"
         options :=  A_Space "v" "GuiConfigPopup_ActionConfig_LabelArguments1"
         ; options  .= A_Space "y+30"
         options  .= A_Space "y+17"
         options  .= A_Space "xs"
         options  .= A_Space "cTeal"
         
         Gui, PopupConfig:Add, Text
            , %options%
            ,    %text%
      
         text := ""
_____IF_DETAILS_BEGIN_____3t_ if( "app" = row_actionType ){ _____SUMMARY_END_____
            text := GuiConfigPopup._LV_RowData_FromMainGui["row_actionArg"]
         } _____DETAILS_END_____
         
         ; options :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ActionConfig_Arguments"
         options :=  A_Space "v" "GuiConfigPopup_ActionConfig_InputArguments"
         options  .= A_Space "-Multi -WantTab"
         ; options  .= A_Space "ys w390"
         options  .= A_Space "w457"

         Gui, PopupConfig:Add, Edit
            , %options%
            ,    %text%
            
            
      
            text := "  ( Optional: for advanced use. See tutorial in Savefile. )  " 
         options := A_Space "v" "GuiConfigPopup_ActionConfig_LabelArguments2"
         options  .= A_Space "section"
         ; options  .= A_Space "+Border"
         options  .= A_Space "h30"
         ; options  .= A_Space "cTeal"
         
            
         Gui, PopupConfig:Add, Text
            , %options%
            ,    %text%
            
      return 
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_AddControls_3_Cmd_SecondTab() { _____SUMMARY_END_____
   global 
   
      ;========================================================;
      ; This `ListView` displaying all current Actions         ;
      ; is only present in these Popups:                       ;
      ;========================================================;
      ;   - Command Add 
      ;   - Command Edit 
      ;
_____IF_DETAILS_BEGIN_____2t_ if("command" == this._popup_mode){ _____SUMMARY_END_____
      
        ;----------------------------TAB SWITCH----------------------------
        ;
        ; `Tab` present for Command Add & Command Edit.
        ;
        ; GuiConfigPopup's 
        ; 2nd Tab will receive Gui Controls added after the following line:

         Gui, Tab, 2   

        ;
        ;----------------------------TAB SWITCH----------------------------
        
      
         ;==========================================
         ; Add `ListView` to choose existing Action 
         ;==========================================

         
         gui_name     := "PopupConfig"
         goto_name    := "GuiConfigPopup.GUI_EVENT_Cmd_Tab2_ListViewActions"
         control_name := "GuiConfigPopup_Cmd_Tab2_ListViewActions"
         REUSABLE_GUI_CONTROLS.create_listview_of_actions( gui_name
            , goto_name
            , control_name )
         
         LV_ModifyCol(1,"AutoHdr")
         LV_ModifyCol(2,"AutoHdr")
         LV_ModifyCol(3,"AutoHdr")
         LV_ModifyCol(4,"AutoHdr")
         
      } _____DETAILS_END_____

      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_AddControls_4_Both_SubmitButton() { _____SUMMARY_END_____
   global
      
_____IF_DETAILS_BEGIN_____2t_ if("command" == this._popup_mode){ _____SUMMARY_END_____
      
        ;----------------------------TAB SWITCH----------------------------
        ;
        ; `Tab` present for Command Add & Command Edit only.
        ;
        ; GuiConfigPopup will place Gui Controls added after 
        ; the following line below the Tab Container:

         Gui, Tab,

        ;
        ;----------------------------TAB SWITCH----------------------------
      
      } _____DETAILS_END_____
      
      ;=========================================================================;
      ; The `Button` Control named GuiConfigPopup_ButtonSubmit                  ;
      ; is present for all Popups:                                              ;
      ;=========================================================================;
      ;   - Action Add                                                          ;
      ;   - Action Edit                                                         ;
      ;   - Command Add                                                         ;
      ;   - Command Edit                                                        ;
      ;=========================================================================;
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;---------------------------------------------------------------
      ;  About the Submit Button's Functionality
      ;--------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ; If all the options the user enters into the above Controls 
      ; are valid paths & non-duplicate Command names
      ; this button will either: 
      ;
      ;   - Add a new Action or
      ;   - Automatically assign 
      ;     a preexisting identical Action
      ;
      ; Then (for Commands)
      ;
      ;   1. This command:ID pair will be added
      ;      to internal _COMMANDS array as:
      ;      - a totally new entry, or
      ;      - a restored entry, or
      ;      - a modified entry).
      ;
      ;   2. The Command (in the first "Edit" input box)
      ;      can now be used to trigger this Action.
      ;
      ;   3. Then this "GuiConfigPopup" Gui will close.
      ;
      ; Or Then (for Actions)
      ;
      ;   1. If edited, the updated Action will be added to _ACTIONS 
      ;      and any Commands referencing that ID will now trigger it.
      ;
      ;   2. If added, the new Action will be added to _ACTIONS 
      ;      but it will need to be assigned to a Command 
      ;      before it can be triggered.
      ;
      ;--------------------------------------------------------------- _____COMMENT_DETAILS_END_____

      ;==========================================
      ; Add `Button` to Submit Command or Action 
      ;==========================================
      
         text := GuiConfigPopup.get_submit_button_text()
      options :=  A_Space "g" "GuiConfigPopup.GUI_EVENT_ButtonSubmit"
      options  .= A_Space "v" "GuiConfigPopup_ButtonSubmit"
      options  .= A_Space "+Default"
      options  .= A_Space "y+20 xm"
         
      Gui, PopupConfig:Add, Button
         , %options%
         ,    %text%


      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Init_Config_Controls_After_Render() { _____SUMMARY_END_____
   global 
   
      ;==================================================
      ; stretch the info label's width 
      ;==================================================
      ; 
      ;  present in all Popups:                       
      ;
      ;   - Action  Add 
      ;   - Action  Edit 
      ;   - Command Add 
      ;   - Command Edit 
      ;----------------------------
      
      c := "GuiConfigPopup_ActionConfig_TextDragAndDrop"
      w := 470 
      
_____IF_DETAILS_BEGIN_____2t_ if( "action" == this._popup_mode){ _____SUMMARY_END_____
         w := w - 15
      } _____DETAILS_END_____
      
      GuiControl, PopupConfig: MoveDraw, %c%, w%w% 
      
      
      ;==================================================
      ; stretch ListView on any Command Popup's 2nd Tab
      ;==================================================
      ; 
      ;  present in Popups:                       
      ;
      ;   - Command Add 
      ;   - Command Edit 
      ;----------------------------
      
_____IF_DETAILS_BEGIN_____2t_ if( "command" == this._popup_mode ){ _____SUMMARY_END_____
         
         c := "GuiConfigPopup_Cmd_Tab2_ListViewActions"
         w := 470 ; - 50
         GuiControl, PopupConfig: MoveDraw, %c%, w%w% 
         
      } _____DETAILS_END_____
      
      ;====================================================
      ; If the action's path is okay, 
      ; make the GuiConfigPopup_ActionConfig_LabelVerified
      ; control display the text "(Valid)" 
      ;====================================================
      ;
      ;  present in all Popups:                       
      ;
      ;   - Action  Add 
      ;   - Action  Edit 
      ;   - Command Add 
      ;   - Command Edit 
      ;----------------------------
      
      GuiConfigPopup.GUI_FN_LabelPathVerified_CheckAndRefresh()
      
      ;-------------------------------------------------------------------------
      ; When a folder is the Action type, 
      ; don't display the fields to input Arguments for opening an executable.
      ;-------------------------------------------------------------------------
      
      GuiConfigPopup.GUI_FN_ToggleArgumentsIfNotApp()
      
      return 
   } _____DETAILS_END_____





_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnSize(FLAG:="") { _____SUMMARY_END_____
   global
      
      ;=================================
      ; Adjust Size of 
      ;
      ; Tab box 
      ; Input Box: Command Name 
      ; Input Box: Action Path 
      ; Label: About Drag and Drop
      ;=================================
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;------------------------------------------------------------
      ; OnSize() will be called once when the Gui is rendered
      ;------------------------------------------------------------ _____COMMENT_SUMMARY_END_____
      ; 
      ; Every time this function is called automatically due 
      ;  to an AutoHotkey event triggering OnSize(), 
      ;  this function's static vars will persistently remember  
      ;  the Gui's last size before a resize event.
      ;
      ; We'll ignore the resizing branch during the first call, 
      ;  (a) because all the Controls are properly placed
      ;  (b) because the user hasn't resized the window yet.
      ;
      ;
      ; Then all subsequent calls will get the "delta" height value 
      ;  (representing the amount of change in height)
      ;  comparing the current size to the previous size.
      ;
      ; This is especially useful to easily calculate y-coordinates
      ; but with rapid calls, sometimes AutoHotkey can't keep up 
      ; and a bit of deviations in consistency will appear.
      ;
      ; When possible, it's better to use absolute positionings 
      ;  and offsets, but this delta method works well enough
      ;  considering its ease.
      ;
      ; Shout-out to AutoXYWH:
      ;  https://www.autohotkey.com/boards/viewtopic.php?f=6&t=1079
      ;------------------------------------------------------------ _____COMMENT_DETAILS_END_____
      
      
      static previous_width
      static previous_height
      static is_baked
      
      
     ;******************************************************************************
     ;
     ;                     Manual Function Calls with Flags
     ;
     ;******************************************************************************
      
      ;==========================================
      ; Initialize static vars & control offsets
      ;==========================================
      
_____IF_DETAILS_BEGIN_____2t_ if( "Gui up and running" == FLAG){ _____SUMMARY_END_____
         is_baked := true
         return ; A_GuiWidth isn't populated when OnSize() is called manually.
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else if( "RESET" == FLAG){ _____SUMMARY_END_____
         is_baked := false
         return ; in process of calling __Delete() for this popup gui instance.
      } _____DETAILS_END_____
      
      
     ;******************************************************************************
     ;
     ;                    AutoHotkey Event calls to OnSize()
     ;
     ;******************************************************************************
     
_____IF_DETAILS_BEGIN_____2t_ if( true ==  is_baked )
      { _____SUMMARY_END_____
      
         ar_ctrls := [ "GuiConfigPopup_Cmd_InputCommandName"
                  , "GuiConfigPopup_Cmd_Tabs"
                  , "GuiConfigPopup_ActionConfig_InputPath" 
                  , "GuiConfigPopup_ActionConfig_TextDragAndDrop" 
                  , "GuiConfigPopup_ActionConfig_InputArguments" 
                  , "GuiConfigPopup_Cmd_Tab2_ListViewActions" 
                  , "GuiConfigPopup_ButtonSubmit" ]
      
_____IF_DETAILS_BEGIN_____3t_ for i, c in ar_ctrls
         { _____SUMMARY_END_____
            
_____COMMENT_DETAILS_BEGIN_____4t_ ;------------------------------------------------------------
            ; Note on algorithm, past and present.
            ;------------------------------------------------------------ _____COMMENT_SUMMARY_END_____
            ; I replaced my previous implementation using:
            ;
            ;   delta_w := A_GuiWidth  - previous_width
            ;
            ; with the following offsets I found through 
            ; trial-and-error.
            ;
            ; These seemingly arbitrary offsets 
            ; take the Gui's Client Area's Width (A_GuiWidth)
            ; and subtract the margins 
            ; and (where applicable) the tab container's offset.
            ;
            ;------------------------------------------------------------
            ; Gui's Client Area:
            ;   The window's area available to control placement.
            ; 
            ;   the Y coordinates start below the title bar
            ;    and (if applicable) menu bar.      
            ;   The X coordinates start to to the right 
            ;    of the leftmost window style borders (if they exist).
            ;------------------------------------------------------------
            ; AutoHotkey Docs:
            ;   https://www.autohotkey.com/docs/commands/Gui.htm#GuiSize
            ;   https://www.autohotkey.com/docs/Variables.htm#GuiWidth
            ;------------------------------------------------------------ _____COMMENT_DETAILS_END_____
            
            
            ;========================================================
            ; Stretch the width of these Controls 
            ; by taking the overall width and subtracting the margins
            ;========================================================
            
            w := A_GuiWidth - 20
_____IF_DETAILS_BEGIN_____4t_ if( c = "GuiConfigPopup_ActionConfig_TextDragAndDrop" ){ _____SUMMARY_END_____
               
               ;---------------------------------------------
               ; This layout is reused in:
               ;   All Command Popups [Add or Edit] on Tab 1
               ;   All Action Popups  [Add or Edit]
               ;
               ; However, the Actions layout 
               ; is not embedded inside a Tab container,
               ; so the offsets will differ.
               ;---------------------------------------------
               
_____IF_DETAILS_BEGIN_____5t_ if( "action" == GuiConfigPopup._popup_mode){ _____SUMMARY_END_____
                  w := w - 2
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  w := w - 30
               } _____DETAILS_END_____
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ else if( c = "GuiConfigPopup_ActionConfig_InputPath" ){ _____SUMMARY_END_____
               
               ;---------------------
               ;   Same as above 
               ;---------------------
               
_____IF_DETAILS_BEGIN_____5t_ if( "action" == GuiConfigPopup._popup_mode){ _____SUMMARY_END_____
                  w := w - 57
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  w := w - 100
               } _____DETAILS_END_____
            } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____4t_ else if( c = "GuiConfigPopup_ActionConfig_InputArguments" ){ _____SUMMARY_END_____
               
_____IF_DETAILS_BEGIN_____5t_ if( "action" == GuiConfigPopup._popup_mode){ _____SUMMARY_END_____
                  ; w := w - 67
                  w := w
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else{ _____SUMMARY_END_____
                  ; w := w - 110
                  w := w - 43
               } _____DETAILS_END_____
               
            } _____DETAILS_END_____
_____COMMENT_DETAILS_BEGIN_____4t_ ;========================================================
            ; Stretch the height for Tab container + ListViews
            ; Reposition y-coordinate for buttons.
            ;======================================================== _____COMMENT_SUMMARY_END_____
            ; 
            ; Most of the controls are only stretching their width, 
            ; but some need to 
            ;   - change their y-coordinate 
            ;   - or stretch their height in addition to their width
            ;     (i.e. Tab Container and ListView)
            ;
            ; This branch will 
            ;   - calculate these specific needs 
            ;   - move the Control, 
            ;   - then continue the for loop.
            ;======================================================== _____COMMENT_DETAILS_END_____
            ;
_____IF_DETAILS_BEGIN_____4t_ else { _____SUMMARY_END_____
            
               ;-----------------------------------------
               ; output: ctrl_X, ctrl_Y, ctrl_W, ctrl_H
               ;
               GuiControlGet, ctrl_, Pos, %c%
               delta_h := A_GuiHeight - previous_height
               
_____IF_DETAILS_BEGIN_____5t_ if( c = "GuiConfigPopup_Cmd_Tabs" ){ _____SUMMARY_END_____
                  h := delta_h + ctrl_H
                  w := A_GuiWidth - 20 
                  GuiControl, PopupConfig: MoveDraw, %c%, w%w% h%h%
                  
                  continue
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else if( c = "GuiConfigPopup_Cmd_Tab2_ListViewActions" ){ _____SUMMARY_END_____
                  h := delta_h + ctrl_H
                  w := A_GuiWidth - 50
                  GuiControl, PopupConfig: MoveDraw, %c%, w%w% h%h%
                  
                  continue
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else if( c = "GuiConfigPopup_ButtonSubmit"){ _____SUMMARY_END_____
                  y := ctrl_Y + delta_h
                  GuiControl, PopupConfig: MoveDraw, %c%, y%y% 
                  
                  continue
               } _____DETAILS_END_____
            } _____DETAILS_END_____
            
            ;========================================================
            ; For all controls which just need their width stretched 
            ;========================================================
            
            ;-----------------------------------------
            ; output: ctrl_X, ctrl_Y, ctrl_W, ctrl_H
            ;
            GuiControlGet, ctrl_, Pos, %c%
            
            w := (w>150) ? w : ctrl_W
            GuiControl, PopupConfig: MoveDraw, %c%, w%w% 
            
            
         } _____DETAILS_END_____
         
         
      } _____DETAILS_END_____
      
      ;--------------------------------------------
      ; These function-scoped static variables 
      ; will remember their values between calls
      ;
      previous_width := A_GuiWidth
      previous_height := A_GuiHeight
      
      
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnEscape() { _____SUMMARY_END_____
   global
   
      _o_Gui_Config_Popup.GUI_EVENT_OnClose()
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnClose() { _____SUMMARY_END_____
   global
   
_____COMMENT_DETAILS_BEGIN_____2t_ ;------------------------------------------------------;
      ; Call the Destructor method for class GuiConfigPopup. ;
      ;------------------------------------------------------; _____COMMENT_SUMMARY_END_____
      ;                                                      ;
      ; GuiConfigPopup.__Delete() will:                      ;
      ;                                                      ;
      ; - push or revert changes                             ;
      ; - restore control to GuiConfigMain                   ;
      ; - delete and free any vars this object is using      ;
      ; - destroy the popup GUI                              ;
      ;------------------------------------------------------; _____COMMENT_DETAILS_END_____
      
      ;-----------------------------------------------------------------
      ; AutoHotkey Info 
      ;-----------------------------------------------------------------
      ; obj := "" 
      ;   Calls the object's __Delete() class destrutor 
      ;   if this is the last variable referencing the object instance 
      ;   (in this case, it is).
      ;-----------------------------------------------------------------
      ;
      _o_Gui_Config_Popup := "" 
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_OnDropFiles() { _____SUMMARY_END_____
   global
   
_____COMMENT_DETAILS_BEGIN_____2t_ ;---------------------------------------------------------------------
      ; AutoHotkey Docs for GuiDropFiles
      ;--------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ; A_EventInfo and ErrorLevel:
      ;   Both contain the number of files dropped.
      ;---------------------------------------------------------------------
      ; A_GuiEvent:
      ;   Contains the names of the files that were dropped, 
      ;   with each filename except the last terminated by a linefeed (`n).
      ;---------------------------------------------------------------------
      ; https://www.autohotkey.com/docs/commands/Gui.htm#GuiDropFiles
      ;--------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
      
      Gui, PopupConfig:Submit, NoHide 
      
_____IF_DETAILS_BEGIN_____2t_ if( "action" == GuiConfigPopup._popup_mode
      or  "Add New Action" == GuiConfigPopup_Cmd_Tabs )
      { _____SUMMARY_END_____
         ;--------------------------------------------
         ; Populate GUI data with drag-n-dropped file.
         ;--------------------------------------------
         ; User dropped 1 file onto GuiConfigPopup GUI 
         ;--------------------------------------------
_____IF_DETAILS_BEGIN_____3t_ if( A_EventInfo == 1 ){ _____SUMMARY_END_____
            
            is_dragNdrop_valid := FileExist(A_GuiEvent)
      
_____IF_DETAILS_BEGIN_____4t_ if( "" !=  is_dragNdrop_valid ){ _____SUMMARY_END_____
            
_____IF_DETAILS_BEGIN_____5t_ if( InStr(is_dragNdrop_valid, "D") ){ _____SUMMARY_END_____
                  ; populate as dir 
                  
                  GuiControl,, GuiConfigPopup_ActionConfig_RadioFolder, 1
                  GuiControl,, GuiConfigPopup_ActionConfig_RadioApp   , 0
                  
                  GuiControl,, GuiConfigPopup_ActionConfig_InputPath, %A_GuiEvent%
               } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____5t_ else { _____SUMMARY_END_____
                  ; populate as file 
                  
                  GuiControl,, GuiConfigPopup_ActionConfig_RadioFolder, 0
                  GuiControl,, GuiConfigPopup_ActionConfig_RadioApp   , 1
                  
                  GuiControl,, GuiConfigPopup_ActionConfig_InputPath, %A_GuiEvent%
               } _____DETAILS_END_____
            
            } _____DETAILS_END_____
         } _____DETAILS_END_____
         ;----------------------------------------------------
         ; Unsupported.
         ;----------------------------------------------------
         ; User dropped more than 1 file onto GuiConfigPopup GUI 
         ;----------------------------------------------------
_____IF_DETAILS_BEGIN_____3t_ else if( A_EventInfo > 1 ){ _____SUMMARY_END_____
            str_for_usr_output := "_program_launcher.ahk`n`n"
            str_for_usr_output .= "--------------`nOops`n--------------`n"
            str_for_usr_output .= """Edit a Command"" can't process more than one file.`n`n"
            str_for_usr_output .= "Ensure you only have one file selected `n"
            str_for_usr_output .= "in Windows Explorer.`n`n"
            str_for_usr_output .= "Then try to drag-and-drop it onto this window again.`n"
            
            MsgBox,, % "[X] Can't process more than one file for a path.", %str_for_usr_output%
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____





_____DETAILS_BEGIN_____1t_ GUI_EVENT_Cmd_TabChanged() { _____SUMMARY_END_____
   global
      GuiConfigPopup.GUI_FN_ButtonSubmit_Refresh_Text()
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ActionConfig_RadioChanged() { _____SUMMARY_END_____
   global
      GuiConfigPopup.GUI_FN_LabelPathVerified_CheckAndRefresh()
      GuiConfigPopup.GUI_FN_ToggleArgumentsIfNotApp()
      return
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_EVENT_ActionConfig_BrowseButton() { _____SUMMARY_END_____
   global
   
      GuiConfigPopup.GUI_FN_LabelPathVerified_CheckAndRefresh()
      
      is_folder_chosen := GuiConfigPopup_ActionConfig_RadioFolder
      is_app_chosen    := GuiConfigPopup_ActionConfig_RadioApp
      user_chose_path  := ""
      
      row_actionPath := GuiConfigPopup._LV_RowData_FromMainGui["row_actionPath"]
      
_____IF_DETAILS_BEGIN_____2t_ if( is_folder_chosen ){ _____SUMMARY_END_____
         SplitPath, row_actionPath,, dir
         FileSelectFolder, user_chose_path, *%dir%,, Select Folder To Open With Command
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else if( is_app_chosen ){ _____SUMMARY_END_____
         FileSelectFile, user_chose_path, 3, %row_actionPath%, Select Program To Open With Command
      } _____DETAILS_END_____
      
      GuiControl,, GuiConfigPopup_ActionConfig_InputPath, %user_chose_path%
      return 
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ActionConfig_InputPath() { _____SUMMARY_END_____
   global
      
      ; Display (Valid Folder) or (Valid File) if it exists
      GuiConfigPopup.GUI_FN_LabelPathVerified_CheckAndRefresh()      
      
      GuiControlGet, pathSoFar, PopupConfig: , GuiConfigPopup_ActionConfig_InputPath
      
      match_without_quotes := "^[""]([^`n`r]*)[""]$"
      
_____IF_DETAILS_BEGIN_____2t_ if( RegExMatch(pathSoFar, match_without_quotes ) ){ _____SUMMARY_END_____
         path_without_quotes := RegExReplace( pathSoFar, match_without_quotes, "$1" )
         
         GuiControl, PopupConfig: , GuiConfigPopup_ActionConfig_InputPath, %path_without_quotes%
         ; msgbox without quotes %path_without_quotes%
      } _____DETAILS_END_____
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ActionConfig_Arguments() { _____SUMMARY_END_____
   global
   
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_Cmd_Tab2_ListViewActions() { _____SUMMARY_END_____
   global
      GuiConfigPopup.GUI_FN_Cmd_Tab2_ListView_Activate()
      
      ; msgbox A_EventInfo %A_EventInfo%
_____IF_DETAILS_BEGIN_____2t_ if ( "DoubleClick" = A_GuiEvent ){ _____SUMMARY_END_____
         
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ if ( "I" = A_GuiEvent ){ _____SUMMARY_END_____
         
         ;-------------------------------------------------------------
         ; If a row is selected, the if branch will be entered
         ; and the Action ID will be stored in this variable.
         ; 
         ; If a row is deselected, then this variable will be cleared.
         ;
         ; Used for 
         ;   - Submit Button text in Command Popup's "Use Existing Action" tab 
         ;   - Submitting the Command Popup's input to GuiMain and _COMMANDS 
         ;
         GuiConfigPopup._LV_selected_action_id := ""
         
         is_a_selection_event := InStr(ErrorLevel, "S", CaseSensitive:=true)
_____IF_DETAILS_BEGIN_____3t_ if( is_a_selection_event ){ _____SUMMARY_END_____
            LV_GetText(sel_act_id, A_EventInfo,1)
            GuiConfigPopup._LV_selected_action_id := sel_act_id
            
            ; debug := "gui tab2 actions selected row[" A_EventInfo "]"
            ; debug .= " id[" sel_act_id "] is_sel[" is_a_selection_event "]"
            ; debug .= " er[%ErrorLevel%]"
            ; msgbox, %debug% 
         } _____DETAILS_END_____
         GuiConfigPopup.GUI_FN_ButtonSubmit_Refresh_Text()
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_EVENT_ButtonSubmit() { _____SUMMARY_END_____
   global
      GuiConfigPopup.Submit_Changes()      
   return
   } _____DETAILS_END_____
      
         
_____DETAILS_BEGIN_____1t_ GUI_FN_Cmd_Tab2_ListView_Activate() { _____SUMMARY_END_____
   global

      ;--------------------------------------------------------------------;
      ; This line ensures "Gui, " commands operate on the main GUI window  ;
      ;--------------------------------------------------------------------;
      
      Gui, PopupConfig:Default

      ;---------------------------------------------------;
      ; This line ensures ListView commands "LV_..()"     ;
      ; operate on this specific ListView                 ;
      ;---------------------------------------------------;
      
      Gui, PopupConfig:ListView, GuiConfigPopup_Cmd_Tab2_ListViewActions
      
      
      ;----------------------------------------------------------------
      ; see:                                                          
      ; https://www.autohotkey.com/docs/commands/Gui.htm#MultiWin     
      ; https://www.autohotkey.com/docs/commands/Gui.htm#Default      
      ; https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn 
      ;----------------------------------------------------------------

      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_FN_ButtonSubmit_Refresh_Text() { _____SUMMARY_END_____
   global 
      
      Gui, PopupConfig:Submit, NoHide
      
      button_text := GuiConfigPopup.get_submit_button_text()      
      c := "GuiConfigPopup_ButtonSubmit"            
      GuiControl, PopupConfig: Text, %c%, %button_text%
      
      return 
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ GUI_FN_LabelPathVerified_CheckAndRefresh() { _____SUMMARY_END_____
   global
   
      Gui, PopupConfig:Submit, NoHide
      
      is_path_valid := false
      string_for_valid_label := ""
      
      c := "GuiConfigPopup_ActionConfig_InputPath"
      GuiControlGet, path,, %c%
      
      is_valid_path := FileExist(path)
      
_____IF_DETAILS_BEGIN_____2t_ if(  is_valid_path != "" ){ _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____3t_ if( GuiConfigPopup_ActionConfig_RadioFolder ){ _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____4t_ if( InStr(is_valid_path, "D") ){ _____SUMMARY_END_____
               string_for_valid_label := "(valid folder)"
               is_path_valid := true
            } _____DETAILS_END_____
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else if( GuiConfigPopup_ActionConfig_RadioApp ){ _____SUMMARY_END_____
_____IF_DETAILS_BEGIN_____4t_ if( !InStr(is_valid_path, "D") ){ _____SUMMARY_END_____
               string_for_valid_label := "(valid file)"
               is_path_valid := true
            } _____DETAILS_END_____
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      ; msgbox % string_for_valid_label
      
      c := "GuiConfigPopup_ActionConfig_LabelVerified"
      GuiControl,, %c%, %string_for_valid_label%
      
      
      GuiConfigPopup._isPathValid := is_path_valid
      return is_path_valid
   } _____DETAILS_END_____

_____DETAILS_BEGIN_____1t_ GUI_FN_ToggleArgumentsIfNotApp() { _____SUMMARY_END_____
   global
   
      Gui, PopupConfig:Submit, NoHide
      
_____IF_DETAILS_BEGIN_____2t_ if( GuiConfigPopup_ActionConfig_RadioApp ){ _____SUMMARY_END_____
      
         GuiControl
            ,PopupConfig: -Hidden
            ,GuiConfigPopup_ActionConfig_InputArguments
            
         GuiControl
            ,PopupConfig: -Hidden
            ,GuiConfigPopup_ActionConfig_LabelArguments1
            
         GuiControl
            ,PopupConfig: -Hidden
            ,GuiConfigPopup_ActionConfig_LabelArguments2
         
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else{ ; if GuiConfigPopup_ActionConfig_RadioFolder OR if uninitialized _____SUMMARY_END_____
      
         GuiControl
            ,PopupConfig: +Hidden
            ,GuiConfigPopup_ActionConfig_InputArguments
            
         GuiControl
            ,PopupConfig: +Hidden
            ,GuiConfigPopup_ActionConfig_LabelArguments1
            
         GuiControl
            ,PopupConfig: +Hidden
            ,GuiConfigPopup_ActionConfig_LabelArguments2
      
      } _____DETAILS_END_____
      return
   } _____DETAILS_END_____

   
_____DETAILS_BEGIN_____1t_ get_submit_button_text() { _____SUMMARY_END_____
   global 
      
      button_text := ""
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;---------------------------------------------------------------------
      ; This "tab_num" var won't be used for Action New or Action Edit, 
      ; so we don't need an if branch checking "this._popup_mode"
      ;--------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ;
      ; When this function get_submit_button_text() is called from __New(), 
      ; the var "GuiConfigPopup_Cmd_Tabs" won't be populated yet, 
      ; but we can safely default it to "tab1".
      ;                                                                      _____COMMENT_DETAILS_END_____
      tab_num := ("Use Existing Action" = GuiConfigPopup_Cmd_Tabs) ? "tab2" : "tab1"
      
      
      ;--------------------------------------------------------------
      ; The static class member var "text"
      ; is an associative array holding more associative arrays.
      ;
      ; It holds the text to display on the submit button 
      ; using the kys of
      ;    - type of config popup 
      ;    - purpose for popup ("add" or "edit")
      ;    - (and for the Command popups, different text for each tab)
      ;
      button_text := ("command" == this._popup_mode)
         ;----------------------------
         ; if Command config popup
         ? this.text["command_popup"][this._popup_purpose][tab_num]
         ;----------------------------
         ; else, Action config popup
         : this.text["action_popup"][this._popup_purpose]
      
_____IF_DETAILS_BEGIN_____2t_ if( "tab2" == tab_num ){ _____SUMMARY_END_____
      
         ;------------------------------------------------------------
         ; _LV_selected_action_id, updated on ListView selection events
         ;
         lv_item_actID := GuiConfigPopup._LV_selected_action_id
         
_____IF_DETAILS_BEGIN_____3t_ if( "" != lv_item_actID ){ _____SUMMARY_END_____
            
            ;--------------------------------------------------------------------
            ; change "Use Action[]" to "Use Action[123]" on LV selection change
            ;
            button_text := RegExReplace(button_text, "^Use Action\[", "Use Action[" lv_item_actID)
            
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      return button_text
   } _____DETAILS_END_____
   
   
   
_____DETAILS_BEGIN_____1t_ Submit_Changes() { _____SUMMARY_END_____
   global
   
      Gui, PopupConfig:Submit, NoHide
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         GuiConfigPopup.Submit_Changes()
         GuiConfigPopup.Submit_Changes_1_GatherVariables()
         GuiConfigPopup.Submit_Changes_2__VerifyActionVars()
         GuiConfigPopup.Submit_Changes_2__VerifyCommandVars()
         GuiConfigPopup.Submit_Changes_3___ActionSubmit()
         GuiConfigPopup.Submit_Changes_3___CommandSubmit()
         GuiConfigPopup.Submit_Changes_4____Finalize_And_Close()
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      GuiConfigPopup.Submit_Changes_1_GatherVariables()
      
      varsOK := false 
      success := false 
      
      if("action"  == mode)
         varsOK := GuiConfigPopup.Submit_Changes_2__VerifyActionVars()
         
      if("command" == mode)
         varsOK := GuiConfigPopup.Submit_Changes_2__VerifyCommandVars()
      
_____IF_DETAILS_BEGIN_____2t_ if( varsOK == "User notified to try again." ){ _____SUMMARY_END_____
      
         ; No errors, but Command name conflict.
         ; Cancel submit, keep popup open.
         ;
         return 
         
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ if( varsOK == false ){ ;then bug; _____SUMMARY_END_____
      
         msgbox, 16, [ PROGRAM ERROR ], Failed to submit changes -- var verify failed.
         GuiConfigPopup.Submit_Changes_DEBUG()
         return
         
      } _____DETAILS_END_____
      
      if("action"  == mode)
         success := GuiConfigPopup.Submit_Changes_3___ActionSubmit()
         
      if("command" == mode)
         success := GuiConfigPopup.Submit_Changes_3___CommandSubmit()
      
_____IF_DETAILS_BEGIN_____2t_ if( success == "notified user of conflict, no errors" ){ _____SUMMARY_END_____
         return 
      } _____DETAILS_END_____
      
      if( true == success )
         GuiConfigPopup.Submit_Changes_4____Finalize_And_Close()
      
_____IF_DETAILS_BEGIN_____2t_ if( false == success ){ ;then bug; _____SUMMARY_END_____
         msgbox, 16, [ PROGRAM ERROR ], Failed to submit changes.
         GuiConfigPopup.Submit_Changes_DEBUG()
      } _____DETAILS_END_____
      
      return
      
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * _____BLOCK_COMMENT_SUMMARY_END_____
         alternate if branches, different paths but same functionality in fewer lines:
       * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       
         if("action"  == mode)
            if true =      GuiConfigPopup.Submit_Changes_2__VerifyActionVars()
               if true =  GuiConfigPopup.Submit_Changes_3___ActionSubmit()
                        GuiConfigPopup.Submit_Changes_4____Finalize_And_Close()
         
         if("command" == mode)
            if true =      GuiConfigPopup.Submit_Changes_2__VerifyCommandVars()
               if true =  GuiConfigPopup.Submit_Changes_3___CommandSubmit()
                        GuiConfigPopup.Submit_Changes_4____Finalize_And_Close()
                        
       * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      */ _____BLOCK_COMMENT_DETAILS_END_____
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_DEBUG() { _____SUMMARY_END_____
   global   
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      debug_out := "" 
      debug_out .= "mode"                           "`n["     mode                         "]`n`n"
      debug_out .= "purpose"                        "`n["     purpose                      "]`n`n"
      debug_out .= "A_input_newAction_type"         "`n["     A_input_newAction_type       "]`n`n"
      debug_out .= "B_input_newAction_path"         "`n["     B_input_newAction_path       "]`n`n"
      debug_out .= "C_input_newAction_arg "         "`n["     C_input_newAction_arg        "]`n`n"
      debug_out .= "D_input_oldAction_id     "      "`n["     D_input_oldAction_id         "]`n`n"
      debug_out .= "E_input_cmd_theCommand   "      "`n["     E_input_cmd_theCommand       "]`n`n"
      debug_out .= "TAB_cmd_tab_is_new_action"      "`n["     TAB_cmd_tab_is_new_action    "]`n`n"
      debug_out .= "F_insertion_point_for_mainLV"   "`n["     F_insertion_point_for_mainLV "]`n`n"
      
      msgbox % debug_out
      
      return
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_1_GatherVariables() { _____SUMMARY_END_____
   global 
   
_____COMMENT_DETAILS_BEGIN_____1t_ ;--------------------------------------------------------------------------------------
   ; Note on scope and globals
   ;-------------------------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
   ; ABCDEF_vars + TAB_var (in table below)  are all global 
   ;
   ; and will be used in:
   ;   - Submit_Changes_2_Action()
   ;   - Submit_Changes_3_Command()
   ;
   ; The benefit of using single instance popups
   ; is we can safely use global variables instead of parameters.
   ;
   ; The only tradeoffs are : 
   ;   - (1) We need to be sure: these vars are unique and not edited elsewhere. 
   ;   - (2) We need to  ensure: these vars are reset between Popup __New() calls.
   ;   - (3) We cannot make multiple instances of these popups 
   ;         without refactoring these globals into this._class_members.
   ;
   ; For the scope and function of this app, this design works fine.
   ;-------------------------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
   
      
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
           ------------------------------------------------------------------------
                    Vars we need to be valid in order to submit:
           ------------------------------------------------------------------------
         
      ----------------------------------------------------------------------------------
       #      var to store per input              Overview of Each Popup & Input Used
      ----------------------------------------------------------------------------------
                                  |                                
                                  |  Gui Popup: Action 
                                  |  
                                  |    purpose: add
                                  |      [x] main.LV_selected_row
       A     input_newAction_type          |      [✓] pop.newact.folder || pop.newact.app
       B     input_newAction_path          |      [✓] pop.newact.path
       C     input_newAction_arg           |      [✓] pop.newact.arg 
                                  |           
                                  |    purpose: edit
       F     LV row data["LV_id"]          |      [✓] main.LV_selected_row
       A     input_newAction_type          |      [✓] pop.newact.folder || pop.newact.app
       B     input_newAction_path          |      [✓] pop.newact.path
       C     input_newAction_arg           |      [✓] pop.newact.arg 
       D     input_oldAction_id            |      [✓] pop.oldact.id
                                  |  
                                  |  
                                  |  Gui Popup: Command 
                                  |  
                                  |    purpose: add
                                  |  
                                  |      [x] main.LV_selected_row
       E     input_cmd_theCommand          |      [✓] pop.cmd
                                  |  
       TAB   cmd_tab_is_new_action         |      if tab: add action
       A     input_newAction_type          |          [✓] pop.newact.folder || pop.newact.app
       B     input_newAction_path          |          [✓] pop.newact.path
       C     input_newAction_arg           |          [✓] pop.newact.arg 
                                  |  
       TAB   cmd_tab_is_new_action         |      if tab: use existing action
       D     input_oldAction_id            |          [✓] pop.oldact.id
                                  |            
                                  |    purpose: edit
                                  |                                
       F     LV row data["LV_id"]          |      [✓] main.LV_selected_row
       E     input_cmd_theCommand          |      [✓] pop.cmd
                                  |                                
       TAB   cmd_tab_is_new_action         |      if tab: add action
       A     input_newAction_type          |          [✓] pop.newact.folder || pop.newact.app
       B     input_newAction_path          |          [✓] pop.newact.path
       C     input_newAction_arg           |          [✓] pop.newact.arg 
                                  |                                
       TAB   cmd_tab_is_new_action         |      if tab: use existing action
       D     input_oldAction_id            |          [✓] pop.oldact.id
                                  |                                
                                  |                                
      ----------------------------------------------------------------------------------
      [A,B,C,D,E,F,TAB]          Which Popups use which of the var #s? 
      ----------------------------------------------------------------------------------
      
           A :            act.add, act.edit,   cmd.add.tab1, cmd.edit.tab1
           B :            act.add, act.edit,   cmd.add.tab1, cmd.edit.tab1
           C :            act.add, act.edit,   cmd.add.tab1, cmd.edit.tab1
           D :                     act.edit,   cmd.add.tab2, cmd.edit.tab2
           E :                                 cmd.add,      cmd.edit
           F :                     act.edit,                 cmd.edit
         TAB :                                 cmd.add       cmd.edit
         
      ----------------------------------------------------------------------------------
      
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      
      A_input_newAction_type       := ""     ; A ;   all pop.act,   all pop.cmd (if tab 1)
      B_input_newAction_path       := ""     ; B ;   all pop.act,   all pop.cmd (if tab 1)
      C_input_newAction_arg        := ""     ; C ;   all pop.act,   all pop.cmd (if tab 1)
      
      D_input_oldAction_id         := ""     ; D ;       pop.edit   all pop.cmd (if tab 2)
      E_input_cmd_theCommand       := ""     ; E ;                  all pop.cmd
      TAB_cmd_tab_is_new_action    := ""     ; TAB ;                all pop.cmd
      
      F_insertion_point_for_mainLV := ""     ; F ;   edit pop.act, edit pop.cmd
      
      
_____IF_DETAILS_BEGIN_____2t_ if("edit" == purpose){ _____SUMMARY_END_____
      
_____COMMENT_DETAILS_BEGIN_____3t_ ;-----------------------------------------------------------------------
         ; If editing a Command or an Action 
         ;----------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
         ;
         ; the original needs a valid insertion point 
         ; in GuiConfigMain's corresponding ListView.
         ;
         ; Before the popup was rendered, the Action or Command 
         ; was removed from _ACTIONS or _COMMANDS 
         ; to make duplication-checking logic simpler below 
         ; (and that entry will be added back, possibly modified,
         ;  after successful Submit). 
         ;
         ; Their entry inside their ListView is still there in the GUI, unaltered 
         ; (but will be changed upon a successful edit)
         ;----------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
         
         ;---;
         ; F ;
         ;---;
         F_insertion_point_for_mainLV := GuiConfigPopup._LV_RowData_FromMainGui["LV_id"]
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ if( "command" == mode ){ _____SUMMARY_END_____
      
         ;-----;
         ; TAB ;
         ;-----;
         TAB_cmd_tab_is_new_action := ("Add New Action" = GuiConfigPopup_Cmd_Tabs) ? true : false
         
         ;---;
         ; E ;
         ;---;
         c := "GuiConfigPopup_Cmd_InputCommandName"
         GuiControlGet, cmd,, %c%
         E_input_cmd_theCommand := cmd 

         ;-------------------------------------
         ; Command Tab2 "Use Existing Action"
         ;-------------------------------------
         ;
_____IF_DETAILS_BEGIN_____3t_ if( false == TAB_cmd_tab_is_new_action ){ _____SUMMARY_END_____
            ; tmp := GuiConfigPopup._LV_selected_action_id
            ; msgbox in gather lv is %tmp%
            
            action_id := GuiConfigPopup._LV_selected_action_id
            
_____IF_DETAILS_BEGIN_____4t_ if( _ACTIONS.HasKey(action_id) ){ _____SUMMARY_END_____
            
               ;---;   ;---;   ;---;
               ; A ;   ; B ;   ; C ;
               ;---;   ;---;   ;---;
               A_input_newAction_type := _ACTIONS[action_id]["type"]
               B_input_newAction_path := _ACTIONS[action_id]["path"]
               C_input_newAction_arg  := _ACTIONS[action_id]["arg"]
               
               ;---;
               ; D ;
               ;---;
               D_input_oldAction_id := action_id
            } _____DETAILS_END_____
            
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ if("action" == mode
      or true     == TAB_cmd_tab_is_new_action){ _____SUMMARY_END_____
         
         
         ;---;
         ; A ;
         ;---;
_____IF_DETAILS_BEGIN_____3t_ if(GuiConfigPopup_ActionConfig_RadioFolder){ _____SUMMARY_END_____
            A_input_newAction_type := "folder"
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else if( GuiConfigPopup_ActionConfig_RadioApp ){ _____SUMMARY_END_____
            A_input_newAction_type := "app"
         } _____DETAILS_END_____
         
         ;---------------------------------------------------
         ; sets GuiConfigPopup._isPathValid to true or false
         ;
         GuiConfigPopup.GUI_FN_LabelPathVerified_CheckAndRefresh()
_____IF_DETAILS_BEGIN_____3t_ if( GuiConfigPopup._isPathValid ){ _____SUMMARY_END_____
         
            ;---;
            ; B ;
            ;---;
            c := "GuiConfigPopup_ActionConfig_InputPath"
            GuiControlGet, path,, %c%
            B_input_newAction_path := path
            ; msgbox in gather path is {%path%}
         } _____DETAILS_END_____
         
         ;-----------------------------------------------------------
         ; Only actions which open an application
         ; will possibly have a custom Argument provided by the user 
         ;
_____IF_DETAILS_BEGIN_____3t_ if( GuiConfigPopup_ActionConfig_RadioApp ){ _____SUMMARY_END_____
         
            ;---;
            ; C ;
            ;---;
            c := "GuiConfigPopup_ActionConfig_InputArguments"
            GuiControlGet, userInputArg,, %c%
            C_input_newAction_arg := userInputArg
         } _____DETAILS_END_____
         
_____IF_DETAILS_BEGIN_____3t_ if( "action" == mode 
         and "edit"   == purpose ){ _____SUMMARY_END_____
            
               ;---;
               ; D ;
               ;---;
               D_input_oldAction_id := GuiConfigMain._plucked_action["action_id"]
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
      ; msgbox gather: path[%B_input_newAction_path%]
      
      ;-------------------------------------;
      ;   A,B,C,D,E,F,TAB are now all set   ;
      ;-------------------------------------;
      ;   1 - [✓] Gather Variables          ;
      ;-------------------------------------;
      
      ;-----------------------------------------------------------;
      ; GuiConfigPopup.Submit_Changes()                           ;
      ; will continue from here and:                              ;
      ;-----------------------------------------------------------;
      ;   2 - validate the vars                                   ;
      ;   3 - attempt to submit if all vars valid                 ;
      ;   4 - then if it all worked: close down the gui instance  ;
      ;-----------------------------------------------------------;
      
      return
   } _____DETAILS_END_____
      
_____DETAILS_BEGIN_____1t_ Submit_Changes_2__VerifyActionVars() { _____SUMMARY_END_____
   global 
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         A_input_newAction_type       := ""     ; A ;   all pop.act
         B_input_newAction_path       := ""     ; B ;   all pop.act
         C_input_newAction_arg        := ""     ; C ;   all pop.act
         D_input_oldAction_id         := ""     ; D ;       pop.edit   all pop.cmd (if tab 2)
         
         F_insertion_point_for_mainLV := ""     ; F ;   edit pop.act
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      FAILURE := false
      SUCCESS := true
      USER_NOTIFIED := "User notified to try again."
         
         
         
      ;=========================
      ; Cancel if vars not set
      ;=========================
      
      ;---;   ;---;   ;---;
      ; A ;   ; B ;   ; C ;
      ;---;   ;---;   ;---;
_____IF_DETAILS_BEGIN_____2t_ if( "" == A_input_newAction_type
      or  "" == B_input_newAction_path ){ _____SUMMARY_END_____
      ; it's okay if C_input_newAction_arg is empty
      
         return FAILURE
         
      } _____DETAILS_END_____
   
_____IF_DETAILS_BEGIN_____2t_ if("edit" == purpose){ _____SUMMARY_END_____
      
         ;---;
         ; D ;
         ;---;
_____IF_DETAILS_BEGIN_____3t_ if( "" == D_input_oldAction_id ){ _____SUMMARY_END_____
            return FAILURE            
         } _____DETAILS_END_____
         
         ;---;
         ; F ;
         ;---;
_____IF_DETAILS_BEGIN_____3t_ if( "" == F_insertion_point_for_mainLV ){ _____SUMMARY_END_____
            return FAILURE
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      
      
      
      ;========================================================
      ; Standardize Action Path (directory or app) string
      ;========================================================
      
      ;--------------------------------------------------
      ; Standardize paths like:
      ;    "C:/somdir\another/dir"
      ; 
      ; to have uniform backslashes and trailing slashes:
      ;    "C:\somdir\another\dir\"
      ;
      p1 := B_input_newAction_path
      p2 := A_input_newAction_type
      
      ;---;
      ; B ;
      ;---;
      B_input_newAction_path := FILE_HELPER.Fn_Standardize_Path_String( p1, p2 )
      
      
      
      ;========================================================
      ; Check for identical preexisting Actions
      ;========================================================
      
      found_duplicate_action := GuiConfigPopup.does_action_already_exist( ""
         .   A_input_newAction_type
           , B_input_newAction_path
           , C_input_newAction_arg  )
      
_____IF_DETAILS_BEGIN_____2t_ if( found_duplicate_action ){ _____SUMMARY_END_____
         inform_user := "Action already exists.`n`n"
         inform_user .= "Action[" found_duplicate_action "] is already configured to do this:`n"
         inform_user .= "    Type:`t" A_input_newAction_type "`n"
         inform_user .= "    Path:`t" B_input_newAction_path "`n"
         inform_user .= ("" != C_input_newAction_arg) 
                     ? "    Arg:`t" C_input_newAction_arg 
                     : "`n`n"
         inform_user .= "`n`n"
         inform_user .= "No action taken."
         
         MsgBox,, [Duplicate Action], %inform_user%
         return USER_NOTIFIED
      } _____DETAILS_END_____
      
      
      
      ;------------------------------------------------------;
      ;   If this line is reached, then all vars are good!   ;
      ;------------------------------------------------------;
      ;   1 - [✓] Gather Variables                           ;
      ;   2 - [✓] Verify Variables                           ;
      ;------------------------------------------------------;
      
      ;-----------------------------------------------------------;
      ; GuiConfigPopup.Submit_Changes()                           ;
      ; will continue from here and:                              ;
      ;-----------------------------------------------------------;
      ;   3 - attempt to submit changes and (if succeessful)      ;
      ;   4 - close down the gui instance                         ;
      ;-----------------------------------------------------------;
      
      return SUCCESS
   } _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_2__VerifyCommandVars() { _____SUMMARY_END_____
   global 
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         A_input_newAction_type       := ""     ; A ;     all pop.cmd (if tab 1)
         B_input_newAction_path       := ""     ; B ;     all pop.cmd (if tab 1)
         C_input_newAction_arg        := ""     ; C ;     all pop.cmd (if tab 1)
         
         D_input_oldAction_id         := ""     ; D ;     all pop.cmd (if tab 2)
         E_input_cmd_theCommand       := ""     ; E ;     all pop.cmd
         F_insertion_point_for_mainLV := ""     ; F ;   edit  pop.cmd
         
         TAB_cmd_tab_is_new_action    := ""     ; TAB ;   all pop.cmd
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      ; msgbox in verfcmd
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      is_tab_1 := TAB_cmd_tab_is_new_action
      is_tab_2 := !TAB_cmd_tab_is_new_action
      
      SUCCESS := true
      FAILURE := false
      USER_NOTIFIED := "User notified to try again."
      
      
      ;=========================
      ; Cancel if vars not set
      ;=========================
      
      ;--------------------------------
      ; Tab1 -> "Add New Action" tab.
      ;
_____IF_DETAILS_BEGIN_____2t_ if( is_tab_1 ){ _____SUMMARY_END_____
      
         ;---;   ;---;   ;---;
         ; A ;   ; B ;   ; C ;
         ;---;   ;---;   ;---;
_____IF_DETAILS_BEGIN_____3t_ if( "" == A_input_newAction_type
         or  "" == B_input_newAction_path ){ _____SUMMARY_END_____
         ; it's okay if C_input_newAction_arg is empty 
         
            return FAILURE
            
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      ;---------------------------------------
      ; Tab2 -> "Using Existing Action" tab.
      ;
_____IF_DETAILS_BEGIN_____2t_ if( is_tab_2 ){ _____SUMMARY_END_____
      
         ;---;
         ; D ;
         ;---;
_____IF_DETAILS_BEGIN_____3t_ if( "" == D_input_oldAction_id ){ ; error _____SUMMARY_END_____
            return FAILURE
         } _____DETAILS_END_____
      
      } _____DETAILS_END_____
      
      ;-------------------------
      ; Either Tab 
      ;-------------------------
      
      ;---;
      ; E ;
      ;---;
_____IF_DETAILS_BEGIN_____2t_ if( "" == E_input_cmd_theCommand ){ ; error _____SUMMARY_END_____
      ; If Command text is empty 
      
         
         return FAILURE         
      } _____DETAILS_END_____
      
      
_____IF_DETAILS_BEGIN_____2t_ if("edit" == purpose){ _____SUMMARY_END_____
      
         ;---;
         ; F ;
         ;---;
_____IF_DETAILS_BEGIN_____3t_ if( "" == F_insertion_point_for_mainLV ){  ; error _____SUMMARY_END_____
            return FAILURE
         } _____DETAILS_END_____
         
      } _____DETAILS_END_____
      
      
      ;========================================================
      ; Ensure Command (if renamed) is unique.
      ;========================================================
      
      ;---;
      ; E ;
      ;---;
_____IF_DETAILS_BEGIN_____2t_ if( _COMMANDS.HasKey( E_input_cmd_theCommand ) ){ _____SUMMARY_END_____
      ; If another Command already uses this text 
      
         
         usr_output := "Oops, there's already a command with the word or phrase:`n`n"
         usr_output .= "    " E_input_cmd_theCommand "`n`n"
         usr_output .= "Either remove that command first,`n"
         usr_output .= "or try another phrase."
         
         MsgBox,,Duplicate Command, %usr_output%         
         
         return USER_NOTIFIED         
      } _____DETAILS_END_____
      
      
      
      ;========================================================
      ; If new Action:
      ;
      ;   Standardize all Action path strings
      ;   (a) So all path strings are uniform across the App.
      ;   (b) To aid in comparisons searching for duplicates.
      ;========================================================
      
      ;--------------------------------
      ; Tab1 -> "Add New Action" tab.
      ;
_____IF_DETAILS_BEGIN_____2t_ if( is_tab_1 ){ _____SUMMARY_END_____
      
         ;========================================================
         ; Format Action Path (directory or app) string
         ;========================================================
         
         ;--------------------------------------------------
         ; Standardize paths like:
         ;    "C:/somdir\another/dir"
         ; 
         ; to have uniform backslashes and trailing slashes:
         ;    "C:\somdir\another\dir\"
         ;
         p1 := B_input_newAction_path
         p2 := A_input_newAction_type
         
         
         ;---;
         ; B ;
         ;---;
         B_input_newAction_path := FILE_HELPER.Fn_Standardize_Path_String( p1, p2 )
         
      } _____DETAILS_END_____
      
      
      ;------------------------------------------------------;
      ;   If this line is reached, then all vars are good!   ;
      ;------------------------------------------------------;
      ;   1 - [✓] Gather Variables                           ;
      ;   2 - [✓] Verify Variables                           ;
      ;------------------------------------------------------;
      
      ;-----------------------------------------------------------;
      ; GuiConfigPopup.Submit_Changes()                           ;
      ; will continue from here and:                              ;
      ;-----------------------------------------------------------;
      ;   3 - attempt to submit changes and (if succeessful)      ;
      ;   4 - close down the gui instance                         ;
      ;-----------------------------------------------------------;
      
      return SUCCESS
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_3___ActionSubmit() { _____SUMMARY_END_____
   global
   
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         A_input_newAction_type       := ""     ; A ;   all pop.act
         B_input_newAction_path       := ""     ; B ;   all pop.act
         C_input_newAction_arg        := ""     ; C ;   all pop.act
         
         F_insertion_point_for_mainLV := ""     ; F ;   edit pop.act
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      FAILURE := false
      SUCCESS := true
      USER_NOTIFIED := "notified user of conflict, no errors"
      
      popup_actionType := A_input_newAction_type
      popup_actionPath := B_input_newAction_path
      popup_actionArg  := C_input_newAction_arg
      
      popup_actionID   := ""

_____IF_DETAILS_BEGIN_____2t_ if( "add" == purpose ){ _____SUMMARY_END_____
         popup_actionID := _ACTIONS.Length()+1   
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ if( "edit" == purpose ){ _____SUMMARY_END_____
         popup_actionID := D_input_oldAction_id      
      } _____DETAILS_END_____
      
      
      
      ;========================================================
      ; Submit new or edited Action to _ACTIONS array 
      ;========================================================
      
_____IF_DETAILS_BEGIN_____2t_ if( !_ACTIONS.HasKey(popup_actionID) ){ _____SUMMARY_END_____
         
         _ACTIONS[popup_actionID] := { "" 
            . "type": popup_actionType
            , "path": popup_actionPath
            , "arg" : popup_actionArg   }
            
      } _____DETAILS_END_____
      
      
      
      ;=======================================================================
      ; Submit new or edited Action to ListView for Actions in GuiConfigMain
      ;=======================================================================
      
      ;------------------------------------------------------------------------------
      ; Tells future ListView operations to operate on this specific ListView control
      GuiConfigMain.ListViewActions_Activate()
      
      LV_FAILURE := 0
      
_____IF_DETAILS_BEGIN_____2t_ if( "add" == purpose ){ _____SUMMARY_END_____
      
         options := ""
         LV_returned := LV_ADD( ""
            . options             ; no options needed
            , popup_actionID        ; row 1
            , popup_actionType      ; row 2
            , popup_actionPath      ; row 3
            , popup_actionArg  )    ; row 4
         
         ; for debugging
         ;
         ; msgBOX lv %LV_returned%
         ; GuiConfigPopup.Submit_Changes_DEBUG()
         
         ;----------------------------------------------
         ; cancel submit, inform user, return to popup
         ;
_____IF_DETAILS_BEGIN_____3t_ if(LV_returned == LV_FAILURE ){ _____SUMMARY_END_____
            MSGBOX, Failed to add new action to ListView.
            
            GuiConfigPopup.Submit_Changes_DEBUG()
            
            return FAILURE
         } _____DETAILS_END_____
      } _____DETAILS_END_____
      
_____IF_DETAILS_BEGIN_____2t_ else
      if( "edit" == purpose){ _____SUMMARY_END_____
      
         modify_this_row := F_insertion_point_for_mainLV
         
         LV_returned := LV_MODIFY( modify_this_row
            ,                     ; no options needed
            , popup_actionID      ; row 1
            , popup_actionType       ; row 2
            , popup_actionPath       ; row 3
            , popup_actionArg  )    ; row 4
         
_____IF_DETAILS_BEGIN_____3t_ if(LV_returned == LV_FAILURE ){ _____SUMMARY_END_____
            msgbox, Failed to edit existing action in ListView.
            
            GuiConfigPopup.Submit_Changes_DEBUG()
            
            return FAILURE
         } _____DETAILS_END_____
            
         ;----------------------------------------
         ; Remove backup of (now) edited Action
         ;----------------------------------------
         ; Making this variable empty will prevent 
         ;
         ;   GUI_EVENT_GuiConfigPopup_OnClose and
         ;   GUI_EVENT_GuiConfigPopup_OnEscape
         ;
         ; from automatically restoring 
         ; the old version of this Action
         ;
         ; when the GuiConfigPopup GUI is closed.
         ;----------------------------------------
         
         GuiConfigMain.Discard_Plucked_Action()
         
         GuiConfigMain.ListViewCommands_UpdateAllWhichUseAction(popup_actionID)
      } _____DETAILS_END_____
      
      
      
      ;=======================================================================
      ; Submit changes to Savefile (all above operations were successful)
      ;=======================================================================
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;-------------------------------------------------------------------
      ; Syntax Reference
      ;------------------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ; class:    FILE_HELPER
      ; function: Change_Savefile( p1,p2,p3,p4 )
      ;
      ; p1:  mode                      action|command
      ; p2:  purpose                   add|delete|edit|enable|disable
      ; p2:  action_id__or__cmd        new Action's ID 
      ; p2:  cmd_name_before_rename    not applicable here
      ;------------------------------------------------------------------- _____COMMENT_DETAILS_END_____
      
      p1 := "action"
      p2 := purpose 
      p3 := popup_actionID
      p4 := ""
      savefile_updated := FILE_HELPER.Change_Savefile( p1,p2,p3,p4 )
      
_____IF_DETAILS_BEGIN_____2t_ if( !savefile_updated ){ _____SUMMARY_END_____
         MSGBOX, 16, ERROR WRITING TO SAVEFILE, [~]
         return FAILURE
      } _____DETAILS_END_____
      
      
      return SUCCESS
      
   } ; end of Submit_Changes_3___ActionSubmit() _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ does_action_already_exist(action_type, action_path, action_arg:="") { _____SUMMARY_END_____
   global 
   
      ;===========================================
      ; return 0 if no Action matches this config
      ;===========================================
      
      id_exists := 0
      
_____IF_DETAILS_BEGIN_____2t_ for id, action in _ACTIONS 
      { _____SUMMARY_END_____
         aType := action["type"]
         aPath := action["path"]
         aArg  := action["arg"]
         
_____IF_DETAILS_BEGIN_____3t_ if( aType == action_type 
         and aPath == action_path 
         and aArg  == action_arg ){ _____SUMMARY_END_____
         
            id_exists := id 
            break
            
         } _____DETAILS_END_____

      } _____DETAILS_END_____
      
      return id_exists
   } _____DETAILS_END_____
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_3___CommandSubmit() { _____SUMMARY_END_____
   global 
   
/* _____BLOCK_COMMENT_DETAILS_BEGIN_____2t_  _____BLOCK_COMMENT_SUMMARY_END_____
         A_input_newAction_type       := ""     ; A ;     all pop.cmd (if tab 1)
         B_input_newAction_path       := ""     ; B ;     all pop.cmd (if tab 1)
         C_input_newAction_arg        := ""     ; C ;     all pop.cmd (if tab 1)
         
         D_input_oldAction_id         := ""     ; D ;     all pop.cmd (if tab 2)
         E_input_cmd_theCommand       := ""     ; E ;     all pop.cmd
         F_insertion_point_for_mainLV := ""     ; F ;   edit  pop.cmd
         
         TAB_cmd_tab_is_new_action    := ""     ; TAB ;   all pop.cmd
      */ _____BLOCK_COMMENT_DETAILS_END_____
      
      mode    := GuiConfigPopup._popup_mode
      purpose := GuiConfigPopup._popup_purpose
      
      FAILURE := false
      SUCCESS := true
      
      is_action_new := false
      
      is_tab_1 := TAB_cmd_tab_is_new_action
      is_tab_2 := !TAB_cmd_tab_is_new_action
      
      popup_cmd        := E_input_cmd_theCommand
      popup_actionType := A_input_newAction_type
      popup_actionPath := B_input_newAction_path
      popup_actionArg  := C_input_newAction_arg
      
      popup_actionID   := ""
         use_actionID   := ""
      
      original_command_name := GuiConfigMain._plucked_command["command"]
      
      
      ;==============================================================
      ; Determine Action ID 
      ;   (if duplicate, use preexisting, don't make a new Action).
      ;==============================================================
      
      ;--------------------------------
      ; Tab1 -> "Add New Action" tab.
      ;
_____IF_DETAILS_BEGIN_____2t_ if( is_tab_1 ){ _____SUMMARY_END_____
         
_____COMMENT_DETAILS_BEGIN_____3t_ ;--------------------------------------------------------
         ; Determine Action ID - New or use Preexisting
         ;-------------------------------------------------------- _____COMMENT_SUMMARY_END_____
         ;
         ; If user is on the "Add New Action" tab
         ; an unused ID will be assigned to the new Action.
         ; 
         ; However, if the entire "Add New Action" config 
         ; matches an identical preexisting Action
         ; that Action will be used instead of creating a new one.
         ;                                                          _____COMMENT_DETAILS_END_____
         use_actionID := _ACTIONS.Length()+1   
         
         duplicate_action_id_found := GuiConfigPopup.does_action_already_exist(""
            .   popup_actionType
              , popup_actionPath
              , popup_actionArg)
         
_____IF_DETAILS_BEGIN_____3t_ if( duplicate_action_id_found ){ _____SUMMARY_END_____
            use_actionID := duplicate_action_id_found
         } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____3t_ else{ _____SUMMARY_END_____
         
            is_action_new := true
            
         } _____DETAILS_END_____
      }       _____DETAILS_END_____
      ;---------------------------------------
      ; Tab2 -> "Using Existing Action" tab.
      ;
_____IF_DETAILS_BEGIN_____2t_ else if( is_tab_2 ){ _____SUMMARY_END_____
      
         ;--------------------------------------------------
         ; Determine Action ID -- use existing Action's ID
         ;--------------------------------------------------
         ;
         use_actionID := D_input_oldAction_id
      } _____DETAILS_END_____
      
      
      ;=============
      ; Action ID 
      ;=============
      
      popup_actionID   := use_actionID
      
      
      
      
      ; msgbox popup_cmd[%popup_cmd%] path[%popup_actionPath%] type[%popup_actionType%] 
      
      
      
      
      ;========================================================
      ; Submit Command (new or modified):
      ; to _COMMANDS array 
      ;========================================================      
      
_____COMMENT_DETAILS_BEGIN_____2t_ ;---------------------------------------------------------
      ; Assign a key value pair in _COMMANDS 
      ;--------------------------------------------------------- _____COMMENT_SUMMARY_END_____
      ;
      ; If this is a new Command, 
      ; then it has never been in _COMMANDS.
      ;
      ; If this is an existing Command being edited, 
      ; then GuiConfigMain plucked it from _COMMANDS to 
      ; simplify the code here.
      ;
      ; Key: 
      ;        This Command's phrase
      ;        (stored in popup_cmd)
      ; Value:
      ;        An associative array holding:
      ;         Key:   "enabled" 
      ;         Value: true or false 
      ;                  (true if a new command,
      ;                  otherwise we'll use its original state)
      ;         Key:   "action_id" 
      ;         Value: The integer ID for the Action
      ;                  (currently stored in popup_actionID)
      ;--------------------------------------------------------- _____COMMENT_DETAILS_END_____
      
      cmd        := popup_cmd
      aID        := popup_actionID
      is_enabled := ("add"==purpose) 
                  ? "true" 
                  : GuiConfigMain._plucked_command["enabled"]
                  
                  ;------------------------------------------------------
                  ; AutoHotkey Docs, Ternary Operator: 
                  ; https://www.autohotkey.com/docs/Variables.htm#ternary
                  ;------------------------------------------------------
      
      
      _COMMANDS[cmd] := { "action_id":aID, "enabled":is_enabled }
      
      
      
      ;===================================================
      ; Submit Command (new or modified) 
      ; to GuiConfigMain's Command ListView
      ;===================================================
      
      ;----------------------------------------------------------------
      ; This label ensures the next AHK ListView function ("LV_...()")
      ; will specifically use GuiConfigMain's ListView for Commands
      ;----------------------------------------------------------------
      
      GuiConfigMain.ListViewCommands_Activate()
      
      ; msgbox cmd submit: purpose is [%purpose%]
      
_____IF_DETAILS_BEGIN_____2t_ if("add" == purpose){ _____SUMMARY_END_____
         
         options := "+Check"
         LV_ADD( options      ; enable by default
            , popup_cmd             ; row 1
            ,                       ; row 2 is always empty
            , popup_actionID      ; row 3
            , popup_actionType       ; row 4
            , popup_actionPath       ; row 5
            , popup_actionArg  )    ; row 6
         
      } _____DETAILS_END_____
_____IF_DETAILS_BEGIN_____2t_ else 
      if("edit" == purpose){ _____SUMMARY_END_____
      
         ;---------------------------------------------------------------------
         ; Update the Command's entry in GuiConfigMain's ListView for Commands
         ;---------------------------------------------------------------------
      
         modify_this_row := F_insertion_point_for_mainLV
         
         ;[~]
         
         LV_MODIFY(modify_this_row
            ,                     ; no options needed
            , popup_cmd             ; row 1
            ,                       ; row 2 is always empty
            , popup_actionID      ; row 3
            , popup_actionType       ; row 4
            , popup_actionPath       ; row 5
            , popup_actionArg  )    ; row 6
            
_____COMMENT_DETAILS_BEGIN_____3t_ ;----------------------------------------
         ; Remove backup of (now) edited command
         ;---------------------------------------- _____COMMENT_SUMMARY_END_____
         ; Making this variable empty will prevent 
         ;
         ;   GUI_EVENT_GuiConfigPopup_OnClose and
         ;   GUI_EVENT_GuiConfigPopup_OnEscape
         ;
         ; from automatically restoring 
         ; the old version of this Command
         ;
         ; when the GuiConfigPopup GUI is closed.
         ;---------------------------------------- _____COMMENT_DETAILS_END_____
         
         GuiConfigMain.Discard_Plucked_Command()
      } _____DETAILS_END_____
      
      
      
      ;========================================================
      ; Add if Action is new:
      ;
      ;    Submit new Action to _ACTIONS array 
      ;    Submit new Action to GuiConfigMain's Action ListView
      ;    Submit new Action to Savefile
      ;========================================================
         
_____IF_DETAILS_BEGIN_____2t_ if( is_action_new ){ _____SUMMARY_END_____
      
         ;========================================
         ; Submit Action 
         ; to GuiConfigMain's Action ListView
         ;========================================
         
_____IF_DETAILS_BEGIN_____3t_ if( !_ACTIONS.HasKey(popup_actionID) ){ _____SUMMARY_END_____
            
            _ACTIONS[popup_actionID] := {"type":popup_actionType
                                 , "path":popup_actionPath
                                 , "arg" :popup_actionArg  }
            
            GuiConfigMain.ListViewActions_AddNewAction(popup_actionID
               , popup_actionType
               , popup_actionPath
               , popup_actionArg)            
         } _____DETAILS_END_____
         
         ;========================================
         ; Submit Action to Savefile 
         ;========================================
         
         ;-------------------------------------------------------------------
         ; Syntax Reference
         ;-------------------------------------------------------------------
         ; class:    FILE_HELPER
         ; function: Change_Savefile( p1,p2,p3,p4 )
         ;
         ; p1:  mode                      action|command
         ; p2:  purpose                   add|delete|edit|enable|disable
         ; p2:  action_id__or__cmd        new Action's ID 
         ; p2:  cmd_name_before_rename    not applicable here
         ;-------------------------------------------------------------------
         
         p1 := "action"
         p2 := "add" 
         p3 := popup_actionID
         p4 := ""
         savefile_updated := FILE_HELPER.Change_Savefile( p1,p2,p3,p4 )
         
_____IF_DETAILS_BEGIN_____3t_ if( !savefile_updated ){ _____SUMMARY_END_____
            MSGBOX, 16, ERROR WRITING NEW ACTION TO SAVEFILE, [~]
            return FAILURE
         } _____DETAILS_END_____
         
         
      } _____DETAILS_END_____
      
      
      ;=======================================================================
      ; Submit Command (new or modified)
      ; to Savefile (all above operations were successful)
      ;=======================================================================
      
      ;-------------------------------------------------------------------
      ; Syntax Reference
      ;-------------------------------------------------------------------
      ; class:    FILE_HELPER
      ; function: Change_Savefile( p1,p2,p3,p4 )
      ;
      ; p1:  mode                      action|command
      ; p2:  purpose                   add|delete|edit|enable|disable
      ; p2:  action_id__or__cmd        updated text for Command
      ; p2:  cmd_name_before_rename    old text before Command renamed
      ;-------------------------------------------------------------------
      
      p1 := mode
      p2 := purpose 
      p3 := popup_cmd
      p4 := original_command_name
      savefile_updated := FILE_HELPER.Change_Savefile( p1,p2,p3,p4 )
         
_____IF_DETAILS_BEGIN_____2t_ if( !savefile_updated ){ _____SUMMARY_END_____
         MSGBOX, 16, ERROR WRITING COMMAND TO SAVEFILE, [~]
         return FAILURE
      } _____DETAILS_END_____
      
      
      return SUCCESS
         
   } ; end of Submit_Changes_3___CommandSubmit() _____DETAILS_END_____
   
   
_____DETAILS_BEGIN_____1t_ Submit_Changes_4____Finalize_And_Close() { _____SUMMARY_END_____
   global
      GuiConfigMain.ListViewActions_ReadjustAllCols()
      GuiConfigMain.ListViewCommands_ReadjustAllCols()
      
      GuiConfigPopup.GUI_EVENT_OnClose()
      return
   } _____DETAILS_END_____


;=======================================================================
;         end of class:
;         GuiConfigPopup (Popup from GuiConfigMain's first tab)
;=======================================================================

} _____DETAILS_END_____



_____DETAILS_BEGIN_____0t_ class REUSABLE_GUI_CONTROLS { _____SUMMARY_END_____

_____DETAILS_BEGIN_____1t_ create_listview_of_actions( GuiName, GotoFuncOnEvent, ControlNameForLV ) { _____SUMMARY_END_____
   global 
      
      options := A_Space "g" GotoFuncOnEvent  ;"GuiConfigMain.GUI_EVENT_ListViewActions" 
      options .= A_Space "v" ControlNameForLV ;"GuiConfigMain_ListViewActions" 
      options .= A_Space "-checked +ReadOnly +AltSubmit -Multi" 
      options .= A_Space "r20 w700" 
      options .= A_Space "+LV0x10000" 
         ; see: https://www.autohotkey.com/docs/misc/Styles.htm#ListView
      
      
      text_column1 := "Action ID"
      text_column2 := "|Action Type"
      text_column3 := "|Action Path"
      text_column4 := "|Action Arg for Programs"
      text := text_column1
                             .  text_column2
                             .  text_column3
                             .  text_column4
      
      Gui, %GuiName%:Add, ListView
         , %options%
         ,    %text%
      
      
      
      Gui, %GuiName%:Default
      Gui, %GuiName%:ListView, %ControlNameForLV%
      
_____IF_DETAILS_BEGIN_____2t_ for id, action in _ACTIONS { _____SUMMARY_END_____
         action_type := action["type"]
         action_path := action["path"]
         action_arg  := action["arg"]
         
         LV_Add(, id, action_type, action_path, action_arg )
         
      } _____DETAILS_END_____
      
      return
   } _____DETAILS_END_____

} _____DETAILS_END_____



 









































