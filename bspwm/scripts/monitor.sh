#!/bin/bash

# this script setups the monitors workspaces, setup
# correctly the environment variables to correct working

# env variables
# get with xrandr
EXTERNAL_MONITOR_NAME="HDMI-0" # e.g: Your monitor that are connected sometimes to your laptop
ONLY_ONE_MONITOR_NAME="eDP-1-1" # e.g: Laptop monitor name
MONITOR_ORDER="HDMI-0 eDP-1-1" # blank to default order, defines the order of the workspaces for the monitors

# getting the monitor
connected_monitors=$(xrandr | grep -w 'connected' | cut -d ' ' -f 2 | wc -l)

if [[ $connected_monitors > 1 ]]; then
  monitor="$EXTERNAL_MONITOR_NAME"
else
  monitor="$ONLY_ONE_MONITOR_NAME"
fi

# assign the workspaces with bspc
assign_workspaces () {
  bspc monitor $monitor -d 1 2 3
  if [[ $monitor == "$EXTERNAL_MONITOR_NAME" ]]; then
    bspc monitor $ONLY_ONE_MONITOR_NAME -d 4 5
  fi
  if [[ $MONITOR_ORDER != "" ]]; then
    bspc wm -O $MONITOR_ORDER
  fi
}

assign_workspaces
