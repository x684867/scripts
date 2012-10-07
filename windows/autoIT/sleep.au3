; Sleep Utility
; (c) 2012 Sam Caldwell.  Public Domain
;
; SOURCE:	   sleep.au3
;
; AutoIt Version: 3.0
;
; This file provides a sleep utility for 
; Windows.
;
;
;

$interval=0

If $CmdLine[0] < 1 Then
   msgbox(1,"Error","Missing interval.  USAGE: sleep [interval]")
   exit 
Else
   $interval=int($CmdLine[1])
   if $interval > 0 then sleep($interval)
Endif