#NoEnv
SendMode Input
;SetWorkingDir %A_ScriptDir%


AltGr  := "<^>!"
Ctrl   := "^"
Shift  := "+"

%Ctrl%,::
%AltGr%,::
SendInput <
Return

%Ctrl%.::
%AltGr%.::
SendInput >
Return

%AltGr%-::
SendInput </>
Return

%Ctrl%-::
SendInput <>
Return


%Ctrl%'::
%AltGr%'::
SendInput |
Return


%Ctrl%%Shift%,::
SendInput ()
Return

%Ctrl%%Shift%.::
SendInput []
Return

%Ctrl%%Shift%-::
SendInput {{}}
Return

%Ctrl%%Shift%ü::
SendInput ∨
Return

%Ctrl%%Shift%õ::
SendInput ∧
Return

%Ctrl%%Shift%ä::
SendInput Ɐ
Return

%Ctrl%%Shift%ö::
SendInput Ǝ
Return


%Ctrl%%Shift%0::
SendInput ≡
Return

%Ctrl%%Shift%+::
SendInput ⋮
Return

%Ctrl%%Shift%l::
SendInput ∈
Return
