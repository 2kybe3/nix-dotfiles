#!/usr/bin/env bash

maim --select | curl \
  -H "authorization: $(cat /run/secrets/image-token)" \
  https://i.kybe.xyz/api/upload \
  -F "file=@-;type=image/png" \
  -H "content-type: multipart/form-data" \
| jq -r .files[0].url \
| xclip -selection clipboard
