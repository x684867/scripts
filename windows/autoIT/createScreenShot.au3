; screenShot.au3 (compiles to screenShot.exe)
;
; (c) 2012 Sam Caldwell.  Public Domain.
;
; This file provides a utility for capturing a 
; screenshot of the current display.
;
; USAGE:
; 		screenShot.exe 
;
#include 
#include 
#include 

if $cmdLine[0] < 1 Then
   ConsoleWrite("Missing argument.  Expect filename")
   Exit
EndIf

dim $filename=$cmdLine[1]   
if FileExists($filename) then FileDelete($filename)
_ScreenCapture_Capture($filename)
return $filename
