#!/bin/bash
qdbus org.kde.klipper /klipper org.kde.klipper.klipper.setClipboardContents "$(cat)"
