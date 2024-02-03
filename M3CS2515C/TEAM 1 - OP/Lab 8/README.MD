# M3CS2515C:
- MUHAMMAD KHAIRUL ARIFFIN (2022821444)
- MUHAMMAD AIMAN NABIL (2022800658)
- RUSYDAN FAWWAZ (2022855926)
- AFIQ AIMAN (2022856056)

https://github.com/ipinzr/hwtestandroid.git

Speedcode Video
(https://img.youtube.com/vi/pZk2Zerc8yE/maxresdefault.jpg)](https://www.youtube.com/watch?v=pZk2Zerc8yE
)


Hardware sensor
```
void initState() {
    super.initState();
    // Get location data
    getLocation();
    // Listen to accelerometer sensor
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerValues = [event.x, event.y, event.z];
      });
    });

    // Listen to gyroscope sensor
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeValues = [event.x, event.y, event.z];
      });
    });

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }
