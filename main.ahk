#Include, _windowSizePos.ahk
#Include, _windowApp.ahk
#Include, _emacs.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hot keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#InstallKeybdHook
#UseHook

;----------------------------------------------
; JISキーボードをUSキーボード配列にする
;----------------------------------------------

; 1段目
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
; 押し間違えやすいキーを無効化
;----------------------------------------------

; カタカナ ひらがな
VKF2::Send,{Alt}

; コンテキストメニュー
VK5D::Send,{Alt}

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

LWin & j::AltTab
LWin & k::ShiftAltTab

;----------------------------------------------
; 仮想デスクトップの移動
;----------------------------------------------

#p::Send,^#{Left}
#n::Send,^#{Right}

;----------------------------------------------
; emacs-like キーバインド
;----------------------------------------------

^x::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    is_pre_x = 1
  Return 
^f::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      If isActiveChrome() {
        is_pre_x = 0
        Send, ^t  ; open tab
      }
      Else
        find_file()
    Else
      forward_char()
  }
  Return  
^c::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_emacs()
  }
  Return  
^d::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    delete_char()
  Return
^h::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return
^k::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return
;; ^o::
;;   If emacs_ignore()
;;     Send %A_ThisHotkey%
;;   Else
;;     open_line()
;;   Return
^g::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    quit()
  Return
;; ^j::
;;   If emacs_ignore()
;;     Send %A_ThisHotkey%
;;   Else
;;     newline_and_indent()
;;   Return
^m::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
^i::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
  Return
^s::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      save_buffer()
    Else
      isearch_forward()
  }
  Return
^r::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
  Return
^w::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    kill_region()
  Return
!w::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    kill_ring_save()
  Return
^y::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
^/::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    undo()
  Return  
  
;$^{Space}::
;^vk20sc039::
^vk20::
  If emacs_ignore()
    Send {CtrlDown}{Space}{CtrlUp}
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^@::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^a::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
^e::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
^p::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    If is_pre_x and isActiveChrome() {
      is_pre_x = 0
      Send, +^{Tab} ; prev tab
    }
    Else
      previous_line()
  Return
^n::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    If is_pre_x and isActiveChrome() {
      is_pre_x = 0
      Send, ^{Tab} ; next tab
    }
    Else
      next_line()
  Return
^b::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    If is_pre_x and isActiveChrome() {
      is_pre_x = 0
      Send, !{Left} ; back
    }
    Else
      backward_char()
  Return
^v::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    scroll_down()
  Return
!v::
  If emacs_ignore()
    Send %A_ThisHotkey%
  Else
    scroll_up()
  Return

k::
  If is_pre_x and isActiveChrome() {
    is_pre_x = 0
    Send, ^w ; close tab
  }
  Else
    Send %A_ThisHotkey%
  Return
r::
  If is_pre_x and isActiveChrome() {
    is_pre_x = 0
    Send, +{F5} ; super reload
  }
  Else
    Send %A_ThisHotkey%
  Return
b::
  If is_pre_x and isActiveChrome() {
    is_pre_x = 0
    Send, +^t ; re-open closed tab
  }
  Else
    Send %A_ThisHotkey%
  Return
