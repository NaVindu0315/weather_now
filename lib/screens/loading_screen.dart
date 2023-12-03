//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
/*
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getpermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  /*void getlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    print('nv');
  }*/
  String _locationData = '';

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      _locationData =
          'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
      print(_locationData);
      print('ddd');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //getpermission();
            _getCurrentLocation();
            //getlocation();
            print('nnn');
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}*/

import 'package:Weather_Now/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import '../location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //7.486185;
  String _locationData = '';
  final appkey = '5c01604087386fbe2da5b46912166082';
  @override
  void initState() {
    super.initState();
    getlocationdata();
    LocationScreen();
    //getdata();
  }

  ///location get start
  void getlocationdata() async {
    /*
    print('Requesting location permission...');
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission denied');
      return;
    }

    print('Getting current location...');
   */
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getlocationweather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherdata,
      );
    }));
  }

  ///location get end

  ///get data method start

  /// get data method end

  @override
  Widget build(BuildContext context) {
    String Mymargin = '15';

    return /*LocationScreen(); */ Scaffold(
        body: Center(
      /* child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      ),*/
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LocationScreen();
            },
          ));
        },
        child: Text(
          'Continue',
          style: kButtonTextStyle,
        ),
      ),
    ));
  }
}

/*
///location get start
  Future<void> _getPermissionAndLocation() async {
    print('Requesting location permission...');
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission denied');
      return;
    }

    print('Getting current location...');
    try
    {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _locationData =
            'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
        print(_locationData);
        if (position == null) {
          print('Failed to get location data');
          return;
        }
      });
    }
    catch(e)
    {
      print(e);
    }
  }


  ///location get end

 */
