#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
;Persistent

;;;;;;;;; DESKTOP SWITCHER ;;;;;;;;;

; https://github.com/Ciantic/VirtualDesktopAccessor
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\dll\VirtualDesktopAccessor.dll", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")

init() {
    global GetCurrentDesktopNumberProc
    currentDesktop := DllCall(GetCurrentDesktopNumberProc, "Int")

    setTrayIcon(currentDesktop)
}

setTrayIcon(desktopNumber) {
    trayMenu := A_TrayMenu
    iconFolder := A_ScriptDir . "\icon\"

    TraySetIcon iconFolder . desktopNumber . ".ico"
}

GetDesktopCount() {
    global GetDesktopCountProc

    count := DllCall(GetDesktopCountProc, "Int")
    return count
}

SwitchToDesktop(desktop) {
    global GoToDesktopNumberProc
    global hVirtualDesktopAccessor

    if (!hVirtualDesktopAccessor) {
        TrayTip "VirtualDesktopAccessor.dll not found or failed to load.", "Exiting", "Iconx"
        ExitApp
    }

    if (desktop > (GetDesktopCount() - 1)) {
        ; TrayTip "Desktop not available.", "", " Icon!"
        return
    }

    setTrayIcon(desktop)

    DllCall(GoToDesktopNumberProc, "Int", desktop)
}

init()

;;;;;;;;; DESKTOP SWITCHER END ;;;;;;;;;

;;;;;;;;; KEY REMAP ;;;;;;;;;

; AltGr  := "<^>!"
; Ctrl   := "^"
; Shift  := "+"
; Win    := "#"

#1:: SwitchToDesktop(0)
#2:: SwitchToDesktop(1)
#3:: SwitchToDesktop(2)
#4:: SwitchToDesktop(3)

^,::
<^>!,::
{
    SendInput "<"
    return
}

^.::
<^>!.::
{
    SendInput ">"
    return
}

^'::
<^>!'::
{
    SendInput "|"
    return
}

;;;;;;;;; KEY REMAP END ;;;;;;;;;
