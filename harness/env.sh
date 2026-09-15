#!/bin/sh
# Sourced by the tapes (hidden off-camera).
# Wipes and creates an isolated TR_HOME so renders never touch a real setup,
# puts bin/tr first on PATH, and pre-seeds a minimal user config so variants
# focused on the quiz flow can skip init.
set -e
# Tapes run with the demo repo as the working directory.
DEMO_ROOT="$(pwd)"

rm -rf "$DEMO_ROOT/.tmp-tr-home"
mkdir -p "$DEMO_ROOT/.tmp-tr-home"
export TR_HOME="$DEMO_ROOT/.tmp-tr-home"
export PATH="$DEMO_ROOT/bin:$PATH"

tr config set ai.provider anthropic >/dev/null 2>&1 || true
if [ ! -f "$TR_HOME/config.yaml" ]; then
  mkdir -p "$TR_HOME"
  printf 'ai:\n  provider: anthropic\n  model: claude-sonnet-4-5\n  api_key: env:TR_DEMO_KEY\n' > "$TR_HOME/config.yaml"
fi
