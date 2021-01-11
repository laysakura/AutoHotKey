isActiveVSCode() {
    IfWinActive, ahk_exe code.exe
        Return True
    Return False
}

isActiveCmder() {
    ; IfWinActive, ahk_exe cmder.exe ; somehow it doesn't work
    IfWinActive, Cmder
        Return True
    Return False
}

isActiveChrome() {
    IfWinActive, ahk_exe chrome.exe
        Return True
    Return False
}
