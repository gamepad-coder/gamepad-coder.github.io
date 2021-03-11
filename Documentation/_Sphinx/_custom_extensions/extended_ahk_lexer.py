from pygments.lexer import RegexLexer, bygroups, using, include, combined
from pygments.token import *

def setup(sphinx):

    from extended_ahk_lexer import AhkTestLexer
    sphinx.add_lexer("AutoHotkey_CustomLexer", AhkTestLexer())

class AhkTestLexer(RegexLexer):
   
    name = 'AutoHotkey'
    aliases = ['ahk_cl, ahk_custom_lexer, ahk_patched']
    filenames = ['*.ahk']
    mimetypes = ['text/x-ahk']
 
    tokens = {
        'root': [
            (r'^(\s*)(/\*)', bygroups(Text, Comment.Multiline), 'incomment'),
            (r'^(\s*)(\()', bygroups(Text, Generic), 'incontinuation'),
            (r'\s+;.*?$', Comment.Single),
            (r'^;.*?$', Comment.Single),
            # (r'[]{}(),;[]', Punctuation),
            (r'[]{},;[]', Punctuation),
            (r'(in|is|and|or|not)\b', Operator.Word),
            # (r'\%[a-zA-Z_#@$][\w#@$]*\%', Name.Variable),
            (r'\%[a-zA-Z_#@$][\w#@$]*\%', Name.Variable.Instance),          # class: 'vi" #349bdd'
            (r'!=|==|:=|\.=|<<|>>|[-~+/*%=<>&^|?:!.]', Operator),
            #MOD:
            (r'[()]', String.Symbol),
            include('commands'),
            #mod, added:
            include('directives'),
            include('ListOfKeys'),
            include('labels'),
            # include('builtInFunctions'),
            include('builtInVariables'),
            #MOD#
            include('keywords'),
            include('class_and_group_keywords'),
            include('userFunctions'),
            include('memberVariables'),
            (r'"', String, combined('stringescape', 'dqs')),
            include('numbers'),
            (r'[a-zA-Z_#@$][\w#@$]*', Name),
            (r'\\|\'', Text),
            (r'\`([,%`abfnrtv\-+;])', String.Escape),
            include('garbage'),
        ],
        'incomment': [
            (r'^\s*\*/', Comment.Multiline, '#pop'),
            (r'[^*/]', Comment.Multiline),
            (r'[*/]', Comment.Multiline)
        ],
        #---------------------
        #Generic                                                  class: 'g'    
        'incontinuation': [
            (r'^\s*\)', Generic, '#pop'),
            (r'[^)]', Generic),
            (r'[)]', Generic),
        ],
        #---------------------
        #Name.Builtin                                             class: 'nb'    #349bdd          
        'directives': [
            (r'(?i)^(\s*)(global|local|static|' #Puppies|Itwasatest:)
             r'#AllowSameLineComments|#ClipboardTimeout|#CommentFlag|'
             r'#ErrorStdOut|#EscapeChar|#HotkeyInterval|#HotkeyModifierTimeout|'
             r'#Hotstring|#If|#IfWinActive|#IfWinExist|#IfWinNotActive|'
             r'#IfWinNotExist|#IncludeAgain|#Include|#InstallKeybdHook|'
             r'#InstallMouseHook|#KeyHistory|#LTrim|#MaxHotkeysPerInterval|'
             r'#MaxMem|#MaxThreads|#MaxThreadsBuffer|#MaxThreadsPerHotkey|'
             r'#NoEnv|#NoTrayIcon|#Persistent|#SingleInstance|#UseHook|'
             r'#WinActivateForce)\b', bygroups(Text, Name.Builtin)),
        ],
        
        #---------------------
        #Keyword.Reserved                                         class: 'kr'    #2cb6ea          
        'commands': [
            (r'(?i)(AutoTrim|BlockInput|Click|ClipWait|'
             r'Control|ControlClick|ControlFocus|ControlGetFocus|'
             r'ControlGetPos|ControlGetText|ControlGet|ControlMove|ControlSend|'
             r'ControlSendRaw|ControlSetText|CoordMode|Critical|'
             r'DetectHiddenText|DetectHiddenWindows|Drive|DriveGet|'
             r'DriveSpaceFree|Edit|EnvAdd|EnvDiv|EnvGet|EnvMult|EnvSet|'
             r'EnvSub|EnvUpdate|Exit|ExitApp|FileAppend|'
             r'FileCopy|FileCopyDir|FileCreateDir|FileCreateShortcut|'
             r'FileDelete|FileGetAttrib|FileGetShortcut|FileGetSize|'
             r'FileGetTime|FileGetVersion|FileInstall|FileMove|FileMoveDir|'
             r'FileRead|FileReadLine|FileRecycle|FileRecycleEmpty|'
             r'FileRemoveDir|FileSelectFile|FileSelectFolder|FileSetAttrib|'
             r'FileSetTime|FormatTime|GetKeyState|GroupActivate|'
             r'GroupAdd|GroupClose|GroupDeactivate|Gui|GuiControl|'
             r'GuiControlGet|Hotkey|ImageSearch|IniDelete|IniRead|IniWrite|'
             r'InputBox|Input|KeyHistory|KeyWait|ListHotkeys|ListLines|'
             r'ListVars|Menu|MouseClickDrag|MouseClick|MouseGetPos|'
             r'MouseMove|MsgBox|OnExit|OutputDebug|Pause|PixelGetColor|'
             r'PixelSearch|PostMessage|Process|Progress|Random|RegDelete|'
             r'RegRead|RegWrite|Reload|Repeat|RunAs|RunWait|Run|'
             r'SendEvent|SendInput|SendMessage|SendMode|SendPlay|SendRaw|Send|'
             r'SetBatchLines|SetCapslockState|SetControlDelay|'
             r'SetDefaultMouseSpeed|SetEnv|SetFormat|SetKeyDelay|'
             r'SetMouseDelay|SetNumlockState|SetScrollLockState|'
             r'SetStoreCapslockMode|SetTimer|SetTitleMatchMode|'
             r'SetWinDelay|SetWorkingDir|Shutdown|Sleep|Sort|SoundBeep|'
             r'SoundGet|SoundGetWaveVolume|SoundPlay|SoundSet|'
             r'SoundSetWaveVolume|SplashImage|SplashTextOff|SplashTextOn|'
             r'SplitPath|StatusBarGetText|StatusBarWait|StringCaseSense|'
             r'StringGetPos|StringLeft|StringLen|StringLower|StringMid|'
             r'StringReplace|StringRight|StringSplit|StringTrimLeft|'
             r'StringTrimRight|StringUpper|Suspend|SysGet|Thread|ToolTip|'
             r'Transform|TrayTip|URLDownloadToFile|WinActivate|'
             r'WinActivateBottom|WinClose|WinGetActiveStats|WinGetActiveTitle|'
             r'WinGetClass|WinGetPos|WinGetText|WinGetTitle|WinGet|WinHide|'
             r'WinKill|WinMaximize|WinMenuSelectItem|WinMinimizeAllUndo|'
             r'WinMinimizeAll|WinMinimize|WinMove|WinRestore|WinSetTitle|'
             r'WinSet|WinShow|WinWaitActive|WinWaitClose|WinWaitNotActive|'
             r'WinWait|'
             r'Abs|ACos|Asc|ASin|ATan|Ceil|Chr|Cos|DllCall|Exp|FileExist|'
             r'Floor|GetKeyState|IL_Add|IL_Create|IL_Destroy|InStr|IsFunc|'
             r'IsLabel|Ln|Log|LV_Add|LV_Delete|LV_DeleteCol|LV_GetCount|'
             r'LV_GetNext|LV_GetText|LV_Insert|LV_InsertCol|LV_Modify|'
             r'LV_ModifyCol|LV_SetImageList|Mod|NumGet|NumPut|OnMessage|'
             r'RegExMatch|RegExReplace|RegisterCallback|Round|SB_SetIcon|'
             r'SB_SetParts|SB_SetText|Sin|Sqrt|StrLen|SubStr|Tan|TV_Add|'
             r'TV_Delete|TV_GetChild|TV_GetCount|TV_GetNext|TV_Get|'
             r'TV_GetParent|TV_GetPrev|TV_GetSelection|TV_GetText|TV_Modify|'
             r'VarSetCapacity|WinActive|WinExist|Object|ComObjActive|'
             r'ComObjArray|ComObjEnwrap|ComObjUnwrap|ComObjParameter|'
             r'ComObjType|ComObjConnect|ComObjCreate|ComObjGet|ComObjError|'
             r'ComObjValue|Insert|MinIndex|MaxIndex|Remove|SetCapacity|'
             r'GetCapacity|GetAddress|_NewEnum|FileOpen|Read|Write|ReadLine|'
             r'WriteLine|ReadNumType|WriteNumType|RawRead|RawWrite|Seek|Tell|'
             r'Close|Next|IsObject|StrPut|StrGet|'
             r'Trim|LTrim|RTrim)\b', Keyword.Reserved),
        ],
        #---------------------
        #Name.Variable                                            class: 'nv'
        'builtInVariables': [
            (r'(?i)(A_AhkPath|A_AhkVersion|A_AppData|A_AppDataCommon|'
             r'A_AutoTrim|A_BatchLines|A_CaretX|A_CaretY|A_ComputerName|'
             r'A_ControlDelay|A_Cursor|A_DDDD|A_DDD|A_DD|A_DefaultMouseSpeed|'
             r'A_Desktop|A_DesktopCommon|A_DetectHiddenText|'
             r'A_DetectHiddenWindows|A_EndChar|A_EventInfo|A_ExitReason|'
             r'A_FormatFloat|A_FormatInteger|A_Gui|A_GuiEvent|A_GuiControl|'
             r'A_GuiControlEvent|A_GuiHeight|A_GuiWidth|A_GuiX|A_GuiY|A_Hour|'
             r'A_IconFile|A_IconHidden|A_IconNumber|A_IconTip|A_Index|'
             r'A_IPAddress1|A_IPAddress2|A_IPAddress3|A_IPAddress4|A_ISAdmin|'
             r'A_IsCompiled|A_IsCritical|A_IsPaused|A_IsSuspended|A_KeyDelay|'
             r'A_Language|A_LastError|A_LineFile|A_LineNumber|A_LoopField|'
             r'A_LoopFileAttrib|A_LoopFileDir|A_LoopFileExt|A_LoopFileFullPath|'
             r'A_LoopFileLongPath|A_LoopFileName|A_LoopFileShortName|'
             r'A_LoopFileShortPath|A_LoopFileSize|A_LoopFileSizeKB|'
             r'A_LoopFileSizeMB|A_LoopFileTimeAccessed|A_LoopFileTimeCreated|'
             r'A_LoopFileTimeModified|A_LoopReadLine|A_LoopRegKey|'
             r'A_LoopRegName|A_LoopRegSubkey|A_LoopRegTimeModified|'
             r'A_LoopRegType|A_MDAY|A_Min|A_MM|A_MMM|A_MMMM|A_Mon|A_MouseDelay|'
             r'A_MSec|A_MyDocuments|A_Now|A_NowUTC|A_NumBatchLines|A_OSType|'
             r'A_OSVersion|A_PriorHotkey|A_ProgramFiles|A_Programs|'
             r'A_ProgramsCommon|A_ScreenHeight|A_ScreenWidth|A_ScriptDir|'
             r'A_ScriptFullPath|A_ScriptName|A_Sec|A_Space|A_StartMenu|'
             r'A_StartMenuCommon|A_Startup|A_StartupCommon|A_StringCaseSense|'
             r'A_Tab|A_Temp|A_ThisFunc|A_ThisHotkey|A_ThisLabel|A_ThisMenu|'
             r'A_ThisMenuItem|A_ThisMenuItemPos|A_TickCount|A_TimeIdle|'
             r'A_TimeIdlePhysical|A_TimeSincePriorHotkey|A_TimeSinceThisHotkey|'
             r'A_TitleMatchMode|A_TitleMatchModeSpeed|A_UserName|A_WDay|'
             r'A_WinDelay|A_WinDir|A_WorkingDir|A_YDay|A_YEAR|A_YWeek|A_YYYY|'
             r'Clipboard|ClipboardAll|ComSpec|ErrorLevel|ProgramFiles|True|'
             r'False|A_IsUnicode|A_FileEncoding|A_OSVersion|A_PtrSize)\b',
             Name.Variable),
        ],
        #---------------------
        #Name.Constant
        # 'constants': [
            # (r'(?i)(True|False)\b', Name.Constant),
        # ],
        #---------------------
        #Name.Label                                               class: 'nl'   #ff9bbf - light pink
        'labels': [
            # hotkeys and labels
            # technically, hotkey names are limited to named keys and buttons
            # (r'(^\s*)([^:\s("]+?:{1,2})', bygroups(Text, Name.Label)),
            # (r'(^\s*)(::[^:\s]+?::)', bygroups(Text, Name.Label)),
                # (r'(^\s*)([^:\s("]+?:{1})', bygroups(Text, Name.Label)),
            (r'(^\s*)([^:\s("]+?:[^:])', bygroups(Text, Name.Label)),
        ],
        #---------------------
        #Number.Integer                                           class: 'm'
        #Number.Integer.Long
        #Number.Float
        #Number.Hex
        #Number.Oct
        'numbers': [
            (r'(\d+\.\d*|\d*\.\d+)([eE][+-]?[0-9]+)?', Number.Float),
            (r'\d+[eE][+-]?[0-9]+', Number.Float),
            (r'0\d+', Number.Oct),
            (r'0[xX][a-fA-F0-9]+', Number.Hex),
            (r'\d+L', Number.Integer.Long),
            (r'\d+', Number.Integer)
        ],
        #---------------------
        #String.Escape                                            class: 'se'
        'stringescape': [
            (r'\"\"|\`([,%`abfnrtv])', String.Escape),
        ],
        #---------------------
        #String                                                   class: 's'    #fff7ab - light yellow
        'strings': [
            (r'[^"\n]+', String),
        ],
        #---------------------
        #String                                                   class: 's'
        'dqs': [
            (r'"', String, '#pop'),
            include('strings')
        ],
        #---------------------
        #Text
        'garbage': [
            (r'[^\S\n]', Text),
            # (r'.', Text),      # no cheating
        ],
        
        #===========================================
        #Mod#        below this line:              #
        #            added (or moved)              #
        #===========================================
        
        #---------------------
        #Keyword                                                  class: 'k'    #efeb66 - yellow
        #Keyword                                                  class: 'k'    #fff385 - yellow            
        #Keyword                                                  class: 'k'    #ffeb36 - yellow            *
        'keywords': [
            (r'(?i)(class|Return|Break|Catch|Continue|Else|Finally|For|Gosub|Goto|'
             r'If|IfEqual|IfExist|IfGreaterOrEqual|IfGreater|'
             r'IfLess|IfLessOrEqual|IfMsgBox|IfNotEqual|IfNotExist|'
             r'IfInString|IfNotInString|'
             r'IfWinActive|IfWinExist|IfWinNotActive|IfWinNotExist'
             r'Loop|Try|While)\b', Keyword),
        ],
        #---------------------
        #Name.Function                                            class: 'nf'
        'userFunctions': [
            # matches `thing`() and `things`(and,`stuff`(),areneat)
            (r'(\b)[\w]+(?=\()', Name.Function)
        ],
        #---------------------
        #Name.Variable.Class                                      class: 'vc'   #34cfab - teal green
        #Name.Variable.Class                                      class: 'vc'   #4fd5b0 - teal green
        'memberVariables': [
            # matches objecct.`_member` or `_memberVariable`
            # does not match %dereference_string%_restOfVarName
            # (r'(\.|\b)_[\w]+', Name.Variable.Class)
            (r'(\.|\b)(?<!\%)_[\w]+', Name.Variable.Class)
        ],
        #---------------------
        #Name.Namespace                                           class: 'nn'   #ae81ff - purple
        'class_and_group_keywords': [
            (r'(?i)(__New|__Get|__Set|__Delete|'
             r'this|super|base|extends|'
             r'ahk_class|ahk_exe|ahk_group|ahk_id|ahk_pid|'
             r'guiclose|guicontextmenu|guidropfiles|'
             r'guiescape|guisize|'
             r'InsertAt|RemoveAt|Push|Pop|Delete|'
             r'MinIndex|MaxIndex|Length|Count|SetCapacity|'
             r'GetCapacity|GetAddress|_NewEnum|'
             r'HasKey|Clone|Insert|Remove)\b', Name.Namespace),
        ],
        #---------------------
        #Keyword.Pseudo                                           class: 'kp'    #2cb6ea   
        #                                                          (kp: because it's close to "keypad")
        'ListOfKeys': [
            (r'(?i)(lbutton|mbutton|rbutton|'
              r'xbutton1|xbutton2|wheelup|wheeldown|wheelleft|wheelright|'
              r'alt|altdown|altup|appskey|backspace|blind|'
              r'browser_back|browser_favorites|browser_forward|browser_home|'
              r'browser_refresh|browser_search|browser_stop|'
              r'bs|capslock|click|control|ctrl|ctrlbreak|ctrldown|ctrlup|'
              r'del|delete|down|end|enter|esc|escape|'
              r'lalt|lcontrol|lctrl|left|lshift|lwin|lwindown|lwinup|'
              r'rcontrol|rctrl|right|rshift|rwin|rwindown|rwinup|'
              r'scrolllock|shift|shiftdown|shiftup|space|tab|up|'
              r'home|ins|insert|'
              r'f1|f2|f3|f4|f5|f6|f7|f8|f9|f10|f11|f12|'
              r'f13|f14|f15|f16|f17|f18|f19|f20|f21|f22|f23|f24|'
              r'joy1|joy2|joy3|joy4|joy5|joy6|joy7|joy8|joy9|'
              r'joy10|joy11|joy12|joy13|joy14|joy15|joy16|joy17|joy18|'
              r'joy19|joy20|joy21|joy22|joy23|joy24|joy25|joy26|joy27|'
              r'joy28|joy29|joy30|joy31|joy32|'
              r'joyaxes|joybuttons|joyinfo|joyname|joypov'
              r'joyr|joyu|joyv|joyx|joyy|joyz|'
              r'launch_app1|launch_app2|launch_mail|launch_media|'
              r'media_next|media_play_pause|media_prev|media_stop|'
              r'numlock|numpad0|numpad1|numpad2|numpad3|numpad4|numpad5|'
              r'numpad6|numpad7|numpad8|numpad9|'
              r'numpadadd|numpadclear|numpaddel|numpaddiv|'
              r'numpaddot|numpaddown|numpadend|numpadenter|'
              r'numpadhome|numpadins|numpadleft|numpadmult|'
              r'numpadpgdn|numpadpgup|numpadright|numpadsub|'
              r'numpadup|pause|pgdn|pgup|printscreen|ralt|raw|'
              r'volume_down|volume_mute|volume_up)\b', Keyword.Pseudo)
        ],
        
        
            #-------------------------------------------------
            #mod, moved this into commands / Name.Builtin
            #-------------------------------------------------
            #neutered, going to recast to encapsulate thing.functioncall() and func()
            #-------------------------------------------------
            # 'builtInFunctions': [
                # (r'(?i)()\b',
                 # Name.Function),
            # ],
            #-------------------------------------------------
    }
