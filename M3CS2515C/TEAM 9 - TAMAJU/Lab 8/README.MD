# Lab Work 8

## Access to Hardware

1. Group of 3
2. Create new project using command line 'flutter create Talk2Hardware'.
3. Run the project on the smartphone or AVD.
4. Create Splash Screen, Menu and Second Screen using FlutterFlow.
5. Access to Mobile hardware at least two of the following features: Bluetooth, WiFi-Direct, Wireless Display, GPS, Camera, Microphone, Gyrometer, Accelerometer, NFC, Infrared, 5G, WiFi
6. Speed Code Video + Music.
7. Highlight on YouTube using the timestamps.
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.

## LINK

https://youtu.be/9QHRx5gbtB8

## GITHUB SOURCE CODE

https://github.com/ismahhaziq/Lab8-talktohardware

## CODE SNIPPET

#### In pubspec.yaml, add this under 'dependencies'

```
  camera: ^0.10.2
  location: ^5.0.3
```

#### In AndroidManifest.xml, add these for permission to access

```
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

#### In build.gradle (android\build.gradle), change the version of kotlin

```
ext.kotlin_version = '1.9.10'
```

#### In build.gradle (android\app\build.gradle), change the version of minSdkVersion

```
minSdkVersion 21
```

#### main.dart

```
import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the SplashScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
```

#### splash_screen.dart

```
import 'package:flutter/material.dart';
import 'dart:async';
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
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 200),
            SizedBox(height: 20),
            Text(
              'Welcome to TAMAJU app',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### menu_screen.dart

```
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'second_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Location location = Location();
  LocationData? currentLocation; // Use nullable type

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      currentLocation = await location.getLocation();
      setState(() {});
    } catch (e) {
      print("Error getting location: $e");
    }
  }

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
            SizedBox(height: 20),
            Text(
              'Current Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (currentLocation != null)
              Text(
                'Latitude: ${currentLocation!.latitude}\nLongitude: ${currentLocation!.longitude}',
                style: TextStyle(fontSize: 16),
              )
            else
              Text('Location not available'),
          ],
        ),
      ),
    );
  }
}
```

#### second_screen.dart

```
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  late CameraController _controller;
  late Future<void> _controllerInitialization;

  @override
  void initState() {
    super.initState();
    _controllerInitialization = initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: FutureBuilder<void>(
        future: _controllerInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller.value.isInitialized) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              );
            } else {
              return Center(
                child: Text('Camera initialization failed'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
```


