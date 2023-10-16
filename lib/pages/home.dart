import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    print(data);

    //set backround
    String bgImage =
        data['isDaytime'] ? 'day-darius-krause.jpg' : 'night-fatih-güney.jpg';
    Color bgColor =
        data['isDaytime'] ? Colors.blue : Colors.indigo[900] as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 120),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextButton.icon(
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/location');
                          setState(() {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'flag': result['flag'],
                              'isDaytime': result['isDaytime']
                            };
                          });
                        },
                        icon: Icon(
                          Icons.edit_location,
                          color: Colors.grey[400],
                          size: 25,
                        ),
                        label: Text(
                          'Edit location',
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  data['time'],
                  style: const TextStyle(fontSize: 66, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
