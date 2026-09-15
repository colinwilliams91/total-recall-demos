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
