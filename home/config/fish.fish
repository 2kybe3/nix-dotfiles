fish_vi_key_bindings

function fish_greeting
    echo (set_color brgreen)"$USER"(set_color normal)"@"(hostname)" "(set_color red)(date +%T)(set_color normal)" "(set_color cyan)(uname -s) (uname -r)
end

if ! pgrep -u "$USER" ssh-agent > /dev/null;
  eval "$(ssh-agent -s)"
end

if ! ssh-add -l | grep -q "SHA256:bc7E9tLPDWpad1A9/XBswtUUskgN7m5xdbWH1omZ71I";
  ssh-add ~/.ssh/kybe
end
