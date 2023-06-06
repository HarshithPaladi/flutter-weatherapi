import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const Weather());
}

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var temp;
  var city = "London";
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=89727fd78420e93cc55a572c11542774&units=metric'));

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Weather From API',
    //   home: Scaffold(
    //     body: Column(children: [
    //       Container()
    //     ]),
    //   ),
    // );

    return MaterialApp(
        title: 'Weather App',
        home: Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blueAccent,
                          Colors.lightBlueAccent,
                        ]),),
                // color: Colors.red,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Currently in ${city}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
              ),

                  Container(
                    // height: MediaQuery.of(context).size.height / 3,
                    // width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter City Name',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onSubmitted: (value) {
                        setState(() {
                          this.city = value;
                          this.getWeather();
                        });
                      },
                    ),
                  ),
                  // IconButton(onPressed: getWeather, icon: Icon(Icons.search))
                ],
          ),
        ));
  }

  get tempColor => ;
}
