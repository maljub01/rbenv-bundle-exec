function hasGemfile() {
  local dir="$PWD"
  while [ -n "$dir" ]; do
    if [ -f "$dir/Gemfile" ]; then
      return 0
    fi
    dir="${dir%/*}"
  done

  return 1
}

function hasBundler() {
  rbenv-which bundle > /dev/null 2>&1
}

function commandIgnored() {
  if [ "$RBENV_COMMAND" = "gem" ]; then return 0; fi

  if [ -f "$HOME/.no_bundle_exec" ]; then
    for cmd in `cat "$HOME/.no_bundle_exec"`; do
      if [ "$RBENV_COMMAND" = "$cmd" ]; then
        return 0
      fi
    done
  fi

  return 1
}

if [ -z "$NO_BUNDLE_EXEC" -a "$RBENV_COMMAND" != "bundle" ] && hasBundler && hasGemfile && ! commandIgnored; then
  if [ -n "$DEBUG_RBENV_BUNDLE_EXEC" ]; then
    echo "bundle exec ${@:1}" >&2
  fi

  RBENV_COMMAND="bundle"
  RBENV_COMMAND_PATH="bundle"
  set -- "bundle" "exec" "${@:1}"
fi
