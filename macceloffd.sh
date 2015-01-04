#!/bin/bash

sleep 05
xset m 0
xinput --set-prop 12 "Device Accel Constant Deceleration" 1
xinput --set-prop 12 "Device Accel Velocity Scaling" 1
xinput --set-prop 13 "Device Accel Constant Deceleration" 1
xinput --set-prop 13 "Device Accel Constant Deceleration" 1
exit 0
