#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Sebastian Eves-van den Akker

 Script Function: Count pixel number if different from background (predefined) within area on screen defined by mouseclicks
 Written for windows 7 - in anything after windows 7 it is so slow its practically unusable (although with enough time, it will work).
 Press escape at any time to kill, or PAUSE to pause


#ce ----------------------------------------------------------------------------
Global $Paused
Global $test
HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{ESC}", "Terminate")

Func Terminate()
    Exit 0
 EndFunc

Func TogglePause()
  $Paused = NOT $Paused
  While $Paused
    sleep(100)
    ToolTip('Script is "Paused"',0,0)
  WEnd
  ToolTip("")
EndFunc

$count = 0
#Include <Misc.au3>
#include <Array.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#Include <GUIConstantsEx.au3>
#Include <WindowsConstants.au3>
#Include <WinAPI.au3>
#include <ScreenCapture.au3>
;============================================================================================================

_DwmEnable(False)
;=====================Creates the Graphical User Interface of the Program=================================
GUICreate("Colour Counter", 240,220,@DesktopWidth -245,0)

$next = GUICtrlCreateButton("Start",20, 10, 80, 20)
$slider1 = GUICtrlCreateSlider(10, 50, 220, 20,$TBS_TOP)
GUICtrlSetLimit(-1, 200, 1)
$button = GUICtrlCreateInput("Shades of Variation",175, 70, 50, 20)
$n3 = GUICtrlCreateInput("#",20, 120, 50, 20)
GUICtrlCreateGroup ( "Shades of Variation", 10, 35, 220,60)
GUICtrlCreateGroup ( "Pixel Count", 10, 100, 70,45)
$check = GUICtrlCreateCheckbox("Reporter", 100, 100, 120, 20)
$checkgfp = GUICtrlCreateCheckbox("Background", 100, 130, 120, 20)
GuiCtrlSetState($checkgfp, $GUI_CHECKED)
GuiCtrlSetState($check, $GUI_CHECKED)
$button5 = GUICtrlCreateInput("Colour",15, 170, 105, 20)
GUICtrlCreateGroup ( "Malual input colour", 10, 150, 120,50)
$checkmanual = GUICtrlCreateCheckbox("Manual Colour", 140, 170, 120, 20)

GUISetState()
;============================================================================================================
Fileread("Colour Counter.txt")
if @error then
_Filecreate("Colour Counter.txt")
endif
;========================================Default Shades of variation, 42=====================================
GUICtrlSetData($button, 30)
GUICtrlSetData($slider1, 30)


Do
	$msg = GUIGetMsg()

	if $msg = $GUI_EVENT_CLOSE Then
		exit 0
	endif

$sliderread = GUICtrlRead($slider1, 1)
GUICtrlSetData($button, $sliderread)

	if $msg = $GUI_EVENT_CLOSE Then
		exit 0
		endif

tooltip("Click Start when ready to start",0,0, "If at any time you wish to end Press ESC or Press PAUSE-BREAK to pause")



if GUIctrlread($checkmanual) = $GUI_CHECKED then
	GuiCtrlSetState($checkgfp, $GUI_UNCHECKED)
	$color = GUIctrlread ($button5)
endif



if $msg = $next and (GUIctrlread($checkmanual) = $GUI_CHECKED or  GUIctrlread($checkgfp) = $GUI_CHECKED)  Then

sleep(500)
do
do

tooltip("click top left",0,0)
sleep(50)
until _ispressed(01)
$array = mousegetpos()
sleep(500)
do

tooltip("click bottom right",0,0)
sleep(50)
until _ispressed(01)
$array1 = mousegetpos()

$y = $array[1]
$x = $array[0]
$xb = $array1[0]
$yb = $array1[1]

$shades = GUIctrlread($slider1)

$xta = $x
$yta = $y
$xba = $xb
$yba = $yb
$time = timerinit ()
tooltip("working, wait",0,0)

if GUIctrlread($checkgfp) = $GUI_CHECKED then
$color = 0xD1D1D1 ;Change color here to background color of image after transformations if you want it hard coded.
endif


$color2 = 0x000000
$hDC = _WinAPI_GetWindowDC(0)

do


Do
	$x = $x + 1
	$pix = pixelsearch($x,$y,$x+1,$y+1,$color,$shades)
	if @error then
		$count = $count + 1
		if GUIctrlread($check) = $GUI_CHECKED then
			_WinAPI_DrawLine($hDC,$x,$y,$x+1,$y)
		endif
	endif

until $x > $xba
$x = $xta
$y = $y + 1
until $y > $yba
tooltip("done",0,0)
$diff2 = timerdiff($time)



GUIctrlsetdata($n3,$count)

$date = @MDAY & "/" & @MON & "/" & @YEAR
$time = @HOUR & "." & @MIN & "." & @SEC
Filewrite ("data.txt", "Date:"& $date & "     Time:" & $time & " size = " & $count & @CR)
Filewrite ("data.txt", $count & @CR)
controlsend("Microsoft Excel - Book1", "", "",$count & @CRLF);depending on which version of windows
controlsend("Book1 - Excel", "", "",$count & @CR)
$count = 0

tooltip("",0,0)
sleep(100)
until _ispressed (31)
endif


	until $msg = $GUI_EVENT_CLOSE

	Func _DwmEnable($WhatToDo)
DllCall("dwmapi.dll", "long", "DwmEnableComposition", "uint", $WhatToDo)
EndFunc