;-----------------------------------------------------------------------------------------------------------------------
; v2                                                                                      [2021_04_27]  @  [02-45-58 PM]
;-----------------------------------------------------------------------------------------------------------------------
; file : 
;   "[AHK FINALIZE SCRIPT ]  Post-process Sphinx output and place modified trunk in Jekyll's prebake Docs dir.ahk"
;-----------------------------------------------------------------------------------------------------------------------
; Summary : 
;   Sphinx without mods places assets under "(Sphinx project directory)/_build/html/_sources/" and "... /_static/".
;   Jekyll sees directories with a leading "_" underscore in the filename 
;    as being specific to engine organization or functionality.
;   This script polishes those _underscore-prefixed links, 
;    and takes care of a few other rewiring nuances 
;    to make the Sphinx baked output mesh nicely into Jekyll's input needs.
;-----------------------------------------------------------------------------------------------------------------------
; Author: Gamepad.Coder                              License: Community Commons Zero (cc0) 
;-----------------------------------------------------------------------------------------------------------------------

/*
		Make Sphinx output compatibile with Jekyll's input needs.
		
		Steps.

		1
			Back up (by moving to a folder named "__backup__")  :
			  all existing files under (Jekyll)/Documentation/* 
			  (excluding ./_Sphinx/*)
		
		2
			Copy (Sphinx)/_build/html/* -> (Jekyll)/Documentation/*
		
		3
			Process Docs home page : 
			
			3a
				rename file (Jekyll)/Documentation/index.html -> Documentation.html
			3b
				add this to top of "(Jekyll project)/Documentation/Documentation.html" : 
			
				---
				title: "Documentation"

				meta_description: Documentation for projects.
				meta_keywords: "projects documentation, docs"

				permalink: Documentation.html
				---
		
		4
			Rename folder /Documentation/_static -> /o~DocAssets 
			Rename folder /Documentation/_sources -> /o~SourceFiles
			
			note: I wanted to use a leading prefix to help me see at a glance
			      which subfolders were for website internals, and which 
			      folders pertain to my .rst files for the manuals,
				  hence the arbitrary 'o~' preceeding these directory names.
			
		5
			Fix URLS (and RTD Theme bugs)
		
			5.1
				Replace in files :
					href="index.html"
					with -> 
					href="/Documentation.html"
			
			5.2	
				Replace RTD Sphinx Theme's bug: 
					|somekey| : '/static/_static/
					-> with   
					|somekey| : '/Documentation/o~DocAssets/
				Replace in files -> _static to /Documentation/o~DocAssets
				Replace in files -> _sources to /Documentation/o~SourceFiles
			
			5.3
				Replace in files : 
					action="search.html" 
					-> 
					action="/Documentation/search.html"
		
			5.4
				Regex replace in files.
				Find:
					href="(?!(http|\/|#))(.*)\.html"
				Replace with:
					href="/Documentation/\2\.html"
			
			5.need to complete this list after changes in v.5
			
				after v6: 
					now links such as : 
						"../../_images/someimage.ext" 
					are replaced with simply : 
						"someimg.ext"
					since images will now be relative to the files which display them
					in the directory structure 
					(and now there is not a separate /static/images/ folder).
					
	-- new in v2 --
	
		6
			Keep pictures in the dirs relative to the files which use them.
			
			Why?
				I've always disliked how Sphinx puts baked images in the same dir 
				separate from the documentation files which use them. 
				
				In my experience, at least 90% of images used in Sphinx docs 
				are used once in a specific place. 
				
				So when you're going through someone else's documentation, 
				and you see a link to a picture, it doesn't appear anywhere else 
				in the documentation, however you have to sift and navigate 
				through a separate folder structure to find the image referenced. 
				
				This also makes the entire baked documentation less portable. 
				
				If you only want to look at one branch of the documentation and 
				copy a part of it (perhaps to a smaller isolated set of HTML pages),
				you cannot easily just copy and paste out the trunk you're interested in; 
				(main use case: not having internet access but wanting to look at 
				docs (in my experience, also on a mobile device)).
				
				So while I was already doing post-processing, I wanted to be able 
				to add pictures to the directories which uniquely use them.
				
				Partially because in my case there isn't a good justification to 
				factor them out into their own directory. 
				
				Partially because I think it's cleaner.
				
				And partially because it makes it easier to review when going through 
				my source directory trunks when proof-reading. 
				
				Also this enables me to just place a picture in the same folder 
				as the doc which will display it, and then I don't need to list 
				an aboslute path, I can simply specify the file name, and it'll display 
				properly, even once it is baked with Jekyll.
			
			What 
			
				6.1
					For each picture in each dir in the 
						(Jekyll)/Documentation/_Sphinx/ ** source dirs ** / *
					move it to its corresponding output in 
						(Jekyll)/Documentation/ ** (baked output moved from _Sphinx/build/html/) ** dirs
					
					6.2
						There should be an instance of this file in 
							(Jekyll)/Documentation/o~DocAssets/images/
						Move it to 
							(Jekyll)/Documentation/ (** baked sub dir matching where it initially was placed 
														inside of (Jekyll)/Documentation/_Sphinx/ .. sub dir .. /) **
						
						In this current setup, 
						the Godot log file exists at 
							(Jekyll)/Documentation/_Sphinx/Godot/Godot_logo.svg 
						but not in 
							(Jekyll)/Documentation/_Sphinx/_build/html/Godot/ (logo.svg *not* here)
						and is instead baked by sphinx to live in 
							(Jekyll)/Documentation/_Sphinx/_build/html/_static/images
							and also 
							(Jekyll)/Documentation/_Sphinx/_build/html/_images/
						
						These two last locations will not be mirrored in the live site, 
						due to this post-process script :) 
						
						Instead the files will live where they're put, 
						for example, after this script is run the Godot logo lives at : 
							(Jekyll)/Documentation/Godot/Godot_logo.svg 
						
						:) 
							

*/

;***************************;
; < > begin autorun section ;
;***************************;

#SingleInstance Force
SetBatchLines, -1
#NoEnv


THIS_SCRIPT_FULLPATH := A_ScriptFullPath

PROCESS_IS_FINISHED := false

DIR_JEKYLL := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation"
DIR_SPHINX := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_build\html"
DIR_SphinxBackup := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\__backup__"

3_JekyllHeader_ForIndex =
(
---
title: "Documentation"

meta_description: Documentation for projects.
meta_keywords: "projects documentation, docs"

permalink: Documentation.html
---
)


gosub ProcessSphinxOutput

ExitApp


;*************************;
; </> end autorun section ;
;*************************;


ProcessSphinxOutput:
{
	
	gosub 1_BackupFiles
	gosub 2_CopySphinxFilesToJekyllDocsDir
	gosub 3_RenameDocumentationIndex_NoUnderscore_addJekyllHeader
	gosub 4_RenameDocAssetFolders_NoUnderscore
	gosub 5_ReplaceInFiles_IndexHTML_AssetDirs_FixRelativeURLS
	gosub 6_MoveImagesBackToLocalDirs
	
	PROCESS_IS_FINISHED := true
	
	if( ListOfFilesEdited != "" ){
		ListOfFilesEdited := "These files were edited by RegExReplace: `n`n" . ListOfFilesEdited
		
		ToolTip, %ListOfFilesEdited%
		sleep, 7000
		ToolTip
	}
	
return
}

~Escape::
	if( PROCESS_IS_FINISHED ){
		ToolTip
		EXITAPP
	}
return



1_BackupFiles:
{
	
	;--------------------------------------------------------------
	; make sure tmp folder doesn't already exist
	; 	abort with popup if exists, and I'll fix it and run again
	; 	(most efficient use of my time right now, just needs to work)
	; create tmp folder
	; move everything but _Sphinx and tmp folder into tmp folder
	;--------------------------------------------------------------
	
	; see: 
	;  https://www.autohotkey.com/docs/commands/FileMoveDir.htm
	flag_overwrite := 1
	
	;........................................;
	; create backup folder if absent
	;........................................;
	if( !FolderExists(DIR_SphinxBackup) ) {

		FileCreateDir, %DIR_SphinxBackup%
	
	}

	
;~ tmp := ""
	Loop, Files, %DIR_JEKYLL%\*.*, DF
	{
;~ tmp .= A_LoopFileLongPath
		
		is_folder := FolderExists(A_LoopFileLongPath)
		if( is_folder )
		{
			dir_name := A_LoopFileName 
			
			;-----------------------------------
			; Ignore _Sphinx and ignore __backup__
			;-----------------------------------
			if( dir_name == "_Sphinx"
			or  dir_name == "__backup__" )
			{
				continue
			}
			
			FileMoveDir, %A_LoopFileLongPath%, %DIR_SphinxBackup%\%dir_name%, %flag_overwrite%			
		}
		else
		{
			FileMove, %A_LoopFileLongPath%, %DIR_SphinxBackup%\, %flag_overwrite%
		}
	}
;~ MsgBox % tmp
	
return
}

2_CopySphinxFilesToJekyllDocsDir:
{
	;................;
	; Error, ExitApp
	;  Sphinx html _build missing
	;...............................;
	if( !FolderExists(DIR_SPHINX) ) {
		error_msg := "[X.2] Sphinx's html _build dir missing from @:`n"
		error_msg .= DIR_SPHINX "`n`n  [~] Run Sphinx's 'make html' then re-run me.`n`nExiting."
		MsgBox %error_msg%
		ExitApp
	}

	
	IGNORE_DUPLICATE_IMAGES_FOLDER := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_build\html\_images"
	
;~ tmp := ""
	Loop, Files, %DIR_SPHINX%\*.*, DF
	{
;~ tmp .= A_LoopFileLongPath "`n"
		
		;===========================================================================
		; Sphinx duplicates the images under 
		;   (Sphinx)/_static/images/
		; to
		;   (Sphinx)/_images/
		; 
		; I'm renaming the directory and replacing the altered dir path 
		; lower down in this script. 
		; 
		; The custom re-linking to the renamed 
		; (Sphinx)/_static/images/ folder are replaced with references to the
		; (Sphinx)/o~DocAssets/images/ folder 
		; below in the Process_File_URLS() function.
		;
		; Either way, there is no need for the duplicate (Sphinx)/_images/ folder.
		;
		;
		if( A_LoopFileLongPath == IGNORE_DUPLICATE_IMAGES_FOLDER )
		{
			;~ MsgBox skipping _images
			continue
		}
		;
		;============
		
		is_folder := FolderExists(A_LoopFileLongPath)
		if( is_folder )
		{
			
			dir_name := A_LoopFileName 
			FileCopyDir, %A_LoopFileLongPath%, %DIR_JEKYLL%\%dir_name%			
		}
		else
		{
			FileCopy, %A_LoopFileLongPath%, %DIR_JEKYLL%\
		}
	}
;~ MsgBox % tmp
	
return	
}

3_RenameDocumentationIndex_NoUnderscore_addJekyllHeader:
{
	/*
		This step (originally) did two things.
		(3a) Rename (Jekyll dir)\Documentation\index.html to 
		            (Jekyll dir)\Documentation\Documentation.html
		(3b) Add a Jekyll header to the top of Documentation.html 
		     to trigger Jekyll to process it.
		
		While learning how to use Sphinx, I didn't realize 
		I could do step (3a) using Sphinx's conf.py file
		and was doing this step through this post-processing AutoHotkey script.
		
		Now using this in my Sphinx conf.py : 
		
		# The master toctree document.
		# master_doc = 'index' 
		# -> instead of the above line, now using the following line
		master_doc = 'Documentation'
		
		However this AutoHotkey post-process script still does the original step (3b).
	*/
	
	
	;----------------;
	; (3a), obsolete ;
	;----------------;
	
	;~ doc_index_fullpath := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\index.html"
	;~ doc_index_rename   := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\Documentation.html"
	;................;
	; Error, ExitApp
	;  index.html missing
	;...............................;
	;~ if( !FileExist(doc_index_fullpath) ){
		;~ error_msg := "[X.3] Index.html missing, should be @:`n"
		;~ error_msg .= doc_index_fullpath "`n`n  [~] Run Sphinx's 'make html' "
		;~ error_msg .= "then re-run me...(?)`n`nExiting."
		;~ MsgBox %error_msg%
		;~ ExitApp
	;~ }
	;~ FileMove, %doc_index_fullpath%, %doc_index_rename%
	
	;------;
	; (3b) ;
	;------;
	doc_index_renamed   := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\Documentation.html"
	FilePrepend( doc_index_renamed, 3_JekyllHeader_ForIndex )
	
return
}

4_RenameDocAssetFolders_NoUnderscore:
{
	;~ Sleep 1000 ;~ No longer needed after changing the FileMoveDir flag.
	
	sources_fullpath := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_sources"
	sources_rename   := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\o~SourceFiles"
	
	static_fullpath := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_static"
	static_rename   := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\o~DocAssets"
	
	;~ flag_rename := "R"
	flag_overwrite := "1"
	FileMoveDir, %sources_fullpath%, %sources_rename%, %flag_overwrite%
	FileMoveDir, %static_fullpath%, %static_rename%, %flag_overwrite%
	
return
}

5_ReplaceInFiles_IndexHTML_AssetDirs_FixRelativeURLS:
{
	IGNORE_DIR_SPHINX := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx"
	IGNORE_DIR_BACKUP := DIR_SphinxBackup

	ListOfFilesEdited := "" 
	
	;===================================================================================
	; Process each html & js & css file in our recently duplicated Sphinx build output.
	; Goes through the files which Jekyll will bake into the Documentation sub-site.
	; Ignores the Sphinx working directory.
	; Ignores the safety backup directory. 
	;
	Loop, Files, %DIR_JEKYLL%\*.*, FR
	{
		IfInString, A_LoopFileDir, %IGNORE_DIR_SPHINX%
		{
			continue
		}
		IfInString, A_LoopFileDir, %IGNORE_DIR_BACKUP%
		{
			continue
		}
		
		; Don't process files with these extensions.
		if A_LoopFileExt not in eot,svg,tff,woff,woff2,png,gif,jpg,jpeg,inv,po,mo,buildinfo,inv,backup,txt
		{
			;~ find := "href=""index.html"
			;~ replace := "href=""/Documentation.html"
			;~ ReplaceAllInstancesInFile(A_LoopFileLongPath, find, replace)
			
			; was going to do one label per operation, 
			; but it'll be much faster if I don't re-loop over every file 4x
			was_altered := Process_File_URLS( A_LoopFileLongPath )
			if(was_altered){
				ListOfFilesEdited .= A_LoopFileLongPath "`n"
			}
		}
		
	}

return
}


6_MoveImagesBackToLocalDirs:
{
	; see detailed comments/explanation at top of script.
	
	/*
	
		6.1
			For each picture in each dir in the 
				(Jekyll)/Documentation/_Sphinx/ ** source dirs ** / *
			move it to its corresponding output in 
				(Jekyll)/Documentation/ ** (baked output moved from _Sphinx/build/html/) ** dirs
			
			6.2
				There should be an instance of this file in 
					(Jekyll)/Documentation/o~DocAssets/images/
				Move it to 
					(Jekyll)/Documentation/ (** baked sub dir matching where it initially was placed 
												inside of (Jekyll)/Documentation/_Sphinx/ .. sub dir .. /) **
				
	*/
	dir_SPHINX_SOURCE   := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx"
	ImageSearch_Ignore1 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_build"
	ImageSearch_Ignore2 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_custom_extensions"
	ImageSearch_Ignore3 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_static"
	ImageSearch_Ignore4 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\_templates"
	ImageSearch_Ignore5 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\sphinx_rtd_theme__modified"
	ImageSearch_Ignore5 := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\_Sphinx\sphinx_rtd_theme__modified"
	
	comma := ","
	IgnoreDirs := ImageSearch_Ignore1
				. comma 
				. ImageSearch_Ignore2
				. comma 
				. ImageSearch_Ignore3
				. comma 
				. ImageSearch_Ignore4
				. comma 
				. ImageSearch_Ignore5
	
; str_debug := "" 
	Loop, Files, %dir_SPHINX_SOURCE%\*.*, FR
	{
		
		;--------------------------------------------------------------
		; AHK docs : If var [not] in/contains value1,value2,... 
		; URL      : https://www.autohotkey.com/docs/commands/IfIn.htm 
		;--------------------------------------------------------------
		; For the "contains" operator, a match occurs more easily: 
		; whenever Var contains one of the list items as a substring.
		;
		if A_LoopFileDir contains %IgnoreDirs%
		{
; str_debug .= A_LoopFileLongPath . "`n"
			continue
		}
		
		if A_LoopFileExt in svg,png,jpg,jpeg,bmp,gif
		{
			
			; Process_File_URLS( A_LoopFileLongPath )

			DocAssets_Image_Loc := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\"
								 . "o~DocAssets\images\"
								 . A_LoopFileName
; msgbox looking for %DocAssets_Image_Loc%

			move_image_to := RegExReplace( A_LoopFileLongPath, "_Sphinx\\" )
			if( FileExist(DocAssets_Image_Loc) ){
			
				
				FileMove, %DocAssets_Image_Loc%, %move_image_to%
			
; msgbox moving `n(%DocAssets_Image_Loc%) `nto `n(%move_image_to%)
; str_debug .= A_LoopFileLongPath . "`n"
			}
			else{
				FileCopy, %A_LoopFileLongPath%, %move_image_to%
			}
			
		}
		
	}
; msgbox % str_debug
	
	
return 
}



; ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~ ;
;                                                                                                 ~ ;
;                                         Helper Functions                                        ~ ;
;                                                                                                 ~ ;
; ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~ ;



FolderExists( dir_fullpath ){

	if InStr(FileExist( dir_fullpath ), "D")
	{
		return true
	}
	return false
	
}



;---------------------------------------------------------
; originally from, modified
; https://www.autohotkey.com/boards/viewtopic.php?t=28230
;---------------------------------------------------------
FilePrepend(filename, text_to_prepend) {
	FileRead fileContent, % filename
	FileDelete % filename
	FileAppend % text_to_prepend . "`n" . fileContent, % filename
}



Process_File_URLS( fullpath ) {
	
	return_was_file_altered := false 
	
	AllFilesWillHaveThisRoot := "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\"
	
	;........................
	; Error, ExitApp
	;  outofbounds
	;  safety precaution.
	;........................
	IfNotInString, fullpath, %AllFilesWillHaveThisRoot%
	{
		MsgBox [X!] outofbounds [X!]`n`nExiting for safety.`n`n
		ExitApp
	}
	
	
	
	;==========================================================;
	;  TheText now contains each line of the file in a string  ;
	;==========================================================;
	FileRead, TheText, %fullpath%
	
	TheTextWasOriginally := TheText
		; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		; ``````````````````````````````````````````````````````````````````````````
		; Note about the below comments.	
		; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		; ``````````````````````````````````````````````````````````````````````````
		; No '{' nor '}' are present in the strings (to find nor to replace).
		;
		; Since a lot of the needles and haystacks contain single and double quotes, 
		;  I'm using curley braces to {circle} or signify the phrases 
		;  to find and replace in these comments.	
		; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		; ``````````````````````````````````````````````````````````````````````````
	
	
	
	;===============================================================;
	; (1)			index.html -> Documentation.html
	;
	;   Fix Sphinx's default name and homepage linking for index.
	;
	;   Replace 'href="index.html' with 'href="/Documentation.html'
	;===============================================================;
	;~ find := "href=""index.html"
	;~ replace := "href=""/Documentation.html"
	;~ TheText := StrReplace(TheText, find, replace)
	
	;~ find    := "U)<a href=""(.*)"" id=""navbar_3"">"
	;~ replace := "<a href=""/Documentation.html"" id=""navbar_3"">"
	;~ TheText := RegExReplace(TheText, find, replace)
	
	find    := "U)=""(\.\./)*Documentation\.html"
	replace := "=""/Documentation.html"
	TheText := RegExReplace(TheText, find, replace)
	
	;===============================================================;
	; (2.1)			_static  -> DocAssets
	; (2.2)			_sources -> SourceFiles
	;
	; This block of commented lines contain verbatim 
	; the text which will be {found} and {replaced}
	; within curly braces. 
	;
	; No curly braces exist in needles nor haystacks.
	; Used purely for readability.
	; 
	;   Replace buggy theme's {: '/static/_static/}
	;                    with {: '/Documentation/DocAssets/}
	;   Replace {href="_static/} with {href="/Documentation/DocAssets/}
	;   Replace {src="_static/}  with {src="/Documentation/DocAssets/}
	;   Replace {href="_sources/} with {href="/Documentation/SourceFiles/}
	;   Replace {DOCUMENTATION_OPTIONS.URL_ROOT + '_sources/'} 
	;      with {DOCUMENTATION_OPTIONS.URL_ROOT + 'SourceFiles/'}
	;===============================================================;
	
	find    := ": '/static/_static/"
	replace := ": '/Documentation/o~DocAssets/"
	TheText := StrReplace(TheText, find, replace)
	
	find    := "href=""_static/"
	replace := "href=""/Documentation/o~DocAssets/"
	TheText := StrReplace(TheText, find, replace)
	
	find    := "src=""_static/"
	replace := "src=""/Documentation/o~DocAssets/"
	TheText := StrReplace(TheText, find, replace)
	
	find    := "href=""_sources/"
	replace := "href=""/Documentation/o~SourceFiles/"
	TheText := StrReplace(TheText, find, replace)
	
	find    := "DOCUMENTATION_OPTIONS.URL_ROOT + '_sources/'"
	replace := "DOCUMENTATION_OPTIONS.URL_ROOT + 'o~SourceFiles/'"
	TheText := StrReplace(TheText, find, replace)
	
	find    := "U)(\.\./)+_sources/"
	replace := "/Documentation/o~SourceFiles/"
	TheText := RegExReplace(TheText, find, replace)
	
	find    := "U)(\.\./)+_static/"
	replace := "/Documentation/o~DocAssets/"
	TheText := RegExReplace(TheText, find, replace)
	
	
	find    := "U)/?(\.\./)+_images/"
	; replace := "/Documentation/o~DocAssets/images/"
	replace := ""
	TheText := RegExReplace(TheText, find, replace)
	
	
	;==========================================================================;
	; (3)			href="search.html"  ->  href="/Documentation/search.html"
	;==========================================================================;
	
	find    := "action=""search.html"
	replace := "action=""/Documentation/search.html"
	TheText := StrReplace(TheText, find, replace)
			
	
	;==========================================================;
	; (4)
	;			Regex replace in files.
	;			Find:
	;				href="(?!(http|\/|#))(.*)\.html"
	;			Replace with:
	;				href="/Documentation/\2\.html"
	;==========================================================;
	
	if( fullpath == "C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\Documentation.html"){
	
	find    := "U)href=""(?!(http|\/|#|\.\./))(.*)\.html(#?.*)"""
	replace := "href=""/Documentation/$2.html$3"""
	TheText := RegExReplace(TheText, find, replace)
	
	}
	
	
	
	;==========================================================================;
	; (5)			Italicize "What is AutoHotkey?" + "What is Godot?"
	;               entries in the Table of Contents trees
	;==========================================================================;
	
	;~ find    := """>What is AutoHotkey?</a>(</li>|<ul>)"
	;~ replace := """ style=""font-style:italic;"">What is AutoHotkey\?</a>$1"
	;~ TheText := StrReplace(TheText, find, replace)
	;~ 
	;~ find    := """>What is Godot?</a>(</li>|<ul>)"
	;~ replace := """ style=""font-style:italic;"">What is Godot\?</a>$1"
	;~ TheText := StrReplace(TheText, find, replace)
	
	find    := """>What is (AutoHotkey|Godot)\?</a>(</li>|<ul>)"
	replace := """ style=""font-style:italic;"">What is $1?</a>$2"
	TheText := RegExReplace(TheText, find, replace)
	
	
	;==========================================================================;
	; (6)			Add an additional CSS class for TOC page entries
	;               which are links within the same page and not links 
	;               to a different page, to allow for better custom color cues.
	;
	;   regex101.com used: 
	;
	;		Find : 
	;				<a class="([^<>\n\r"]*)" (href="[^<>\n\r"#]*#[^<>\n\r"]*")>
	;		Replace : 
	;				<a class="$1 samePageSectionHeader" $2>
	;
	;==========================================================================;
	
	ch_quote := """"
	
	; find    := "<a class=""([^<>`n`r""]*)"" (href=""[^<>`n`r""#]*#[^<>`n`r""]+"")>"
	; replace := "<a class=""$1 samePageSectionHeader"" $2>"
	; TheText := RegExReplace(TheText, find, replace)
	
	find    := "<li class=""([^<>`n`r""]*)""><a class=""([^<>`n`r""]*)"" (href=""[^<>`n`r""#]*#[^<>`n`r""]+"")>"
	replace := "<li class=""$1 samePageSectionHeaderLI""><a class=""$2 samePageSectionHeader"" $3>"
	TheText := RegExReplace(TheText, find, replace)
	
	
	
	
	
	
	
	
	
	
	; If file unchanged, don't rewrite.
	; Unsure if this compairson is faster than the write operation, 
	; so this might potentially be slower.
	;
	if( TheTextWasOriginally != TheText ){
; debug := "file was changed:`n" fullpath
; Msgbox % debug
		FileDelete, %fullpath%
		FileAppend, %TheText%, %fullpath%
		
		return_was_file_altered := true
	}
	
	
	return return_was_file_altered
}













;-------------------------------------------------------------
; [x] This Powershell call won't work without security hack.
;     Unnecessary, ahk is plenty fast for this.
;     Keeping in case I ever need notes on this for Powershell.
;
;---------------------------------------------------------
; originally from, modified
; https://www.autohotkey.com/boards/viewtopic.php?t=38598
;---------------------------------------------------------
FindReplaceInFile(filePath, what, with, wait := true)  {
	
	
				; /////////////////////////////////////////////////////////////////////////
				;
				; PowerShell won't accept commands from ahk with ExecutionPolicy security, 
				;  I'm okay with this, doing pure ahk instead.
				; Cmd above worked though, that was fun to learn about. 
				;
				; /////////////////////////////////////////////////////////////////////////
				;
				;~ FindReplaceInFile( fullpath, str_to_find, str_to_replace_with )
				;
				; /////////////////////////////////////////////////////////////////////////
	
	
	/*
	
	(Get-Content -Path 'C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\this_is_another_page.html') -replace 'href="index.html', 'href="/Documentation.html' | Set-Content  -Path 'C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\this_is_another_page.html'
	
	is equivalent to : 
	
	(Get-Content 'C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\this_is_another_page.html') -replace 'href="index.html', 'href="/Documentation.html' | Set-Content 'C:\GitHub\gamepad-coder\gamepad-coder.github.io\Documentation\this_is_another_page.html'
	
   command := "powershell.exe ""(Get-Content '" . filePath . "') "
                              . "-replace '"   . what . "', '" . with . "'"
                           . " | Set-Content '" . filePath . "'"""
	*/
	
   command := "powershell -NoExit -Command ""(Get-Content '" . filePath . "') "
                              . "-replace '"   . what . "', '" . with . "'"
                           . " | Set-Content '" . filePath . "'"""
	MsgBox % "cmd is`n" command
   if wait
      RunWait, % command
      ;~ RunWait, % command,, Hide
}



















