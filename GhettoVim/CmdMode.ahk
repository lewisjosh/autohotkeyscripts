; Setup GUI window for showing if VIM command mode is active or not...
SetKeyDelay, 1
SysGet, marea, Monitor
wfactor= 6
hfactor= 69
width= 120
height= 2
xaxis := (marearight-width-wfactor)
yaxis := (mareabottom-height-hfactor)

Gui, font, s10, Arial
Gui, +AlwaysOnTop +Disabled -SysMenu +Owner
Gui, Add, Text,, Command Mode.
Gui, Show, w%width% h%height% x%xaxis% y%yaxis% NoActivate, Command Mode
Gui, Color, FF0000
Gui -Caption

; Map Nav keys
j::Down
k::Up
h::Left
l::Right
+w::SendInput {Shift down}{Ctrl down}{Right}{Ctrl up}{Shift up} ; deal with shift highlighting...
w::SendInput {Ctrl down}{Right}{Ctrl up}
+b::SendInput {Shift down}{Ctrl down}{Left}{Ctrl up}{Shift up} ; deal with shift highlighting...
b::SendInput {Ctrl down}{Left}{Ctrl up}
^b::SendInput, {PgUp}
^f::SendInput, {PgDn}
+g::SendInput {Ctrl down}{End}{Ctrl up}
g::
	; mapping for "gg"
	Input, Key, L1
	If (Key = "g")
		SendInput, {Ctrl down}{Home}{Ctrl up}
return

; Map other keys
+v::SendInput {Home}{Shift down}{End}{ShiftUp} ; ghetto "visual line mode entry"
^w::w ; just preventing w mapping closing windows until better solution is found! (holding down key)
^b::b ; just preventing b mapping closing windows until better solution is found!

; Map Insert mode keys
a::
	GoSub, InsertMode	
+a::
	SendInput, {End}
	GoSub, InsertMode
i::
	GoSub, InsertMode	
+i::
	SendInput, {Home}
	GoSub, InsertMode
^[::
Esc::	
	GoSub, InsertMode

InsertMode:
	Run InsertMode.ahk
	ExitApp
return 
