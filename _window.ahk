getMonitorWorkAreaLeft() {
    SysGet, area, MonitorWorkArea
    Return areaLeft
}
getMonitorWorkAreaRight() {
    SysGet, area, MonitorWorkArea
    Return areaRight
}
getMonitorWorkAreaTop() {
    SysGet, area, MonitorWorkArea
    Return areaTop
}
getMonitorWorkAreaBottom() {
    SysGet, area, MonitorWorkArea
    Return areaBottom
}

getMonitorWorkAreaWidth() {
    Return getMonitorWorkAreaRight() - getMonitorWorkAreaLeft()
}
getMonitorWorkAreaHeight() {
    Return getMonitorWorkAreaBottom() - getMonitorWorkAreaTop()
}

windowToPresetPosition(position) {
    rX := 0.9
    adjX := 10
    adjHeight := 10

    width := rX * getMonitorWorkAreaWidth()
    leftPosX := getMonitorWorkAreaLeft() - adjX
    rightPosX := (1 - rX) * getMonitorWorkAreaWidth() + adjX

    WinGetPos, , , , taskBarHeight, ahk_class Shell_TrayWnd
    height := getMonitorWorkAreaHeight() - taskBarHeight + adjHeight
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
        fullWidth := getMonitorWorkAreaWidth() + 2 * adjX
        WinMove A, , %leftPosX%, %posY%, %fullWidth%, %height%
    }
}

;; ==============================================
;; Resize / Move windows
;; ==============================================
