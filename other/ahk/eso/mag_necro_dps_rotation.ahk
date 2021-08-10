﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%/pics  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetKeyDelay, 200, 
#maxThreadsPerHotkey, 2

toggle := false
global shades := 30

wait_for(image_name = ""){ ; Waits for an image to be present on screen, loops until the image appears
    global shades
    loop {
        ImageSearch, image_x, image_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % "*" shades " " image_name
        Sleep 50
    } until ErrorLevel = 0
}

check(image_name = ""){
    global shades
    ImageSearch, image_x, image_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % "*" shades " " image_name
    Return (ErrorLevel == 0)
}

swap(){
    Send -
    Sleep 900
}

activate_ability(key_to_press = 0){
    Send %key_to_press%
}

weave(key_to_press = 0){
    Click
    activate_ability(key_to_press)
}

mage(pre_buff = false){
    if (!(check("mage_icon.png")) or check("mage_icon_1.png") or check("mage_icon_0.png")){
        if (!check("mage.png")){
            swap()
        }
        if (pre_buff){
            activate_ability(4)
        }
        else {
            weave(4)
        }
        Return True
    }
    Return false
}

minor_force(pre_buff = false){
    if (!check("force_icon.png") or check("force_icon_1.png") or check("force_icon_0.png")){
        if (!check("trap.png")){
            swap()
        }
        if (pre_buff){
            activate_ability(3)
        }
        else {
            weave(3)
        }
        Sleep 100
        Click
        Return True
    }
    Return false
}

degen(){
    if (!check("degen_icon.png") or check("degen_icon_1.png") or check("degen_icon_0.png")){
        if (!(check("degen.png") or check("degen_dim.png"))){
            swap()
        }
        if (check("degen_dim.png")){
            wait_for("degen.png")
        }
        weave(2)
        Return True
    }
    Return false
}

blastbones(pre_buff = false){
    if (!(check("blastbones_ready.png") or check("blastbones_disabled.png"))){
        swap()
    }
    if (check("blastbones_disabled.png")){
        wait_for("blastbones_ready.png")
    }
    if (pre_buff){
        activate_ability(4)
    }
    else {
        weave(4)
    }
}

siphon(){
    if (!check("siphon_icon.png") or check("siphon_icon_1.png") or check("siphon_icon_0.png")){
        if (!(check("siphon_ready.png") or check("siphon_dim.png"))){
            swap()
        }
        if (check("siphon_dim.png")){
            wait_for("siphon_ready.png")
        }
        weave(3)
        Return True
    }
    Return false
}

mystic_orb(pre_buff = false){
    if (!check("mystic_orb.png")){
        swap()
    }
    if (pre_buff){
        activate_ability(2)
    }
    else {
        weave(2)
    }
}

wall(){
    if (!check("unstable_wall.png")){
        swap()
    }
    weave(1)
}

boneyard(){
    if (!check("unnerving_boneyard.png")){
        swap()
    }
    weave(1)
    Sleep 100
    Click
}

rune(){
    if (!check("rune.png")){
        swap()
    }
    weave(5)
    Sleep 100
    Click
}

goliath(){
    if (check("goliath_ready.png")){
        weave("R")
        Sleep 100
        Click
        Return True
    }
    Return False
}

flex(){
    if (!(goliath() or mage() or minor_force() siphon() or degen())){
        rune()
    }
}

static_rotation(){
    if (WinActive("ahk_exe eso64.exe")){
        blastbones()
        swap()
        boneyard()
        Sleep 900
        wall()
        swap()
        blastbones()
        siphon()
        swap()
        mystic_orb()
        ; swap()
        ; blastbones()
        ; minor_force()
        ; rune()
        ; swap()
        ; blastbones()
        ; degen()
        ; mage()
    }
    else {
        Send 6
    }
}

dynamic_rotation(){
    if (WinActive("ahk_exe eso64.exe")){
        wall()
        swap()
        blastbones()
        Sleep 900
        boneyard()
        swap()
        mystic_orb()
        swap()
        Sleep 100
        blastbones()
        flex()
        flex()
        blastbones()
        flex()
    }
}

pre_buff(){
    if (WinActive("ahk_exe eso64.exe")){
        mage(True)
        swap()
        blastbones(True)
        swap()
        mystic_orb(True)
        goliath()
    }
}

#UseHook, On
6::
toggle := !toggle
while (toggle){
    dynamic_rotation()
}
Return

7::pre_buff()

F11::Reload  ; Ctrl+Alt+R