import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  void setWorldTime() async {
    // if we wanna use await on a function it has to be declared as async
    WorldTime instance = WorldTime(
        location: 'Kampala', flag: 'uganda.png', url: 'Africa/Kampala');
    await instance.getTime();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime
    });

    // setState(() {
    time = instance.time!;
    // print(time); // if we try to print the time, this might not work
    // because getTime() is an asynchronous function that might take
    // some time to fetch the data and at the moment that data (time) is not known
    // });
  }

  //simulate network request for a username
  // String username = await Future.delayed(Duration(seconds: 3), () {//await key word makes this statement block for 3 seconds
  //   return ('yoshi');
  // });

  // //simulate network request to get bio
  // String bio = await Future.delayed(Duration(seconds: 2), () {//asynchronous request
  //   return ('vegan, musician & egg collector');
  // });

  // print('$username - $bio'); //non-blocking

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: const Center(
        // child: Text(
        //   'Loading...',
        //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
