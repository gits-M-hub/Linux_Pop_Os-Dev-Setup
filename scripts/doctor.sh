#!/usr/bin/env bash

echo "=== Linux Dev Setup Doctor ==="
echo

tools=(
  git
  docker
  java
  kotlinc
  gradle
  code
  lazygit
  yazi
)

for tool in "${tools[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "✓ $tool"
  else
    echo "✗ $tool"
  fi
done

