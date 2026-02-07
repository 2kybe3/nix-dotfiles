#!/usr/bin/env bash
set -euo pipefail

url="${1:?Missing URL}"
credentialFile="${2:?Missing credentialFile}"

grim -g "$(slurp)" - | curl \
  -H "authorization: $(cat ${credentialFile})" \
  ${url} \
  -F "file=@-;type=image/png" \
| jq -r '.files[0].url' \
| wl-copy
