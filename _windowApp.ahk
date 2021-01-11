isActiveVSCode() {
    IfWinActive, ahk_exe code.exe
        Return True
    Return False
}

isActiveChrome() {
    IfWinActive, ahk_exe chrome.exe
        Return True
    Return False
}
