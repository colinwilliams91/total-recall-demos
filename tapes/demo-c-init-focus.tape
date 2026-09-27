# demo-c: init focus — real `tr init` huh forms → hooks → status
# the "getting started is easy" cut

Output demo-c-init-focus.gif
Output demo-c-init-focus.txt

Set Shell bash
Set FontSize 20
Set Width 1000
Set Height 640
Set Theme "TokyoNight"
Set WindowBar Colorful
Set BorderRadius 10
Set Margin 16
Set MarginFill "#1a1b26"
Set CursorBlink false
Set TypingSpeed 60ms
Set PlaybackSpeed 1.15

Require git

# setup (off-camera): isolated TR_HOME (no daemon yet — status shows "not running" briefly)
Hide
Type ". ./harness/env.sh && clear"
Enter
Wait
Show

# scene: init — provider, env-safe key, model (real huh forms)
Sleep 500ms
Type "torec init"
Enter
Wait+Screen /conversation analysis/
Sleep 900ms
Left
Enter
Wait+Screen /AI Provider/
Sleep 700ms
Enter
Wait+Screen /API Key/
Sleep 500ms
Backspace 22
Type "env:TR_DEMO_KEY"
Tab
Enter
Wait
Sleep 1100ms

# scene: hooks (one confirm form, real TUI)
Type "torec repo"
Enter
Wait+Screen /recall check on every commit/
Sleep 600ms
Enter
Sleep 600ms
Enter
Sleep 600ms
Enter
Sleep 600ms
Enter
Wait
Sleep 900ms

# scene: daemon + resolved config
Show
Type "torec serve"
Sleep 700ms
Hide
Type " >/dev/null 2>&1 &"  # finish off-camera: daemon boots, job notice hidden
Enter
Sleep 1400ms
Type "clear"               # wipe redirects + job PID from the visible screen
Enter
Sleep 400ms
Show
Sleep 400ms
Type "torec status"
Enter
Wait
Sleep 1600ms

# hold on the final frame
Sleep 1500ms

# cleanup
Hide
Type "kill %1 2>/dev/null"
Enter
Sleep 400ms
