#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include lib\VA.ahk


SetBalance:
    device := VA_GetDevice("playback")
    device_name := ""
    If (device != 0) {
        device_name := VA_GetDeviceName(device)
    }
	
    If ( InStr(device_name, "Realtek", false) || InStr(device_name, "DELL", false) ) {
        Return
    }

    ; Get the master volume of the default playback device.
    curr_vol := VA_GetMasterVolume()

    right_speaker_ratio := 1/2

    ; Get the volume of the first and second channels.
    left_speaker := VA_GetMasterVolume(1)
    right_speaker := VA_GetMasterVolume(2)

	VA_SetMasterVolume(curr_vol*right_speaker_ratio, 2)
return