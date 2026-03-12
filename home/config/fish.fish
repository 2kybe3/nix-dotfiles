function fish_greeting
end

if ! pgrep -u "$USER" ssh-agent > /dev/null;
  eval "$(ssh-agent -s)"
end

if ! ssh-add -l | grep -q "SHA256:bc7E9tLPDWpad1A9/XBswtUUskgN7m5xdbWH1omZ71I";
  ssh-add ~/.ssh/kybe
end
