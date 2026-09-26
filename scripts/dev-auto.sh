#!/usr/bin/env bash
set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FLUTTER_DIR="$REPO_ROOT/flutter_app"
BRANCH="${MGE_BRANCH:-main}"
INTERVAL="${MGE_INTERVAL:-5}"
DEVICE="${MGE_DEVICE:-iPhone 17}"
PIPE="$REPO_ROOT/.mge-flutter-input"

cleanup() {
  echo ""
  echo "[MGE] Stopping..."
  if [ -n "${FLUTTER_PID:-}" ] && kill -0 "$FLUTTER_PID" 2>/dev/null; then
    kill "$FLUTTER_PID" 2>/dev/null || true
  fi
  rm -f "$PIPE"
}
trap cleanup INT TERM EXIT

cd "$REPO_ROOT"

echo "=============================================="
echo " MONEY GROWTH ENGINE - AUTO DEV MODE"
echo "=============================================="
echo "Repo: $REPO_ROOT"
echo "Flutter: $FLUTTER_DIR"
echo "Device: $DEVICE"
echo "Verificação: ${INTERVAL}s"
echo ""

echo "[MGE] Fetch inicial..."
git fetch origin "$BRANCH" || exit 1

if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git status --porcelain)" ]; then
  echo "[MGE] ERRO: existem alterações locais."
  echo "[MGE] Faça commit ou stash antes de iniciar o AUTO DEV MODE."
  git status --short
  exit 1
fi

git pull --ff-only origin "$BRANCH" || exit 1

rm -f "$PIPE"
mkfifo "$PIPE"

cd "$FLUTTER_DIR"

echo "[MGE] Iniciando Flutter..."
flutter run -d "$DEVICE" < "$PIPE" &
FLUTTER_PID=$!

# Keep a writer open so Flutter does not receive EOF while the watcher sleeps.
exec 9>"$PIPE"

cd "$REPO_ROOT"
LAST_REMOTE="$(git rev-parse "origin/$BRANCH")"

echo ""
echo "[MGE] Flutter iniciado."
echo "[MGE] GitHub -> VS Code -> Emulator ativo."
echo "[MGE] Ctrl+C encerra o modo automático."
echo ""

while kill -0 "$FLUTTER_PID" 2>/dev/null; do
  sleep "$INTERVAL"

  git fetch origin "$BRANCH" >/dev/null 2>&1 || continue
  CURRENT_REMOTE="$(git rev-parse "origin/$BRANCH")"

  if [ "$CURRENT_REMOTE" = "$LAST_REMOTE" ]; then
    continue
  fi

  echo ""
  echo "[MGE] NOVO COMMIT DETECTADO"
  echo "Local : $LAST_REMOTE"
  echo "GitHub: $CURRENT_REMOTE"

  if [ -n "$(git status --porcelain)" ]; then
    echo "[MGE] ERRO: alterações locais detectadas."
    echo "[MGE] Pull ignorado para não sobrescrever trabalho local."
    git status --short
    LAST_REMOTE="$CURRENT_REMOTE"
    continue
  fi

  BEFORE="$LAST_REMOTE"

  if ! git pull --ff-only origin "$BRANCH"; then
    echo "[MGE] ERRO: pull não pôde ser aplicado."
    LAST_REMOTE="$CURRENT_REMOTE"
    continue
  fi

  CHANGED="$(git diff --name-only "$BEFORE" "$CURRENT_REMOTE" 2>/dev/null || true)"

  NEED_RESTART=0
  if echo "$CHANGED" | grep -Eq '(^|/)(pubspec\.yaml|pubspec\.lock)$|(^|/)(ios|android|macos|windows|linux|web)/|\.xcconfig$|\.podspec$'; then
    NEED_RESTART=1
  fi

  if [ "$NEED_RESTART" -eq 1 ]; then
    echo "[MGE] Dependência/plataforma alterada -> enviando R (Hot Restart)"
    printf 'R' >&9
  else
    echo "[MGE] Código Dart/UI alterado -> enviando r (Hot Reload)"
    printf 'r' >&9
  fi

  LAST_REMOTE="$CURRENT_REMOTE"
  echo "[MGE] Emulator sincronizado."
done

wait "$FLUTTER_PID" 2>/dev/null || true
