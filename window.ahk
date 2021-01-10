#InstallKeybdHook
#UseHook

;; ==============================================
;; Resize / Move windows
;; ==============================================

halfMaximizeToSide(position) {
    rX := 0.9
    adjX := 10
    adjHeight := 10

    width := rX * A_ScreenWidth
    leftPosX := - adjX
    rightPosX := (1 - rX) * A_ScreenWidth + adjX

    WinGetPos, , , , taskBarHeight, ahk_class Shell_TrayWnd
    height := A_ScreenHeight - taskBarHeight + adjHeight
    posY := taskBarHeight

    if (position == "l")
    {
        WinMove A, , %leftPosX%, %posY%, %width%, %height%
    }
    else if (position == "r")
    {
        WinMove A, , %rightPosX%, %posY%, %width%, %height%
    }
    else if (position == "f")
    {
        fullWidth := A_ScreenWidth + 2 * adjX
        WinMove A, , %leftPosX%, %posY%, %fullWidth%, %height%
    }
}

+^h::
    halfMaximizeToSide("l")
    Return
+^l::
    halfMaximizeToSide("r")
    Return
+^f::
    halfMaximizeToSide("f")
    Return
