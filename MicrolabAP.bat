netsh wlan stop hostednetwork
//net stop SharedAccess
//net stop Wlansvc
//net start Wlansvc
//net start SharedAccess
netsh wlan set hostednetwork mode=allow ssid="MicrolabAP" key="7a8b9c4d5e"
netsh wlan start hostednetwork