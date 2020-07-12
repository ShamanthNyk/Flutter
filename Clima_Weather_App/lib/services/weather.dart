import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apikey='36765b5b7a1867e591ecc6054ecce86c';
const OpenWeatherMapURL='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getlocationWeather() async{
    Location location =Location();
    await location.getcurrloc();

    NetworkHelper networkHelper=NetworkHelper(
        '$OpenWeatherMapURL?lat=${location.lat}&lon=${location
            .longi}&appid=$apikey&units=metric');
    var weatherdata= await networkHelper.getdata();
    return weatherdata;
  }
  Future<dynamic> getCityWeather(String cityname) async{
    var url='$OpenWeatherMapURL?q=$cityname&appid=$apikey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherdata= await networkHelper.getdata();
    return weatherdata;
  }
  String getWeatherIcon(var condition) {
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

  String getMessage(var temp) {
    if (temp > 30) {
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
