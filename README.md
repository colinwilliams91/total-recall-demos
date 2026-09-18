# total-recall-demos

VHS tapes and rendered demos for [total-recall](https://github.com/colinwilliams91/total-recall)'s `tr` TUI. Rendered GIFs are published as [GitHub Releases](https://github.com/colinwilliams91/total-recall-demos/releases) assets; the main repo's README links to them.

This repo doubles as the scratch project the recorded sessions operate on — the demo lives in the very repo it demos.

## Layout

```
tapes/     .tape sources (three demo variants)
harness/   environment helpers: isolated TR_HOME, dummy provider key, seeded headless daemon
*.gif/txt  rendered outputs (committed at root; .txt is the diffable ASCII view)
```

## Re-render

Maintainer-owned. Re-record when the main repo's UX visibly changes — breaking golden tests (`TestGolden*` in `cmd/tr/testdata/`) is the signal a demo has gone stale.

```sh
# Local (needs vhs, ttyd, ffmpeg on PATH)
vhs tapes/demo-a-full-flow.tape

# Docker fallback (dependencies included)
docker run --rm -v "$PWD":/vhs ghcr.io/charmbracelet/vhs tapes/demo-a-full-flow.tape
```

The tapes assume a freshly built `tr` binary at `bin/tr`:

```sh
go install github.com/colinwilliams91/total-recall/cmd/tr@latest && mkdir -p bin && mv "$(command -v tr)" bin/tr  # or build from the main repo: go build -o bin/tr ./cmd/tr
```

Then render all variants and publish a release (attach the `.gif` assets, tag `demos-vN`).

## Release ceremony

Condensed operator loop — render, commit, release, link. Branch is always `master` here; conventional commits; no automated CI.

### 1. Render + verify (per tape, iterate cheaply)

```sh
# prerequisite for tapes that show the binary (demo-a): build it into bin/
cd ../total-recall-wt-chore && go build -o ../total-recall-demos/bin/tr ./cmd/tr   # or: go install .../cmd/tr@latest

cd ../total-recall-demos
vhs tapes/demo-a-full-flow.tape                                  # ~1 min; failures point at the offending Wait
ffprobe -v error -show_entries format=duration -of csv=p=0 demo-a-full-flow.gif   # target ≤ ~25s
```

Eyeball/debug against the emitted `demo-name.txt` (ASCII frame dump), not by re-watching the GIF. Renders are re-runnable at any time — `harness/env.sh` wipes state and kills stray `bin/tr` daemons on every run.

Tuning knobs, top of each tape: `Set PlaybackSpeed`, `Set TypingSpeed`, `Sleep` beats between commands. `Wait` variants: bare `Wait` = wait for prompt return; `Wait+Screen /regex/` = wait for a TUI frame (alt-screen and huh forms need this; `Wait+Line` matches only the last terminal line).

### 2. Commit + release (this repo)

```sh
git add -A && git commit -m "feat: retune demo tapes"   # clips scratch-note.md era from render runs too — fine
git push                                                  # master

V=demos-vN+1                                              # bump the tag on every publish; keep filenames stable
git tag $V && git push origin $V
gh release create $V --title "$V" --notes "<one line per variant>"
gh release upload $V demo-a-full-flow.gif demo-b-quiz-focus.gif demo-c-init-focus.gif
gh release view $V --json assets -q '.assets[].url'      # asset URLs — same-host-per-release, stable
```

Notes:
- This repo carries real total-recall hooks (installed on camera by the `tr repo` scene). A manual commit without a daemon on 7331 prints `[total-recall] Daemon not running…` and exits 0 — harmless noise; `rm .git/hooks/post-commit .git/hooks/pre-commit` if it bothers you (**they are reinstalled by renders**).
- Don't `git checkout -- .` / `reset --hard` to tidy up mid-iteration — it eats tape edits and harness helpers. Failed renders leave `*.gif/.txt` untracked at worst.

### 3. Point the main repo at the render

```sh
cd ../total-recall     # main repo
```

In `README.md`, exactly one line changes — the release tag in the demo URL (the filename/width stay the same):

```markdown
<img src="https://github.com/colinwilliams91/total-recall-demos/releases/download/demos-vN+1/demo-a-full-flow.gif" alt="…" width="800"/>
```

Swap the filename too if you changed which variant the landing page shows. `docs/CONTRIBUTING.md`'s demos note needs no edit.

### 4. Validate

```sh
curl -sL -o /dev/null -w '%{http_code}\n' "https://github.com/colinwilliams91/total-recall-demos/releases/download/demos-vN+1/demo-a-full-flow.gif"   # expect 200
```

Then push `main` — GitHub renders the GIF as the first visual below the badges. `go build ./... && go test ./...` in the main repo stays untouched by this work; only run it if you edited anything else there.
