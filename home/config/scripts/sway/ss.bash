#!/usr/bin/env bash
set -euo pipefail

grim -g "$(slurp)" - | curl \
  -H "authorization: $(cat /home/kybe/.config/image-token)" \
  https://i.kybe.xyz/api/upload \
  -F "file=@-;type=image/png" \
| jq -r '.files[0].url' \
| wl-copy
