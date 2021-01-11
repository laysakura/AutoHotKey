#Include, _windowSizePos.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hot keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#InstallKeybdHook
#UseHook

;----------------------------------------------
; JISキーボードをUSキーボード配列にする
;----------------------------------------------

; 1段目
VKF4::Send,{``}    ;         半角/全角     -> `
+VKF4::Send,{~}    ; Shift + 半角/全角     -> ~
+2::Send,{@}       ; Shift + 2         ["] -> @
+6::Send,{^}       ; Shift + 6         [&] -> ^
+7::Send,{&}       ; Shift + 7         ['] -> &
+8::Send,{*}       ; Shift + 8         [(] -> *
+9::Send,{(}       ; Shift + 9         [)] -> (
+0::Send,{)}       ; Shift + 0         [ ] -> )
+-::Send,{_}       ; Shift + -         [=] -> _
^::Send,{=}        ;                   [^] -> =
+^::Send,{+}       ; Shift + ^         [~] -> +
\::Send,{``}       ; (left of BS)
+\::Send,{~}    ; Shift + (left of BS)

; 2段目
@::[              ;                   [@] -> [
+@::{             ; Shift + @         [`] -> {
[::]              ;                   [[] -> ]
+[::Send,{}}      ; Shift + [         [{] -> }

; 3段目
+;::Send,{:}      ; Shift + ;         [+] -> :
:::Send,{'}       ;                   [:] -> '
*::Send,{"}       ; Shift + :         [*] -> "
+]::|             ; Shift + ]         [}] -> |
]::\              ;                   []] -> \


;----------------------------------------------
; Surface のキーボードがAltキーが右寄りで押し間違えるので、「カタカナひらがな」キーもALtにする
;----------------------------------------------
VKF2::
    SetKeyDelay -1
    Send {Blind}{Alt Down}
    Return
VKF2 up::
    SetKeyDelay -1
    Send {Blind}{Alt Up}
    Return

;----------------------------------------------
; Windowの移動・リサイズ
;----------------------------------------------

+^h::resetWindowSizePosState("left")
+^l::resetWindowSizePosState("right")
+^f::resetWindowSizePosState("center")

+^Left::updateWindowSizePosState("L")
+^Right::updateWindowSizePosState("R")

;----------------------------------------------
; Windowのtoggle
;----------------------------------------------

LCtrl & J::AltTab
LCtrl & K::ShiftAltTab
