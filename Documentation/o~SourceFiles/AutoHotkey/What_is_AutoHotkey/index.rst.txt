.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
                                       HTML CODE |SUBSTITUTIONS|
                                       DEFINED IN /conf.py
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

=========================
What is AutoHotkey?
=========================
  
|br|

.. image:: ahk_logo__two_rows.svg

AutoHotkey (abbreviated: "AHK" or "ahk") is a free, open-source programming
language which wraps low-level procedures and functionality of the Windows
Operating System into high-level, simplified commands. I am not affiliated with
AutoHotkey's development, but I've been using and enjoying it for over a decade.

|br|

-------------------
AutoHotkey Overview
-------------------

**Hotkeys**

The syntax of AutoHotkey is simple enough that users with no programming
background can remap key combinations (called *hotkeys*) to launch their
favorite applications. 

An AutoHotkey script containing the following 3 lines will launch Window's
Notepad.exe whenever the user presses the hotkey :kbd:`Windows`\ +\ :kbd:`F1` :

.. code-block:: AutoHotkey_CustomLexer
    
    #F1::
	   Run, notepad.exe
    return
    
Starting out, beginners can also assign hotkeys 
to trigger a few cherry-picked `AutoHotkey commands <https://www.autohotkey.com/docs/commands/index.htm>`_.

**Hotstrings**

In addition to triggering code via hotkeys, 
AutoHotkey also has a feature called *hotstrings*. With hotstring mapping,
you can define a simple shorthand phrase that you want to automatically
expand whenever you type it. For example, you can configure an AutoHotkey script
to insert the text "for what it's worth" whenever you type the *hotstring* "fwiw" and press
:kbd:`Enter` with the following line of code: 

.. code-block:: AutoHotkey_CustomLexer

    ::fwiw::for what it's worth

.. 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    Comment
    
    Might add later, no time right now.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    
        See the :ref:`hotstring example below
        <AhkIntroHotstringExample>` for more details.

**And More!**

AutoHotkey is great for short scripts to suit simple needs.

But AutoHotkey is also robust enough to develop complex applications such as:

* `word processors <https://www.autohotkey.com/boards/viewtopic.php?f=6&t=681>`_, 
* `picture galleries <https://www.autohotkey.com/boards/viewtopic.php?t=65584>`_, 
* `database viewers <https://www.autohotkey.com/boards/viewtopic.php?t=62902>`_, 
* `programming environments <https://www.autohotkey.com/boards/viewtopic.php?t=300>`_, 
* `web scrapers <https://www.autohotkey.com/boards/viewtopic.php?t=7822>`_,
* and even `procedural fractal art <https://www.autohotkey.com/boards/viewtopic.php?t=6071>`_.


Whether you're an advanced power user with a million apps you want to bind to
each function key, a graphic interface designer who wants to prototype some
basic windows quickly, or if you just want to open your music player faster,
AutoHotkey has something to offer you. 

**In a Nutshell** 

AutoHotkey is a framework that can help you expedite your common
workflows, whatever they might be.

|br|

-----------------------------------
AutoHotkey Resources
-----------------------------------

**The Official Documentation:**

And the `official documentation for AutoHotkey <https://www.autohotkey.com/docs/>`_ 
is excellent. The entire manual is extensive but cleanly laid out, and can even be
read offline using the ``.chm`` file installed with AutoHotkey. By default this
help file will be installed to this location on your hard drive: ``C:\Program
Files\AutoHotkey\AutoHotkey.chm`` (for 64-bit
installations). 

**The Community Forums:**

AutoHotkey has been around since 2003. As you explore and experiment 
with the AutoHotkey language you can typically find many elegant
solutions, example scripts, and forum discussions
for almost every problem you face. 

The community surrounding AutoHotkey is still active, and you can 
find a wide variety of scripts and tutorials `on the online AutoHotkey forums
<https://www.autohotkey.com/boards/>`_
ranging from simple recipes for moving and listing windows,
to technical help with a variety of common (and uncommon) syntax pitfalls.
There are even a few users who have posted comprehensive guides over the years 
describing how to use AutoHotkey's arrays, objects, classes in great and
exhaustive detail.

As you experiment, never be afraid to go to your favorite search engine 
and type in ``my topic, ahk``. I've been surprised by how many high-quality
AutoHotkey forum posts I've consistently found over the years by adding ``ahk``
to an otherwise generic search query.

**Links to Help You Get Started:**

AutoHotkey is a simple and powerful language. If you've never programmed before,
it can be a fun place to begin. I highly recommend starting with the official
``AutoHotkey Beginner Tutorial`` (it has a lot of simple examples you can
try as soon as you install AutoHotkey)!

*Download and learn more at the official AutoHotkey website:*

+-----------------------------+------------------------------------------------+
| | AutoHotkey Home           | https://www.autohotkey.com/                    |
| | |nbsp|  (download here):  |                                                |
+-----------------------------+------------------------------------------------+
| AutoHotkey Manual:          | https://www.autohotkey.com/docs/AutoHotkey.htm |
+-----------------------------+------------------------------------------------+
| AutoHotkey Forum:           | https://www.autohotkey.com/boards/             |
+-----------------------------+------------------------------------------------+
| | AutoHotkey Beginner       | https://www.autohotkey.com/docs/Tutorial.htm   |
| | |nbsp|  Tutorial:         |                                                |
+-----------------------------+------------------------------------------------+

*Read AutoHotkey's source code:*

+-----------------------------+------------------------------------------------+
| AutoHotkey Source Code:     | https://github.com/Lexikos/AutoHotkey_L/       |
+-----------------------------+------------------------------------------------+

*Read a bit about its history here:*

+--------------------+-----------------------------------------------------------------------------------------+
| Wikipedia:         | https://en.wikipedia.org/wiki/AutoHotkey#History                                        |
+--------------------+-----------------------------------------------------------------------------------------+
| History:           | https://www.autohotkey.com/foundation/history.html                                      |
+--------------------+-----------------------------------------------------------------------------------------+
| | The transition   | https://autohotkey.com/board/topic/58864-my-status-and-website-changes/                 |
| | to AutoHotkey_L  |                                                                                         |
+--------------------+-----------------------------------------------------------------------------------------+

.. _Ref-What_is_AutoHotkey-Resources-Text_Editors:

.. tip::
   Interested in programming with AutoHotkey? Need a development tool?
   
   If you install AutoHotkey, you can start coding right away using ``notepad.exe``
   which is available on every edition of Windows. But if you want something 
   more robust and comfortable....
   
   |details_open| **For Beginners and Enthusiasts:** |summary_close|
   
   |indented_block| 
   
   | Look no further than Notepad++!
   | https://notepad-plus-plus.org/
   |
   | If you want to set up syntax-highlighting, the recipe I used can be found here: 
   | https://www.autohotkey.com/boards/viewtopic.php?t=50 
   
   |indented_block_close|
   |details_close|   
   |br|   
   |details_open| **For Advanced Users:** |summary_close|
   
   |indented_block| 
   
   | Look no further than SciTE4AutoHotkey!
   | https://www.autohotkey.com/scite4ahk/
   
   SciTE4AHK is an excellent IDE\ [1]_ for
   AutoHotkey. It features built-in code completion\ [2]_ for AHK
   commands, code completion for variables in the currently opened .ahk file,
   syntax-highlighting, a debugger with breakpoints, and variable inspection at
   runtime (including hierarchies of nested objects or arrays).
   
   | You can read discussions about its development and history here:
   | https://www.autohotkey.com/boards/viewtopic.php?f=61&t=62
   
   |indented_block_close|
   |details_close|
   
   |br|

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    Comment 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~     
    Removed a text block here.
    
    See [plucked text 1]
    in the comments at the bottom of this .rst document.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

|br|
   
-----------------------------
First Steps
-----------------------------

One of the greatest things about AutoHotkey is you can type some code in a text
editor like Notepad.exe or Notepad++, give the text file the ``.ahk`` extension,
and it automatically becomes an executable script.

.. hint::
   If you're interested in trying out AutoHotkey, 
   the official documentation has an excellent Beginner Tutorial
   here: https://www.autohotkey.com/docs/Tutorial.htm.
   (For future reference, this tutorial is listed as ``Tutorial (quick start)`` in 
   the AutoHotkey documentation's table of contents.)

Once you've installed AutoHotkey with the official installer, you can write
AutoHotkey scripts in any text editor. 

* After typing some code, save it with the extension ``.ahk`` 
  and your executable script file will be ready. 
* Alternatively, you can save your code as a ``.txt`` file
  then rename that text file in Windows Explorer to have the ``.ahk`` extension instead
  *(for example: rename my_script.txt to my_script.ahk)*. And voila, as soon
  as your file has the ``.ahk`` extension, your script is ready to run!

Double-click this file to run your code!

.. note::
    You can exit an AutoHotkey script at any time by right-clicking green "H"
    icon in the Notification Area, then selecting "Exit". If you have more than
    one AutoHotkey script running, hover over each icon until you see a tooltip
    pop up. The tooltip will display the filename of the running script.
 

|br|

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    Comment 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~     
    Removed a text block here.
    
    See [plucked text 2]
    in the comments at the bottom of this .rst document.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

----------------------------------------------------------
Baking Your AutoHotkey Scripts
----------------------------------------------------------
   
You might be saying, "That's nice and all, but what if I want to make an
official executable with AutoHotkey to impress my friends?" (Or you might
be thinking "But what about portability, do I need to make a ``.zip`` every
time I want to distribute my code?")

The AutoHotkey installer can optionally add a compiler\ [3]_ to your Windows
Explorer context menu, giving you the ability to bake ``.ahk`` scripts into a single
``.exe`` executable file. These ``AutoHotkey script.exe`` files can either be run
locally, or shared and run on Windows PCs which do not have AutoHotkey
installed.

.. note::
    Compiling your ``.ahk`` scripts into an ``.exe`` file 
    can even be useful if your PC already has AutoHotkey installed. 
    For example, if your program spans multiple files then you
    can to bake them all into a single executable for portability or cleanliness.



|
|
|



----------------------------------------
Glossary
----------------------------------------
   
.. [1] IDE:
   Acronym for Integrated Development Environment.

   Refers to an application which facilitates programming. Typically IDEs
   include tools to assist in productively writing, running, and debugging code.

   See: https://wikipedia.org/wiki/Integrated_development_environment.

.. [2] Code Completion:
   Typically a dropdown list suggesting words or commands based on context.
   Present in many IDEs (and even in some text editors, see `Notepad++
   <https://notepad-plus-plus.org/>`_). Expedites programming by having the
   software remember and suggest specific variables, functions, and syntax
   conventions.

   For example, if you can only remember part of a function named
   "Cat_Says_Meow()", you can type the beginning "Cat_Says\_", and code
   completion would present you with a dropdown item containing
   "Cat_Says_Meow()". Compared to using a simple text editor, this feature
   allows you to remain focused on the present task (instead of sifting and
   searching for a half-remembered phrase, copying or re-memorizing it,
   scrolling back to where you began, then reorienting to your original
   context).

   See: https://en.wikipedia.org/wiki/Intelligent_code_completion.

.. [3] Compiler:
   A compiler is a program which takes souce code and translates it into another
   programming language. Typically when you hear the phrase "this code was compiled", 
   it means that a human-readable text file was turned into an execuable program
   which can now be launched by a user.
   
   See: https://en.wikipedia.org/wiki/Compiler.

.. raw:: HTML 

    <script>
    
        /*
            ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
            Comment
            
            When I decided to tidy the above section where I recommend text editors to use 
            I nested two glossary links inside a <details> tag. This became a problem.
            
            The links in the Glossary section which take the reader back up to the section
            do not work properly if the <details> tag is closed (because 
            when the <details> block is closed, the link targets are hidden from the page).
            
            The following script remedies this
            by opening the parent <details> block if the link's target is hidden.
            ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
        */    
        
        // ----------------------------------------------------
        //  Adapted from this recipe:
        //
        //      https://stackoverflow.com/a/37033774/13536555
        // ----------------------------------------------------
        
        // Called when the #uri_fragment is changed.
        // Example: www.url.etc/index.html#uri_fragment 
        
        function open_details_tag() {
        
            // Get the trailing #some_uri_fragment from the URL.            
            var hash = location.hash.substring(1);
            
            // If the url has a #fragment, 
            // get its corresponding DOM node.             
            if(hash){
                var hash_target = document.getElementById(hash);
            }
            
            // If DOM node, check to see if it's one of the nodes 
            // which is wrapped in a <details> tag (potentially folded).            
            if(hash_target){
                
                if(hash == "id1" || hash == "id2"){
                  
                  // Get the parent's parent's parent <details> tag object. 
                  // (Warning: this is hacky, but this is an isolated fix anyway.)
                  var details = hash_target.parentElement.parentElement.parentElement;
                  
                  // Open the <details> tag so we can navigate to the #samepage fragment.
                  details.open = true; 
                  
                  // Didn't have success with this.
                  // details.scrollIntoView();
                  
                  // Change the URL to the base URL.
                  // Without this step, clicking the link inside the Glossary 
                  //  to go back up into the page will not work 
                  //  if the URL already contains the hash in the URL
                  //  (eg, if you click [1] in the Glossary, 
                  //   scroll down, then click [1] in the Glossary again.)
                  window.location.replace(location);
                  
                  // Change the URL to contain the #hash fragment
                  // to trigger the webpage to scroll up to the #id.
                  window.location.replace(location.hash);
                  
                }
                else{
                    // alert("Not one of the supported ids to js jump to.");
                }
                
            }
        }
        window.addEventListener('hashchange', open_details_tag);
        open_details_tag();
        
    </script>

..
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    Comment 
    
    Original text before <details> wrapper added.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    [plucked text 1] : 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
        
       **For Beginners and Enthusiasts:**
       
       | Look no further than Notepad++!
       | https://notepad-plus-plus.org/
       |
       | If you want to set up syntax-highlighting, the recipe I used can be found here: 
       | https://www.autohotkey.com/boards/viewtopic.php?t=50
       
       
       
       **For Advanced Users:**
       
       | Look no further than SciTE4AutoHotkey!
       | https://www.autohotkey.com/scite4ahk/
       
       SciTE4AHK is an excellent IDE\ [2]_ for
       AutoHotkey. It features built-in code completion\ [3]_ for AHK
       commands, code completion for variables in the currently opened .ahk file,
       syntax-highlighting, a debugger with breakpoints, and variable inspection at
       runtime (including hierarchies of nested objects or arrays).
       
       | You can read discussions about its development and history here:
       | https://www.autohotkey.com/boards/viewtopic.php?f=61&t=62

..         
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    Comment 
    
    Might add later, not enough time right now.
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    [plucked text 2] : 
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
    
        ---------------------------------------------------------------------
        Examples of what you can do |br| with short AutoHotkey scripts:
        ---------------------------------------------------------------------

        Since there is already an amazing `Beginner Tutorial <https://www.autohotkey.com/docs/Tutorial.htm>`_
        inside the official AutoHotkey documentation, I'm not going to reinvent the wheel. 

        But to give a better idea of what AutoHotkey can do, and what the syntax looks like, 
        I've made some examples here. But if you're looking for where to start, 
        download SciTE4AHK, and read the Beginner Tutorial. 

        Once you've installed AutoHotkey, you can do the following.

        **Hotstrings:**

          .. _AhkIntroHotstringExample:
            
          * **Hotstrings:**
            
            .. code-block:: AutoHotkey_CustomLexer
            
               ::btw::by the way
               
            | Make a new text file and copy/paste or write the above line. Save the file as "btw.ahk".
            |
            | To run your new script, double-click the script in Windows Explorer to run it. 
              You will see a little green "H" appear in your Notification Area.       
            |
            | Open a text editor. Type "btw", then press one of the following "ending
              keys" to trigger the hotstring:
            
              * :kbd:`Space`
              * :kbd:`Enter`
              * :kbd:`.` 
              
            | and your "btw" text will automatically be replaced with the text "by the way"!
            | 
            | If you want to type "btw" without replacing the text, type "btw" then
             press :kbd:`Esc` before pressing any other keys to cancel the next keystroke
             from triggering your hotstring.
            |
            | The hotstring "ending keys" can be configured. 
            | By default, these are the keys which will trigger a hotstring replacement:
            
              * :kbd:`Space`, :kbd:`Enter`, :kbd:`Tab`
                , :kbd:`.` :kbd:`-`, :kbd:`(`, :kbd:`)`, :kbd:`[`, :kbd:`]`
                , :kbd:`{`, :kbd:`}`, :kbd:`'`, :kbd:`:`, :kbd:`;`, :kbd:`"`
                , :kbd:`/`, :kbd:`\\`, :kbd:`,`, :kbd:`?`, :kbd:`!`
                 
            You can optionally have hotstrings trigger as soon as they are typed by using 
            the "asterisk option" like this:
            
            .. code-block:: AutoHotkey_CustomLexer
               
               :*:by the way::by the way
                 
            | You can read more about hotstrings here:
            | https://www.autohotkey.com/docs/Hotstrings.htm
            
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
          

        |br|

        |br|
