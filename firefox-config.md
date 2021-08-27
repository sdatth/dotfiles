# firefox-config

ref links
- Basic configuration [https://www.youtube.com/watch?v=NH4DdXC0RFw]("https://www.youtube.com/watch?v=NH4DdXC0RFw")
- Advanced configuration [https://www.youtube.com/watch?v=uYoJ7U0OMCY]("https://www.youtube.com/watch?v=uYoJ7U0OMCY")
- Article [link here]("https://sunknudsen.com/privacy-guides/how-to-mitigate-fingerprinting-and-ip-leaks-using-firefox-advanced-preferences")

<br>

## in "about:config" section make the necessary changes
```
beacon.enabled = false
dom.battery.enabled = false
dom.event.clipboardevents.enabled = false
geo.enabled = false
media.eme.enabled = false
media.navigator.enabled = false
media.peerconnection.enabled = false
network.dns.disablePrefetch = true
network.http.sendRefererHeader = 0
network.prefetch-next = false
privacy.firstparty.isolate = true
privacy.resistFingerprinting = true
privacy.trackingprotection.enabled = true
webgl.disabled =  true
```

<br>
