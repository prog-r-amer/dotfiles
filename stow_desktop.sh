#!/usr/bin/env bash
find -mindepth 1 -maxdepth 1 -not -path "*git" -not -path "*laptop" -type d -printf '%P\n' | xargs stow
