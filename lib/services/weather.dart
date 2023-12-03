import '../services/networking.dart';
import '../screens/location_screen.dart';
import '../screens/loading_screen.dart';
import '/location.dart';

double long = 0; //80.0349467;
double lat = 0;

class WeatherModel {
  Future<dynamic> getcityweather(var cityname) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=7961b6da2e8aa839db103cc42b7ede58&units=metric';
    Networkhelper networkhelper = Networkhelper(url);
    var weatherdata = await networkhelper.getData();
    return weatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location lc = Location();

    await lc.getcurrentlocation();
    //getdata();
    //long = lc.longitude;
    //lat = lc.latitude;
    long = lc.longitude;
    lat = lc.latitude;
    Networkhelper networkhelper = Networkhelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=7961b6da2e8aa839db103cc42b7ede58&units=metric');
    var weatherdata = await networkhelper.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
