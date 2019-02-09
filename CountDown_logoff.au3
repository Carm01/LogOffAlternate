#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Swoosh.ico
#AutoIt3Wrapper_Outfile_x64=LogOff.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=NULL
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>
#include <Date.au3>
$fReboot = True

$Form1 = GUICreate("GrassHopper Says", 362, 128, -1, -1, BitOR($WS_POPUP, $WS_BORDER, $WS_CAPTION), $WS_EX_TOPMOST)
GUISetBkColor($COLOR_SKYBLUE)
GUISetFont(9, 700, 1, 'Tahoma')
$Label1 = GUICtrlCreateLabel("Hello " & @UserName & ".  You have choosen to log off. Please press the LogOff button or Cancel if not.", 15, 10, 327, 45)
GUISetFont(9, 400, 1, 'Tahoma')
$Button1 = GUICtrlCreateButton("LogOff (60)", 64, 85, 75, 25)
$Button2 = GUICtrlCreateButton("Cancel", 200, 85, 75, 25)

GUISetState(@SW_SHOW)

$iSec = @SEC
$iCount = 60

While 1

	If @SEC <> $iSec Then
		$iSec = @SEC
		$iCount -= 1
		If Not $iCount Then
			ExitLoop ; Exit if counter reaches 0
		EndIf
		GUICtrlSetData($Button1, "LogOff (" & ($iCount) & ")") ; Refreshes the Button 1 caption to display the countdown
		;Sleep(10)                                              ; Not needed with a GUIGetMsg in the loop
	EndIf

	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $Button1
			ExitLoop
		Case $Button2
			$fReboot = False
			FileWriteLine('C:\Program Files\logoff\logreccord', @UserName & '-' & 'Cancelled' & '-' &  _Now())
			ExitLoop
	EndSwitch
WEnd

GUIDelete($Form1)

If $fReboot Then
	FileWriteLine('C:\Program Files\logoff\logreccord', @UserName & '-' & 'LOgged Off' & '-' & _Now())
	$CMD1 = "shutdown /l /f"
	RunWait('"' & @ComSpec & '" /c ' & $CMD1, @SystemDir, @SW_HIDE)
Else
	;MsgBox(0,"", "HI")
EndIf
