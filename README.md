---
permalink: README.html
title: "PAGE TITLE"
---
## Welcome to the GitHub Pages Repository for my website!

I am currently using Jekyll, Sphinx, (and a lot of
pre-processing and post-processing python scripts I wrote) to build my website: 
[gamepad-coder.github.io](gamepad-coder.github.io).

How it works:
1. For development, I build my website offline on my PC using Jekyll.
2. When my changes are ready, I upload my files to GitHub. 
3. Then GitHub independently bakes my source files using 
   their own installation of [Jekyll](https://jekyllrb.com/), 
   and publishes the finished product online.
   This service is called GitHub Pages, and you can 
   [read more about it here](https://pages.github.com/)!
   
It's awesome, free, and I'm very grateful for the service.

### [~] To Do:

I plan to add a detailed walkthrough of all the tools and steps to the 
Documentation section of my website sometime this year.

For now, I'll write a very brief overview here.

### Folder Structure

The top level of this repository is the source directory for all the files Jekyll bakes when I type the command 
`jekyll build`. Jekyll takes any page containing [front matter](https://jekyllrb.com/docs/front-matter/) and processes it. 

*The main use of front matter is to tell Jekyll, "Hey, this page isn't complete. This is just the content in the middle
of the page. I want you to use the layout I asked for in the front matter, and put all the bells and whistles inside the
finished HTML page."*

All the following are the unbaked source files, before Jekyll processes them:
- The top directory containing 
    - `/index.html`
    - `/contact.html`
    - `/Apps.html`
    - `/Philosophy.html`
- The `/_Philosophy/` directory *(Jekyll wants the underscore prefix for a reason)*
- The `/Documentation/` directory *(more about this in the next section)*

The website files you actually see when you visit [gamepad-coder.github.io](gamepad-coder.github.io) are all located in
the output directory named ``/_site/``.


### The Documentation Sub-Website

In addition to Jekyll, I am using Sphinx to create the base files in the Documentation section of the website. However,
I take Sphinx's default output files, and then modify them with additional tweaks, URL corrections, and added
functionality.

The finished product is here: [https://gamepad-coder.github.io/Documentation.html](https://gamepad-coder.github.io/Documentation.html)


### The Documentation Directory

The files in `/Documentation/` are the files Jekyll uses to bake the Documentation section of my website, but these are
not actually the source files.

`/Documentation/_Sphinx/` is the directory for all my Documentation source files. 

This is also the root directory for my [Sphinx](https://www.sphinx-doc.org/en/master/) project file for my Documentation: `/Documentation/_Sphinx/conf.py`.

*(Jekyll doesn't actually know this directory exists, and never touches it.*
*In my Jekyll configuration file `/_config.yml` there is a line which says: `exclude: [Documentation/_Sphinx]`.)*

### Building my Documentation, Basics 

I made a custom modification of the [ReadTheDocs](https://sphinx-rtd-theme.readthedocs.io/en/stable/) theme for Sphinx, 
located under `/Documentation/_Sphinx/stphinx_rtd_theme__modified/`. I use this to insert a miniature version of 
my `<header>` navigation bar from my website's Home page into the Documentation pages.

`/Documentation/_Sphinx/Documentation.rst` is the index file for the top of the Documentation section. 
Sphinx thinks of this as its own project's root file.

This `Documentation.rst` contains the Table of Contents directive which 
references all other pages in the Documentation. This Table of Contents declared
in `Documentation.rst` is what Sphinx uses to generate the sidebar you see on the lefthand side of my Documentation section. 

*If (a) your window is very narrow or (b) you're on a mobile device, then this sidebar will show up if you click the menu button in the upper-left hand corner of the page.*

When I run the command `sphinx make html`, Sphinx takes my custom theme and builds
`Documentation.rst` and all the files it references (located in the subdirectories 
`/Documentation/_Sphinx/AutoHotkey/` and `/Documentation/_Sphinx/Godot/`) and produces 
a baked set of files in a folder called `/Documentation/_Sphinx/_build/`.

For cleanliness of commits, I have omitted `/Documentation/_Sphinx/_build` from this 
GitHub repository. But if you install Sphinx, download this repo, navigate to 
`/Documentation/_Sphinx/` and run `sphinx make html`, then `/Documentation/_Sphinx/_build/`
and all of its files will be generated. 


### Building my Documentation, Complete Steps

In order to make Sphinx's output mesh well with the rest of my website, 
I manually modify URLS to be compatible with Jekyll, and to make the 
Sphinx files relative to their greater context as a sub-directory 
of the rest of the Jekyll build files.

Additionally I manually insert code-block folding in the highlighted 
code sections of my Documentation.

This is where my pre-processing and post-processing scripts come into play.

When I build my Documentation under `/Documentation/_Sphinx/`, 
I run the following commands in Debian's Bash shell:

1. `sphinx_1` - custom alias    
    - changes to the Sphinx project directory
    - runs `( A ) run all python pre-processing scripts.py`<br><br>
2. `sphinx_2` - custom alias
    - changes to the Sphinx project directory
    - runs Sphinx's `make clean html`<br><br>
3. `sphinx_3` - custom alias
    - changes to the Sphinx project directory
    - runs `( B ) run all python post-processing scripts.py`

I sometimes will build run these alias commands in isolation to debug different things.
But typically I run the final alias `sphinx` which runs the above three aliases.

Once these have all run, I check the local build files in `/Documentation/_Sphinx/_build/`.

If everything looks good, I run my final post-processing script 
`( C ) [AHK FINALIZE SCRIPT ]  Post-process Sphinx output and place modified trunk in Jekyll's prebake Docs dir.ahk`. This moves the baked files from `/Documentation/_Sphinx/_build/` *(which Jekyll doesn't know about)* to `/Documentation/` *(which Jekyll does know about and will use to build the website when I run the command `jekyll build`)*.

### Briefly, what all my processing scripts in `/Documentation/_Sphinx/` do.


**Script-Calling Scripts:**

`( A ) run all python pre-processing scripts.py`
- Runs `Pre-Process   1 -- Copy AHK scripts to Sphinx source.py`
- Runs `Pre-Process   2 -- Insert custom tags into AHK scripts (post-process will replace with html codeblock folding).py`

`( B ) run all python post-processing scripts.py`
- Runs `Post-Process 1 -- Remove Section Headers in Documentation.html TOC.py`
- Runs `Post-Process 2 -- Add Codeblock Folding To Sphinx output, replace custom tags with HTML details element.py`
- Runs `Post-Process 3 -- Add Links to Section Captions in Sidebar TOC.py`
- Runs `Post-Process 4 -- Copy Videos to Output Build Directory.py`


**Pre-Processing Scripts:**

`Pre-Process   1 -- Copy AHK scripts to Sphinx source.py` : 
- This script takes all my local AutoHotkey scripts located in my AutoHotkey_Projects repo, 
  and copies them into their relative Documentation directories under `/Documentation/_Sphinx/AutoHotkey/(project_path)/script.ahk`.
- From there these scripts are referenced by docs pages using lines like 
  `.. literalinclude:: program_launcher.ahk`. This directive inserts a code file 
  with added syntax highlighting into the page.

`Pre-Process   2 -- Insert custom tags into AHK scripts (post-process will replace with html codeblock folding).py`
- Sphinx is awesome at inserting and colorizing blocks of code. Yet there is no support 
  for code-block folding. To remedy this, in the pre-processing phase, 
  I scan all my `.ahk` script files which were copied by `Pre-Process   1`
  and insert arbitrary tags anywhere there is an open or close curly brace {}.
- When I run Sphinx's `make clean html` command, these arbitrary tags will be awkwardly present in 
  the files inside `/Documentation/_Sphinx/_build/...`. That's what `Post-Process 1` utilizes.


**Post-Processing Scripts:**

`Post-Process 1 -- Remove Section Headers in Documentation.html TOC.py`
- For my top level Documentation index, I didn't want a lot of 
  duplicate links which reference different portions of the same page. 
  This short script ensures that the Documentation home doesn't 
  have a lot of extraneous noise.
  
`Post-Process 2 -- Add Codeblock Folding To Sphinx output, replace custom tags with HTML details element.py`
- I add code-block folding to highlighted code sections by utilizing the &lt;details&gt; HTML element.
  This element automatically adds text collapse/expand functionality to all of its children tags.
- `Post-Process 2` looks for the arbitrary strings of text inserted by `Pre-Process   2`, and 
   replaces them with the &lt;details&gt; and &lt;summary&gt; elements. When this is done, 
   with the help of some CSS styling located at the bottom of 
   `/Documentation/_Sphinx/sphinx_rtd_theme__modified/static/css/theme.css`, the code-blocks
   are properly aligned and can be expanded and contracted a.k.a folded.

`Post-Process 3 -- Add Links to Section Captions in Sidebar TOC.py`
- I wanted to have big section headers in the Sidebar TOC which you could also click.
  This is not possible using the normal RTD (ReadTheDocs) Sphinx theme. 
  However, thanks to this script, you can now click the blue Section Headers 
  on my Documentation's sidebar to see an index of their contents.
- This is a bit of a hack, but if I had added new sections to the Sphinx TOC, 
  then everything in the sidebar would be nudged down an additional tree level, 
  and I really disliked that amount of noise. 
  Although hacky, this end-result is a lot cleaner.

`Post-Process 4 -- Copy Videos to Output Build Directory.py`
- Probably the simplest script here. I wanted to check the layout and CSS on my 
  video files in my `/Documentation/_Sphinx/_build/` output without needing to 
  build the full site with Jekyll. Sphinx builds MUCH faster than Jekyll, even 
  for full rebuilds with all of my scripts.

**Final Post-Processing Script**

This script moves files across the boundary between Sphinx and Jekyll. 

*(And it processes them a bit to make everything work together in Jekyll's build process)*

This was the first script I wrote here, and eventually I'll port it to Python.

`( C ) [AHK FINALIZE SCRIPT ]  Post-process Sphinx output and place modified trunk in Jekyll's prebake Docs dir.ahk`
- I run this after all the above scripts and Sphinx have finished. This script copies
  my Sphinx output code located at `/Documentation/_Sphinx/_build/` and copies the files 
  to `/Documentation/`. 
- The script then patches URLS to fit within Jekyll's folder structure.
- This script also copies any pictures inside `/Documentation/_Sphinx/_build/Project/Etc/Img.jpg`
  and copies them to `/Documentation/Project/Etc/Img.jpg`. I like pictures to be relative 
  to the files which use them. Sphinx doesn't do this, and by default makes a one 
  directory tree for text and another directory tree for images under `../_build/assets/`.
  This isn't necessary, but I prefer it this way for my personal projects.


### Conclusion for Now

I had a ton of fun with all this, and learned so much in a short period of time.

There are a few details I've omitted here, but this should give you a good enough idea of what this repo is, how it's structured, how it's built in general, and how all the different areas mesh together. 

Have a great day, and enjoy!