dockutil --remove all --no-restart
dockutil --add '/Applications/Pocket.app' --no-restart
dockutil --add '/Applications/Bear.app' --no-restart
dockutil --add '/Applications/Things3.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Macdown.app' --no-restart
dockutil --add '/Applications/Hyper.app' --no-restart
dockutil --add '/Applications/Visual Studio Code.app' --no-restart
dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '' --type spacer --section apps --before Pocket --no-restart
dockutil --add '' --type spacer --section apps --after Bear --no-restart
dockutil --add '' --type spacer --section apps --before Hyper --no-restart
killall Dock