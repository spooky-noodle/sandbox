﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

keyArray := ["F1", "F2", "F3", "F4", "F5"]

i := 0

XButton2::
Send {XButton2}
if (i >= (keyArray.Length)) {
    i := 0
    releaseALLKeys(keyArray)
    Return
} 
else {
    i++
    holdNextKey(i, keyArray)
    Return
}



XButton1::
Send {XButton1}
if (i <= 1) {
    i := 0
    releaseALLKeys(keyArray)
    Return
} 
else {
    i--
    holdNextKey(i, keyArray)
    Return
}

Return

Space::
Send {Space}
if (i > 0) {
    i := 0
    releaseALLKeys(keyArray)
    Return
}
else {
    Return
}

holdNextKey(keyInd, keyArray) {
    releaseKeys(keyInd, keyArray)
    Send % "{" keyArray[keyInd] " down}"
}

releaseKeys(holdKeyInd, keyArray){
    For k, fKey in keyArray {
        if (k != holdKeyInd) {
            Send % "{" fKey " up}"
        }
    }
    Return
}

releaseALLKeys(keyArray){
    For k, fKey in keyArray {
        Send % "{" fKey " up}"
    }
    Return
}

F11::Reload