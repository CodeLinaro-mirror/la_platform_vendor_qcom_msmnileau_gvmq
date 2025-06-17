# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear

device.internal = 0

touch.deviceType = touchScreen
touch.orientationAware = 1

cursor.mode = navigation
cursor.orientationAware = 1

# This displayID matches the unique ID of the display created for device.
# This will indicate to input flinger than it should link this input device
# with the display.
touch.displayId = local:4630946684447744129

# Allow touches while the screen is off
touch.enableForInactiveViewport = 1

# Tap on the display will wake the device.
touch.wake = 1

