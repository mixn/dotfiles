dockutil --remove all --no-restart
dockutil --add '/Applications/Things3.app' --no-restart
dockutil --add '/Applications/Notion.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Figma.app' --no-restart
dockutil --add '/Applications/iTerm.app' --no-restart
dockutil --add '/Applications/Linear.app' --no-restart
dockutil --add '/Applications/Cursor.app' --no-restart
dockutil --add '/Applications/Arc.app' --no-restart
dockutil --add '' --type spacer --section apps --before Things3 --no-restart
dockutil --add '' --type spacer --section apps --before iTerm --no-restart
killall Dock
