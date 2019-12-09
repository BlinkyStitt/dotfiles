#!/usr/bin/env bash

# sccache breaks rls so dont export if we are inside my editor
if [ "${TERM_PROGRAM:-}" != "vscode" ]; then
  #echo "TERM_PROGRAM: ${TERM_PROGRAM}"
  if command_exists sccache; then
    export RUSTC_WRAPPER=$(which sccache)
    #echo "RUSTC_WRAPPER: ${RUSTC_WRAPPER}"
  fi
fi
