#!/bin/bash
i3-msg "workspace 1; append_layout /home/cody/.config/i3/web-dev-layout.json"
i3-msg "workspace 1; exec alacritty"
i3-msg "workspace 1; exec google-chrome-stable --new-window http://localhost:3000"
