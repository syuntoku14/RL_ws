# vnc will show up on localhost:5900

export DISPLAY=:0
Xvfb :0 -screen 0 1400x900x24 &
x11vnc -display :0 -passwd pass -forever &
icewm-session &