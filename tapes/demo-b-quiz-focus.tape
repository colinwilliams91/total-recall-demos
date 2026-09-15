# demo-b: quiz focus — commit → recall question → answer → feedback
# starts mid-flow: repo already configured, daemon running (both off-camera)
# approach used: seeded headless daemon — golden-frame shim fallback NOT needed

Output demo-b-quiz-focus.gif
Output demo-b-quiz-focus.txt

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

# setup (off-camera): isolated TR_HOME, daemon, seeded question
Hide
Type ". ./harness/env.sh && clear"
Enter
Wait
Type "tr serve >/dev/null 2>&1 &"
Enter
Sleep 1400ms
Type ". ./harness/seed.sh"
Enter
Wait
Show

# scene: work → commit → recall check pops up
Sleep 600ms
Type "git commit -m 'fix: handle race in cache.Save'"
Enter
Wait+Screen /Total-Recall Check/
Sleep 900ms

# scene: answer
Type "1"
Wait+Screen /Evaluating/
Sleep 400ms
Wait+Screen /Press any key/
Type "x"
Sleep 1200ms

# hold on the final frame
Sleep 1600ms

# cleanup
Hide
Type "kill %1 2>/dev/null"
Enter
Sleep 400ms
