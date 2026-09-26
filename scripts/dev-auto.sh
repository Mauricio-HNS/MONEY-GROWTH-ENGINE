#!/usr/bin/env bash
set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

BRANCH="${MGE_BRANCH:-main}"
INTERVAL="${MGE_INTERVAL:-10}"
FLUTTER_DIR="$REPO_ROOT/flutter_app"

echo ""
echo "MONEY GROWTH ENGINE — DEV AUTO SYNC"
echo "GitHub → VS Code → Flutter Emulator"
echo "Branch: $BRANCH | Check: ${INTERVAL}s"
echo ""

git fetch origin "$BRANCH"

cd "$FLUTTER_DIR"

echo "[MGE] Starting Flutter..."
flutter run -d "${MGE_DEVICE:-iPhone 17}" &
FLUTTER_PID=$!

cleanup() {
  echo ""
  echo "[MGE] Stopping..."
  kill "$FLUTTER_PID" 2>/dev/null || true
}
trap cleanup INT TERM EXIT

LAST_REMOTE="$(git -C "$REPO_ROOT" rev-parse "origin/$BRANCH")"

while kill -0 "$FLUTTER_PID" 2>/dev/null; do
  sleep "$INTERVAL"

  git -C "$REPO_ROOT" fetch origin "$BRANCH" >/dev/null 2>&1 || continue
  CURRENT_REMOTE="$(git -C "$REPO_ROOT" rev-parse "origin/$BRANCH")"

  if [ "$CURRENT_REMOTE" = "$LAST_REMOTE" ]; then
    continue
  fi

  echo ""
  echo "[MGE] New GitHub commit detected: $CURRENT_REMOTE"
  echo "[MGE] Syncing VS Code workspace..."

  if ! git -C "$REPO_ROOT" diff --quiet && ! git -C "$REPO_ROOT" diff --cached --quiet; then
    echo "[MGE] Local changes detected. Skipping pull to protect your work."
    LAST_REMOTE="$CURRENT_REMOTE"
    continue
  fi

  if ! git -C "$REPO_ROOT" pull --ff-only origin "$BRANCH"; then
    echo "[MGE] Pull failed. Resolve the local Git state before continuing."
    LAST_REMOTE="$CURRENT_REMOTE"
    continue
  fi

  CHANGED="$(git -C "$REPO_ROOT" diff --name-only HEAD@{1} HEAD 2>/dev/null || true)"

  NEED_RESTART=0
  if echo "$CHANGED" | grep -Eq '(^|/)(pubspec\.yaml|pubspec\.lock)$|(^|/)(ios|android|macos|windows|linux|web)/|\.xcconfig$'; then
    NEED_RESTART=1
  fi

  if [ "$NEED_RESTART" -eq 1 ]; then
    echo "[MGE] Native/dependency change detected → Hot Restart (R)"
    printf 'R' > /dev/tty 2>/dev/null || true
  else
    echo "[MGE] Dart/UI change detected → Hot Reload (r)"
    printf 'r' > /dev/tty 2>/dev/null || true
  fi

  LAST_REMOTE="$CURRENT_REMOTE"
  echo "[MGE] Emulator sync requested."
done
