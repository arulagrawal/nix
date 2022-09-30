#!/bin/sh
find . -name '*.nix' -print0 | xargs -r0 nixfmt