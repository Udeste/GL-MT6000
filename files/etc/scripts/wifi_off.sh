#!/bin/sh

# Lower TX power on 2.4Ghz
uci set wireless.radio0.txpower='15'

# Disable 5Ghz
uci set wireless.radio1.disabled=1
uci set wireless.default_radio1.disabled=1
uci commit wireless
wifi reload
