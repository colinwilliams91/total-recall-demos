# Handoff — editing the VHS demo tapes

Target repo: `~/Projects/oss/total-recall-group/total-recall-demos` (branch `master`). Tapes in `tapes/`, helpers in `harness/`, renders (`*.gif` + `.txt`) at repo root. Full render/publish runbook lives in that repo's README ("Release ceremony").

**Key context:** in another worktree the binary was renamed `tr` → `torec` — use `torec` anywhere a tape references the binary (on-camera `Type` commands, `harness/env.sh` PATH/kill patterns, `.git/hooks` baked paths are re-installed by renders).

**How to work:**
- The maintainer's word is the spec. They give UX/visual instructions ("show X, hide Y, slow down here, cut this scene"). Implement them faithfully — do not re-litigate scope, don't substitute "equivalent" behavior. Scene selection, pacing, and framing are theirs to decide.
- Each tape is self-resetting (hides env setup via `harness/env.sh`, re-stages a fresh `scratch-note.md`, kills stale demo daemons). Safe to re-render endlessly.
- Editing kit: `vhs manual` for the command reference; per-tape commit keys must wait for the huh field to settle (`Sleep` after `Wait+Screen`).

**Iterate like this:**
```sh
vhs tapes/demo-a-full-flow.tape          # errors name the failing Wait + show the stuck frame
ffprobe -v error -show_entries format=duration -of csv=p=0 demo-*.gif
sed dump / diff the emitted .txt to debug frames
```

**Never:** `git checkout -- .` / `reset --hard` to tidy mid-iteration (eats edits); run the tape's `tr init` coils with real API keys (dummy `env:TR_DEMO_KEY` only, never exported).

**When done:** bump tag `demos-vN+1`, `gh release create + upload`, swap the tag in the main repo's `README.md` demo URL. One process: `~/Projects/oss/total-recall-group/total-recall-demos/README.md` bottom section.
