AutoHotkey
================

.. code-block:: AutoHotkey_CustomLexer

  class Whatever {

    // comment
    /* comment
       block
    */
    _puppies := 
    
    __New( _a_thing ){
      int hello = 3 * ( 12+2.34 );
      kitten := 'm' + 'e' + 'o' + 'w'                     ;test 
      string _puppies = "say woof!" and %kitten% 
      call_me(3)
      call_me(int number){
        return true
      } 
      #ClipboardTimeout    
      for(i=0;i<10;i++){
        if( i == 9 ){
          Msgbox, A_ThisFunc is %A_ThisFunc%
          continue;
          break;
        }
        else{
          MsgBox, 16, PARSE ERROR
        }    
      }
    }
        

  };

.. code-block:: AutoHotkey_CustomLexer
   :linenos:


    ^F1:: run calc.exe
    ;-----------------------------------------------------
    #If not GetKeyState("NumLock", "T")
    ;-----------------------------------------------------
    {
      >^NumpadUp::
    }
    #If
    Puppies := 0
    Kitten := (puppies * 3) + 999
    class GUI_CONTROL_BASE {
    _gui_container_hwnd := ""
    _ctrl_handle_hwnd := ""
    _ctrl_descriptor := ""

		GuiControlGet, CtrlXY_, Pos, %cHwnd%
    toString(){
     return this._ctrl_descriptor
    }

  	Loop, Files, %DIR_SPHINX%\*.*, DF
  	{
    ;-------------------------------------------
    ; get string for use in call
    ;		Gui, Add, %cType%, option123 ..
    ;-------------------------------------------
    Gui_cType(){
     return "[err]Gui_Control_Base -- <~> override me"
    }
    __New(){

    }
    __Delete(){
     cc( "_ [delete] GUI_CONTROL_BASE :: `t __Delete()",7,"d,ctrl,b" )   ;destructor,guiControl,base_class


     _gui_container_hwnd := ""

     ;~ tmp_out := this._ctrl_descriptor

     ;          ( that is, keys; strings with which values are associated)"
     this.Remove("", Chr(255))

     this.base := 3
    }

    get_ctrlHwnd(){
     return this._ctrl_handle_hwnd
    }

    get_container_gui_object(){
     h := this._gui_container_hwnd
     if( h ){
       g := GUI_BASE.GUI_GET_obj_from_hwnd( h )
       if( !g ) { ;--error--;
         calling_objects_type := this.Gui_cType()
         cc("`n")
         cc("`tg hwnd *not* in static GUI_BASE.array_of_guis[hwnd] `n")
       }
     }
     else{ ;--error--;

     return {"x":x, "y":y}
    }
    }



.. code-block:: AutoHotkey_CustomLexer


  gosub latest

  latest:
    test
  return


	Clipboard := ClipboardOld


  ;-----------------------------------------------------
  ;       if NUMLOCK STATE ON == FALSE
  ;-----------------------------------------------------
  #If not GetKeyState("NumLock", "T")
  ;-----------------------------------------------------
  {
  >^NumpadUp::
  >^NumpadPgUp::
  ; msgbox % A_ThisHotkey

  ; get HWND handle of current window
  WinGet, HwndCurrent, ID, A

  Puppies := "are Neat"
  Kittens := "are Neat"

  ; get the Numpad___ keyname without the leading modifier characters
  numlockOff_keyname := SubStr(A_ThisHotkey, 3)
  numPress := get_numpad_int_from_numlockOff_keyname( numlockOff_keyname )


  ; store HWND in variable
  ;  remember_win_numpad_%INTEGER_NUM_PRESSED% (+ "b" if layer shifted with . numpad key)

  if( false == b_numpad_layerShift ){
  	remember_win_numpad_%numPress% := HwndCurrent
  }
  else{
  	remember_win_numpad_%numPress%_b := HwndCurrent
  }

  ;---------
  ;debug
  ;---------
  ; out := "Got keypress [" A_ThisHotkey "]"
  ; out .= "`nwhich is numpad #[" numPress "]"
  ; out .= "`n`nnow associated with Hwnd[" HwndCurrent "]"
  ; msgbox %out%

   return
  }
  #If

AutoHotkey (abbreviated: "AHK" or "ahk") is a programming language which wraps low-level procedures and functionality of the Windows Operating System into high-level, simplified commands.

Examples of what you can do with short AutoHotkey scripts:

  * | Hotstrings:
    | When you type "btw" automatically replace it  with the text "by the way"  (or any other text + trigger combination you want)
  * | Hotkeys:
    | Remap a key combination to open the Windows Calculator

* Move a window to a specific place on the screen (and optionally resize it at the same time)
* Move the mouse to a specific coordinate and click (or hold) a mouse button
* Draw lines, circles, or other images to the screen
* Create Graphical User Interfaces ("GUIs") with just a few lines of code
* Hit F2 to bring up a list of all windows, (optionally including hidden windows),

  * bring any list item you left-click to the foreground
  * close any list item you middle-click
  * minimize any list item you right-click

The syntax of AutoHotkey is simple enough that users with no programming background can remap key combinations to launch applications (or run a few cherry-picked AutoHotkey commands), yet also robust enough to develop complex applications.

Once installed, you can write AutoHotkey scripts in any text editor, save the file with the ".ahk" extension, then double-click to run your code. The AutoHotkey installer can optionally add a compiler to your Windows Explorer context menu, giving you the ability to bake ".ahk" scripts into an ".exe" executable file. These "AutoHotkey script.exe" files can either be run locally, or shared and run on Windows PCs which do not have AutoHotkey installed. _It can be useful to compile an AutoHotkey program (on a PC which already has AutoHotkey installed) when your program spans multiple files and you wish to bake them into a single executable for portability or cleanliness\._


The documentation is extensive but cleanly laid out, and can be read offline using the ".chm" file installed with AutoHotkey (the default location for 64-bit installations is: "C:\Program Files\AutoHotkey\AutoHotkey.chm").

AutoHotkey has been around since 2003, and you can find many elegant solutions for a wide variety of use cases on the online AutoHotkey forums (ranging from simple functions like moving and listing windows -> to more arcane uses, such as using AutoHotkey to interact with databases or to examine the IDs and data behind Chrome's GUI components).

.. note::
   AutoHotkey is used largely for simple scripting by hobbyists and gamers, but its built-in capabilities are versatile.

   For an example, look at the application `AHK Studio <https://www.autohotkey.com/boards/viewtopic.php?t=300>`_. It is a full-fledged IDE\ :superscript:`1` written entirely in AutoHotkey for the purpose of writing and managing AutoHotkey applications and projects. Personally, I'm still impressed by AHK Studio's user interface design and functionality.

   For those who are interested, SciTE4AutoHotkey (https://www.autohotkey.com/scite4ahk/) is another excellent IDE for AutoHotkey. SciTE4AHK features code completion\ :superscript:`2` for AHK commands, code completion for variables in the currently opened .ahk file, syntax-highlighting, a debugger with breakpoints, and variable inspection at runtime (including hierarchies of nested objects or arrays).


Want to know more about AutoHotkey?
----------------------------------------

AutoHotkey's official website:

===========  =====================================================
ahk Home:    https://www.autohotkey.com/
ahk Manual:  https://www.autohotkey.com/docs/AutoHotkey.htm
ahk Forum:   https://www.autohotkey.com/boards/
===========  =====================================================

Glossary
----------------

[\ :superscript:`1`\ ] IDE:
   Acronym for Integrated Development Environment.

   Refers to an application which facilitates programming. Typically IDEs include tools to assist in productively writing, running, and debugging code.

   See: https://wikipedia.org/wiki/Integrated_development_environment.

[\ :superscript:`2`\ ] Code Completion:
   Typically a dropdown list suggesting words or commands based on context. Present in many IDEs (and even in some text editors, see `Notepad++ <https://notepad-plus-plus.org/>`_). Expedites programming by having the software remember and suggest specific variables, functions, and syntax conventions.

   For example, if you can only remember part of a function named "Cat_Says_Meow()", you can type the beginning "Cat_Says\_", and code completion would present you with a dropdown item containing "Cat_Says_Meow()". Compared to using a simple text editor, this feature allows you to remain focused on the present task (instead of sifting and searching for a half-remembered phrase, copying or re-memorizing it, scrolling back to where you began, then reorienting to your original context).

   See: https://en.wikipedia.org/wiki/Intelligent_code_completion.


todo link maybe

*   Object-Oriented GUI Framework/index
*   Utilities/index
