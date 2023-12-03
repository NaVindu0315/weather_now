import 'package:flutter/material.dart';
import 'package:Weather_Now/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import '../screens/loading_screen.dart';
import '../services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int sendtemp = 0;
  var message;
  var weathericon;
  var temperature;
  var condition;
  var city;
  @override
  void initState() {
    super.initState();
    //print(widget.locationweather);
    updateui(widget.locationweather);
  }

  void updateui(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        weathericon = 'Error';
        message = 'unable to get weather data';
        city = '';
        return;
      }
      temperature = (weatherdata['main']['temp']).toInt();
      condition = weatherdata['weather'][0]['id'];
      city = weatherdata['name'];
      weathericon = weather.getWeatherIcon(condition);

      var newtemp = weatherdata['main']['temp'];
      sendtemp = newtemp.toInt();
      message = weather.getMessage(sendtemp);
    });

    /*print(city);
    print(temperature);*/
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/b.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(1), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getlocationweather();
                      updateui(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedname != null) {
                        var weatherdata =
                            await weather.getcityweather(typedname);
                        updateui(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
//     var longi = decodeddata['coord']['lon'];
//     var weatherdescription = decodeddata['weather'][0]['description'];
//     var temperature = decodeddata['main']['temp'];
//     var condition = decodeddata['weather'][0]['id'];
//     var city = decodeddata['name'];
