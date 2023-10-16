import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String? time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api end point
  bool? isDaytime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
          hours: int.parse(
              offset))); // add a specified amount of duration - in this case the offset by which your current time is

      // set the time property
      // isDaytime = condition ? value if true: value if false
      isDaytime = now.hour > 6 && now.hour < 20? true: false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
