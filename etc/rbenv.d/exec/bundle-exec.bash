function hasGemfile() {
  local dir
  dir="$PWD"
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

if [ -z "$NO_BUNDLE_EXEC" -a "$RBENV_COMMAND" != "bundle" ] && hasBundler && hasGemfile; then
  if [ -n "$DEBUG_RBENV_BUNDLE_EXEC" ]; then
    echo "bundle exec ${@:1}" >&2
  fi

  RBENV_COMMAND="bundle"
  RBENV_COMMAND_PATH="bundle"
  set -- "bundle" "exec" "${@:1}"
fi
