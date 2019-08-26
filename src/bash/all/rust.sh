#!/usr/bin/env bash

# sccache breaks rls so dont export if we are inside my editor
#if [ "${TERM_PROGRAM:-}" != "vscode" ]; then
#  if command_exists sccache; then
#    export RUSTC_WRAPPER=$(which sccache)
#  fi
#fi

