#!/bin/bash

# Set the display to :0
export DISPLAY=:0

# Start Xvfb (X Virtual Framebuffer)
echo "Starting Xvfb on DISPLAY=:0..."
Xvfb :0 -screen 0 1024x768x24 &

# Start the window manager (Fluxbox)
echo "Starting Fluxbox..."
fluxbox &

# Start the VNC server with password stored
echo "Starting VNC server..."
mkdir -p ~/.vnc
x11vnc -storepasswd my_secure_password ~/.vnc/passwd
x11vnc -auth /root/.Xauthority -forever -usepw -display :0 -bg -quiet -rfbport 5900

# Launch Eclipse IDE
echo "Launching Eclipse IDE..."
cd /opt/eclipse/ || exit
./eclipse &

# Keep container running
wait
