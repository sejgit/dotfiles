; AutoHotkey2.ahk
; shortcut script for windows keys
; using AutoHotkey2.0
#Requires AutoHotkey >=2.0

/*
Change Logs

2018 08 15 SeJ init
2018 08 28 add window to deskop
2018 10 02 fix caps lock issue & set-up Emacs modifiers
2022 06 13 alternative 2/3 window because Teams does not behave
2023 01 26 add tab + n, p, d as proxies for Emacs movement
2023 06 16 convert to 2.0 functional script
*/

/*
Reminder of the Autokey basics
Symbol	Description
#	Win (Windows logo key)
!	Alt
^	Control
+	Shift
&	An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey
*/

/*
Script Set-ups
*/
InstallKeybdHook
#SingleInstance Force
 SetWorkingDir A_ScriptDir
 SendMode "Input"
SetTitleMatchMode "RegEx"

 /*
 Global Includes / Run
 */
 
 ; #h hide window #u unhide last, list of hidden in ahk menu
#Include "MinimizeToTrayMenu.ahk"
  
 /* 
 Global Hotkeys
 */
 ; use CapsLock for LeftControl usage
SetCapsLockState "AlwaysOff"

; shift CapsLock for normal
+CapsLock::CapsLock

; capslock becomes ctrl
CapsLock::LControl

; Tab modifier set-up
Tab::Send "{Tab}"
+Tab::Send "{Shift}{Tab}"
<!Tab::AltTab

;Space modifier set-up
Space::Send("{Space}")

; activate or run Outlook Calendar
Tab & c:: {
	if WinExist("Calendar.*Outlook ahk_class rctrl_renwnd32")
		WinActivate
	else
		Run "Outlook"
	Visualize("OutlookCalendar")
 }

#c::PopUpCalendar()

; launch or switch emacs.ahk"
Tab & e:: {
	If WinExist("ahk_class Emacs")
		WinActivate
	else {
		Run "C:\msys64\mingw64\bin\runemacs.exe"
		WinWait("ahk_class Emacs")
		WinActivate		
	}
	Visualize("Emacs")
 }

; activate or run Outlook Inbox
Tab & i:: {
	if WinExist("Inbox.*Outlook ahk_class rctrl_renwnd32")
		WinActivate
	else
		Run "Outlook"
	Visualize("OutlookInbox")
 }

; activate or run NotePad++
Tab & n:: {
	if WinExist("ahk_class Notepad++")
		WinActivate
	else {
		Run "Notepad++"
		WinRightCycle()
	}
	Visualize("Notepad++")
 }

; reset and reload
Tab & r::Reload 

; activate or run Teams Chat
Tab & t:: {
	WinInfo:=WinGetList(".*Microsoft Teams ahk_class Chrome_WidgetWin_1")
	if WinInfo {
		for this_id in WinInfo
			WinActivate this_id
		}
	else
		Run "Teams"
	Visualize("TeamsChat")
 }

; tooltip info
Tab & w:: {
	MsgBox(WinGetTitle("A"))
	MsgBox(WinGetClass("A"))
	WinInfo:=WinGetList("A")
	Loop WinInfo.Length
		MsgBox WinInfo[A_Index]
}

;; vim navigation with hyper
>!h::Send "{Left}"
>!l::Send "{Right}"
>!k::Send "{Up}"
>!j::Send "{Down}"

;; Emacs type navigation
>!n::Send "{Down}"
>!p::Send "{Up}"
>!d::Send "{Del}"
>!a::Send "{Home}"
>!e::Send "{End}"

/* window moves within a screen */

;win lalt
#<!Left::WinLeftCycle()
#<!+Left::WinLeft35()
#<!Right::WinRightCycle()
#<!+Right::WinRight35()
#<!Up::WinFull()

;lalt
<#!h::WinLeftCycle()
<#!l::WinRightCycle()
<#!k::WinFull()

;lalt shift
<!+h::MoveActiveWindowBy(-10,   0)
<!+l::MoveActiveWindowBy(+10,   0)
<!+k::MoveActiveWindowBy(  0, -10)
<!+j::MoveActiveWindowBy(  0, +10)

;visualize function
Visualize(txt?) {
	ToolTip txt
	SetTimer () => ToolTip(), -1000
}

; cycle on the left hand side
WinLeftCycle() {
	WinGetPos &X, &Y, &Width, &Height, "A"
	If((X != 0) OR (Y != 0) OR ((Width != A_ScreenWidth/2) AND (Width != A_ScreenWidth*2/5)) OR (Height != A_ScreenHeight)) {
		WinRestore("A")
		WinMove 0, 0, (A_ScreenWidth/2), (A_ScreenHeight), "A"
		Visualize("WinLeft1/2")
	} 
	else If((X = 0) AND (Y = 0) AND (Width = A_ScreenWidth/2) AND (Height = A_ScreenHeight)) {
		WinRestore "A"
		WinMove 0, 0, (A_ScreenWidth*2/5), (A_ScreenHeight), "A"
		Visualize("WinLeft2/5")
	} 
	else {
		WinRestore "A"
		WinMove 0, 0, (A_ScreenWidth*3/5), (A_ScreenHeight), "A"
		Visualize("WinLeft3/5")
	}
}

; 3/5 left hand side directly
WinLeft35() {
	WinGetPos &X, &Y, &Width, &Height, "A"
	WinRestore("A")
	WinMove 0, 0, (A_ScreenWidth*3/5), (A_ScreenHeight), "A"
	Visualize("WinLeft3/5")
}

; cycle on the right hand side
WinRightCycle() {
	WinGetPos &X, &Y, &Width, &Height, "A"
	If(((X != A_ScreenWidth/2) AND (X != A_ScreenWidth*3/5)) OR (Y != 0) OR ((Width != A_ScreenWidth/2) AND (Width != A_ScreenWidth*2/5)) OR (Height != A_ScreenHeight)) {
		WinRestore("A")
		WinMove (A_ScreenWidth/2), 0, (A_ScreenWidth/2), (A_ScreenHeight), "A"
		Visualize("WinRight1/2")
	}
	else If((X = A_ScreenWidth/2) AND (Y = 0) AND (Width = A_ScreenWidth/2) AND (Height = A_ScreenHeight)) {
		WinRestore "A"
		WinMove (A_ScreenWidth*3/5), 0, (A_ScreenWidth*2/5), (A_ScreenHeight), "A"
		Visualize("WinRight3/5")
	} 
	else {
		WinRestore "A"
		WinMove (A_ScreenWidth*2/5), 0, (A_ScreenWidth*3/5), (A_ScreenHeight), "A"
		Visualize("WinRight2/5")
	}
}

; 2/3 right hand side directly
WinRight35() {
	WinGetPos &X, &Y, &Width, &Height, "A"
	WinRestore("A")
	WinMove (A_ScreenWidth*2/5), 0, (A_ScreenWidth*3/5), (A_ScreenHeight), "A"
	Visualize("WinRight3/5")
}

; window to full screen size (not doing a maximize)
WinFull() {
	Title := WinGetTitle("A")
	WinGetPos &X, &Y, &Width, &Height, "A"
	If((Width != A_ScreenWidth) OR (Height != A_ScreenHeight)) {
		WinRestore "A"
		WinMove 0, 0, (A_ScreenWidth), (A_ScreenHeight), "A"
		Visualize("WinFull")
	}
}

; moving the active window
MoveActiveWindowBy(x, y) {
    WinExist "A"  ; Make the active window the Last Found Window  
    WinGetPos &current_x, &current_y
    WinMove current_x + x, current_y + y
}


/* pop-up Calendar */
;; AutoHotkey doesn't have nulls,
;; so empty strings are often used to denote "nothing."
;; https://lexikos.github.io/v2/docs/Concepts.htm#nothing
global Calendar := ''

;; Win + c
PopUpCalendar() {
    ;; Destroy the old calendar first
    ;; to limit the amount of open calendars to one
    ;; and to reset the date selection and window position
    DestroyCalendar()

    CreateCalendar()
    Calendar.Show()
}

;; The asterisk makes the function variadic,
;; i.e. it accepts any number of parameters.
;; We call it with 0 parameters,
;; and GUI events call it with 1 parameter (the GUI object),
;; so the function must be variadic or the script won't run.
;; https://lexikos.github.io/v2/docs/Functions.htm#Variadic
DestroyCalendar(*) {
    SetTimer(UpdateTitle, 0)

    global Calendar
    if Calendar
    {
        Calendar.Destroy()
        Calendar := ''
    }
}

CreateCalendar() {
    global Calendar := Gui('-MinimizeBox', GetTitle())
    Calendar.MarginX := -18
    Calendar.MarginY := -15

    ;; 4   = Show week numbers
    ;; R3  = Show 3 rows
    ;; W-4 = Show 4 columns
    Calendar.Add('MonthCal', '4 R3 W-4')

    Calendar.OnEvent('Close', DestroyCalendar)
    Calendar.OnEvent('Escape', DestroyCalendar)

    SetTimer(UpdateTitle, 100)
}

GetTitle() {
    ;; En dash, not a hyphen
    Prefix := 'Calendar – '

    ;; T0 = Show seconds
    Time := FormatTime('T0', 'Time')

    return Prefix . Time
}

UpdateTitle() {
    Calendar.Title := GetTitle()
}


/* Emacs hotkeys */
#HotIf WinActive("ahk_class Emacs")
 ;; left Control to appskey to be used as super modifier
 LControl::Appskey
 ;; RAlt to numlock to be used as Alt modifier (leave LAlt as meta)
 RAlt::NumLock


/* MSYS hotkeys */
#HotIf WinActive("ahk_class mintty")
!c::Send "{Control}{NumpadIns}"
!v::Send "{Shift}{NumpadIns}"

