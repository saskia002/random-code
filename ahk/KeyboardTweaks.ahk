#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"

;;;;;;;;; DESKTOP SWITCHER ;;;;;;;;;

; https://github.com/Ciantic/VirtualDesktopAccessor
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\dll\VirtualDesktopAccessor.dll", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")

GetDesktopCount() {
    global GetDesktopCountProc

    count := DllCall(GetDesktopCountProc, "Int")
    return count
}

SwitchToDesktop(n) {
    global GoToDesktopNumberProc
    global hVirtualDesktopAccessor

    if (!hVirtualDesktopAccessor) {
        TrayTip "VirtualDesktopAccessor.dll not found or failed to load.", "Exiting", "Iconx"
        ExitApp
    }

    if (n > (GetDesktopCount() - 1)) {
        ; TrayTip "Desktop not available.", "", " Icon!"
        return
    }

    DllCall(GoToDesktopNumberProc, "Int", n)
}

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
