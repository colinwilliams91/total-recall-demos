# demo-a: full flow — install → init → serve → commit → recall quiz
# (doubles as the render-time reference for the other variants' shared profile)

Output demo-a-full-flow.gif
Output demo-a-full-flow.txt

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
Set PlaybackSpeed 1.1

Require git
Require go

# ── setup (off-camera) ──
Hide
Type ". ./harness/env.sh && clear"
Enter
Wait                       # prompt back: env ready
Type "tr serve >/dev/null 2>&1 &"
Enter
Sleep 1400ms
Show

# ── install ──
Type "go install github.com/colinwilliams91/total-recall/cmd/tr@latest"
Enter
Hide
Wait                       # hidden: wait for install to finish
Show
Type "tr --version"
Enter
Wait
Sleep 600ms

# ── init (real huh forms) ──
Type "tr init"
Enter
Wait+Screen /conversation analysis/
Sleep 800ms
Left
Enter
Wait+Screen /AI Provider/
Sleep 600ms
Enter
Wait+Screen /API Key/
Sleep 400ms
Backspace 22
Type "env:TR_DEMO_KEY"
Tab
Enter
Wait
Sleep 1000ms

# ── hooks in this repo ──
Sleep 600ms
Type "tr repo"
Enter
Wait+Screen /recall check on every commit/
Sleep 500ms
Enter
Sleep 500ms
Enter
Sleep 500ms
Enter
Sleep 500ms
Enter
Wait
Sleep 900ms

# ── daemon live ──
Type "tr status"
Enter
Wait
Sleep 900ms

# ── commit → recall question ──
Hide
Type ". ./harness/seed.sh && clear"
Enter
Wait
Show
Sleep 400ms
Type "git commit -m 'feat: exponential backoff note'"
Enter
Wait+Screen /Total-Recall Check/
Sleep 800ms
Type "1"
Wait+Screen /Evaluating/
Sleep 400ms
Wait+Screen /Press any key/
Type "x"
Sleep 1200ms

# hold on the final frame
Sleep 1400ms

# cleanup
Hide
Type "kill %1 2>/dev/null"
Enter
Sleep 400ms
