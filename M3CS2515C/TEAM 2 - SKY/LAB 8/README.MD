# Lab Work 8
Access to Hardware
1. Group of 4
2. Create new project using command line 'flutter create Talk2Hardware'.
3. Run the project on the smartphone or AVD.
4. Create Splash Screen, Menu and Second Screen using FlutterFlow.
5. Access to Mobile hardware at least two of the following features: Bluetooth, WiFi-Direct, Wireless Display, GPS, Camera, Microphone, Gyrometer, Accelerometer, Pedometer, NFC, Infrared, 5G, WiFi
6. Speed Code Video + Music.
7. Highlight on YouTube using the timestamps.
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.

# GROUP:
M3CS2515C
AKMAL FARHAN BIN AHMAD ANNUAR (2022660498)

NURUL IFFAH HASYIMAH BINTI HASAN (2022457982)

ZUHAIRAH NURHIDAYAH BINTI ZAINUDIN (2022457722)

NURFADLIYANA 'AQILAH BINTI SULAIMAN (2022824754)


Youtube: https://youtu.be/aJU43Vm2O8E

```
### Accelerometer Code
@override
  void initState() {
    super.initState();

    // Start listening to the accelerometer
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerValues =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });

```
```
### Gyrometer Code
// Start listening to the gyroscope
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeValues =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });
  }

```

```
### Main.dart Code
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}


```
```
### splash_screen.dart Code
import 'dart:async';
import 'package:flutter/material.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }
}

```

```
### second_screen.dart Code
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String accelerometerValues = 'Unknown';
  String gyroscopeValues = 'Unknown';

  @override
  void initState() {
    super.initState();

    // Start listening to the accelerometer
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerValues =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });

    // Start listening to the gyroscope
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeValues =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the second screen!'),
            SizedBox(height: 20),
            Text('Accelerometer Data: $accelerometerValues'),
            SizedBox(height: 20),
            Text('Gyroscope Data: $gyroscopeValues'),
          ],
        ),
      ),
    );
  }
}



```
```
### menu_screen.dart Code
import 'package:flutter/material.dart';
import 'second_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}


```




