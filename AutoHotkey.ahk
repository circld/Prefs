; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

LastWindowID := ""
DailyID := ""
ProdID := ""
ActiveID := ""

GL_func(is_prod)
{
    ; is_prod = 0 for daily, 1 for production
    if(is_prod)
    {
        global ProdID
        id_name := "ProdID"
        id_other := "DailyID"
        path := "C:\Program Files (x86)\Strategic Insight\Simfund\Application\SIGL.EXE"
        pos_x := 960
    }
    else
    {
        global DailyID
        id_name := "DailyID"
        id_other := "ProdID"
        path := "C:\Program Files (x86)\Strategic Insight\Simfund\Application_D\SIGL.EXE"
        pos_x = 0
    }
    temp := %id_name%
    IfWinNotExist, ahk_id %temp%
    {
        %id_name% := ""
    }
    if(%id_name% == "")
    {
        if(%id_other% != "")
        {
                temp := %id_other%
            WinMinimize, ahk_id %temp%
        }
            Run, %path%
            SetTitleMatchMode, 2
        SetTitleMatchMode RegEx
            WinWaitActive, .*\.SPF.*,,20
            if ErrorLevel
                 MsgBox, Didn't work
            else
        {
                WinGet, %id_name%, ID, A
                WinRestore
                temp := %id_name%
                WinMove, ahk_id %temp%,, pos_x, 0, 960, 1200
        }
        if(%id_other% != "")
        {
                temp := %id_other%
            WinRestore, ahk_id %temp%
                temp := %id_name%
                WinActivate, ahk_id %temp%
        }
    }
    else
    {
        SetTitleMatchMode, 2
        IfWinExist, ahk_id %temp%
        {
            IfWinActive, ahk_id %temp%
            {
                WinMinimize
            }
            else
            {
                WinRestore
                WinActivate
            }
        }
    }
}

#u:: GL_func(0)
+#u:: GL_func(1)

; RIGHT SCROLLING WITH MOUSE WHEEL

LShift & WheelUp::  ; Scroll left.
    SetTitleMatchMode, 2
    IfWinActive, - Excel
    {
        ;SetScrollLockState, on
        send,{left}
        ;SetScrollLockState, off
    }
    IfWinActive, Simfund/GL
    {
        ;SetScrollLockState, on
        send,{left}
        ;SetScrollLockState, off
    }
    else
    {
	ControlGetFocus, fcontrol, A
	Loop 10  ; <-- Increase this value to scroll faster.
    	    SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
    }
return

LShift & WheelDown::  ; Scroll right.
    SetTitleMatchMode, 2
    IfWinActive, - Excel
    {
        ;SetScrollLockState, on
        send,{right}
        ;SetScrollLockState, off
    }
    IfWinActive, Simfund/GL
    {
        ;SetScrollLockState, on
        send,{right}
        ;SetScrollLockState, off
    }
	else
	{
	ControlGetFocus, fcontrol, A
	Loop 10  ; <-- Increase this value to scroll faster.
		SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT.
	}
return

; PIDGIN CHAT WINDOW SHORTCUT

#Tab::  ; Grabs Pidgen chat window or opens program if not open
    SetTitleMatchMode, 2
    IfWinExist,, Pidgin, Buddy List
    {
        IfWinNotActive,, Pidgin, Buddy List
        {
            WinActivate,, Pidgin, Buddy List
        }
        else
        {
            WinMinimize,, Pidgin, Buddy List
        }
    }
    else
    {
    Run, C:\Program Files (x86)\Pidgin\pidgin.exe
    }
return

; RDP WINDOW MANIPULATION
#`::
    SetTitleMatchMode, 2
    IfWinExist, - Remote Desktop Connection
    {
        IfWinNotActive, - Remote Desktop Connection
        {
            WinActivate, - Remote Desktop Connection
        }
        else
        {
            WinMinimize, - Remote Desktop Connection
        }
    }
    else
    {
        SetTitleMatchMode, RegEx
        Run, "C:\Program Files (x86)\Cisco Systems\VPN Client\vpngui.exe"
        WinWaitActive, .*status:.*VPN Client.*,,20
        IfWinExist, .*status: Connected.*VPN.*
        {
            WinClose
            Run, "%windir%\system32\mstsc.exe"
        }
        else
        {
            WinWaitClose , .*status:.*VPN Client.*,,120
	    Run, "%windir%\system32\mstsc.exe"
        }
    }
return

; EXCEL WINDOW MANIPULATION

#;::  ; Activates/minimizes Excel or opens it if not open
    SetTitleMatchMode, 2
    IfWinExist, - Excel
    {
        IfWinActive, - Excel
        {
            WinMinimize, - Excel
        }
        else
        {
            WinActivate, - Excel
        }
    }
    else
    {
    Run, "C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE"
    }
return

; gVim
#v::
    SetTitleMatchMode, 2
    IfWinExist, - GVIM
    {
        IfWinActive, - GVIM
        {
            WinMinimize, - GVIM
        }
        else
        {
            WinActivate, - GVIM
        }
    }
return

; TOGGLE MINIMIZING A WINDOW

#m::
    LastWindowID := ""
    WinGet, LastWindowID, ID, A
    WinMinimize, A
return

+#m:: 
    WinActivate, ahk_id %LastWindowID%
return

; GL DAILY & PRODUCTION WINDOW MANIPULATION

; DAILY
;#`::  GL_func(0)

; PRODUCTION
;+#`::  GL_func(1)

+#5::
    WinGet, ActiveID, ID, A
    WinGetActiveTitle, Title
    MsgBox, The active window is "%Title%".
    ListVars
return

; SnagIt
;#IfWinNotExist, ahk_class SnagIt5UI
;PrintScreen::
;    {
;    Run, C:\Program Files (x86)\TechSmith\SnagIt 8\SnagIt32.exe
;    WinWait, ahk_class SnagIt5UI,,10
;    Send {PrintScreen}
;    }
;return

; Windows Explorer
#IfWinExist, ahk_class CabinetWClass
#e:: 
    IfWinActive, ahk_class CabinetWClass
    {
        WinMinimize, ahk_class CabinetWClass
    }
    else
    {
        WinActivate, ahk_class CabinetWClass
    }
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
