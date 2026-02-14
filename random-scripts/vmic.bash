#!/usr/bin/env bash
pactl load-module module-null-sink sink_name=VirtualMic sink_properties=device.description=VirtualMic
pactl load-module module-remap-source master=VirtualMic.monitor source_name=VirtualMicMic source_properties=device.description="VirtualMicMic"
