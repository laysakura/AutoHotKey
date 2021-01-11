;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; モニタのタスクバーを除いた位置・サイズ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_getMonitorWorkAreaLeft() {
    SysGet, area, MonitorWorkArea
    Return areaLeft
}
_getMonitorWorkAreaRight() {
    SysGet, area, MonitorWorkArea
    Return areaRight
}
_getMonitorWorkAreaTop() {
    SysGet, area, MonitorWorkArea
    Return areaTop
}
_getMonitorWorkAreaBottom() {
    SysGet, area, MonitorWorkArea
    Return areaBottom
}

_getMonitorWorkAreaWidth() {
    Return _getMonitorWorkAreaRight() - _getMonitorWorkAreaLeft()
}
_getMonitorWorkAreaHeight() {
    Return _getMonitorWorkAreaBottom() - _getMonitorWorkAreaTop()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; アクティブなウィンドウのサイズ・位置のステート
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;            +-+                                       +-+
; L (shrink) | |                                       | | L (expand)
;            | v                                       | v
;           [left] <--------- [center] ------------> [right]
;            | ^   R (shrink)           L (shrink)     | ^
; R (expand) | |                                       | | R (shrink)
;            +-+                                       +-+

_window_state := "center"
_window_widthRatio := 1.0  ; [left] , [right] のときだけ有効

resetWindowSizePosState(state) {
    global _window_state, _window_widthRatio

    if (state == "center") {
        _window_state := "center"
        _window_widthRatio := 1.0
    } else if (state == "left") {
        _window_state := "left"
        _window_widthRatio := 0.9
    } else if (state == "right") {
        _window_state := "right"
        _window_widthRatio := 0.9
    }

    _updateWindowSizePos()
}
updateWindowSizePosState(cmd) {
    global _window_state, _window_widthRatio

    if (_window_state == "center") {
        if (cmd == "L") {
            resetWindowSizePosState("left")
        } else if (cmd == "R") {
            resetWindowSizePosState("right")
        }
    } else if ((_window_state == "left" && cmd == "L") || (_window_state == "right" && cmd == "R")) {
        ; shrink
        _window_widthRatio := _window_widthRatio - 0.05
        if (_window_widthRatio < 0.1) {
            _window_widthRatio := 0.1
        }
    } else if ((_window_state == "left" && cmd == "R") || (_window_state == "right" && cmd == "L")) {
        ; expand
        _window_widthRatio := _window_widthRatio + 0.05
        if (_window_widthRatio > 1.0) { 
            _window_widthRatio := 1.0 
        }
    }

    _updateWindowSizePos()
}

_updateWindowSizePos() {
    global _window_state, _window_widthRatio

    if (_window_state == "center") {
        _moveResizeWindow(_getMonitorWorkAreaLeft(), _getMonitorWorkAreaTop(), _getMonitorWorkAreaWidth(), _getMonitorWorkAreaHeight())
    } else if (_window_state == "left") {
        _moveResizeWindow(_getMonitorWorkAreaLeft(), _getMonitorWorkAreaTop(), _getMonitorWorkAreaWidth() * _window_widthRatio, _getMonitorWorkAreaHeight())
    } else if (_window_state == "right") {
        _moveResizeWindow(_getMonitorWorkAreaRight() - _getMonitorWorkAreaWidth() * _window_widthRatio, _getMonitorWorkAreaTop(), _getMonitorWorkAreaWidth() * _window_widthRatio, _getMonitorWorkAreaHeight())
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; アクティブなウィンドウに関する低レベルなウィンドウサイズ・位置関数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_getWindowAreaLeft() {
    WinGetPos, l, t, w, h
    Return l
}
_getWindowAreaRight() {
    WinGetPos, l, t, w, h
    Return l + w
}
_getWindowAreaTop() {
    WinGetPos, l, t, w, h
    Return t
}
_getWindowAreaBottom() {
    WinGetPos, l, t, w, h
    Return t + h
}

_getWindowAreaWidth() {
    WinGetPos, l, t, w, h
    Return w
}
_getWindowAreaHeight() {
    WinGetPos, l, t, w, h
    Return h
}

_moveResizeWindow(left_, top_, width, height) {
    WinMove A, , %left_%, %top_%, %width%, %height%
}
