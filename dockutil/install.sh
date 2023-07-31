dockutil --remove all --no-restart
dockutil --add '/Applications/Notion.app' --no-restart
dockutil --add '/Applications/Things3.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Figma.app' --no-restart
dockutil --add '/Applications/Pocket.app' --no-restart
dockutil --add '/Applications/iTerm.app' --no-restart
dockutil --add '/Applications/Visual Studio Code.app' --no-restart
dockutil --add '/Applications/Linear.app' --no-restart
dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '' --type spacer --section apps --before Notion --no-restart
dockutil --add '' --type spacer --section apps --before iTerm --no-restart
killall Dock