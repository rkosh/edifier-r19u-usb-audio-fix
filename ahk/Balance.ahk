#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include lib\VA.ahk

global LOOKUP_INTERVAL = 1000 ; Time in milliseconds (lower means frequent changes)
global RIGHT_LEFT_VOLUME_RATIO := 1/2 ; Balance R -----X----- L


SetBalance(){
    device := VA_GetDevice("playback")
    device_name := ""
    If (device != 0) {
        device_name := VA_GetDeviceName(device)
    }

    If ( InStr(device_name, "Realtek", false) || InStr(device_name, "DELL", false) ) {
        Return
    }

    ; Get the master volume of the specified playback device.
    CurrVol := VA_GetMasterVolume()

    ; Get the volume of the first and second channels.
    LSpeaker := VA_GetMasterVolume(1)
    RSpeaker := VA_GetMasterVolume(2)

	VA_SetMasterVolume(CurrVol*RIGHT_LEFT_VOLUME_RATIO, 2)
}

IncreaseVolume(){
    Level := VA_GetMasterVolume()
    VA_SetMasterVolume(Level + 2)
    SetBalance()
}

DecreaseVolume(){
    Level := VA_GetMasterVolume()
    VA_SetMasterVolume(Level - 2)
    SetBalance()
}

SetTimer, setBalance, %LOOKUP_INTERVAL% ; Check for changes after

; Uncomment the following code for realtime volume changes
/*
WheelUp::
Send, {WheelUp}
WinGetActiveTitle, Title
If (Title == "Volume Control") {
    SetBalance()
}
return

WheelDown::
Send, {WheelDown}
WinGetActiveTitle, Title
If (Title == "Volume Control") {
    SetBalance()
}
return

Volume_Up::
IncreaseVolume()
return

Volume_Down::
DecreaseVolume()
return
*/