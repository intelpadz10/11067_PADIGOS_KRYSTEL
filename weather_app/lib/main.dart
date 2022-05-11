// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'dataService.dart';
import 'models.dart';

void main() async {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchContent = TextEditingController();
  final _dataService = DataService();
  final _weatherResponse = WeatherResponse();
  Weather? _response;
  List<Weather>? _fiveDay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Weather Forecast",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoSlab',
              color: Color.fromARGB(255, 0, 0, 0),
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/bg5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(135, 255, 255, 255),
                              filled: true,
                              hintText: "Location...",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20.0, 0, 5, 0),
                              suffix: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 15,
                                ),
                                onPressed: () {
                                  _searchContent.clear();
                                },
                              ),
                            ),
                            controller: _searchContent,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(135, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 20,
                          ),
                          onPressed: () {
                            getSearch();
                            getFiveDay();
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_response == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Text(
                            "Welcome" "\n" "to" "\n" "Weather App",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'RobotoSlab',
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (_response != null)
                        Text(
                          '${_response?.weatherDescription}',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      if (_response != null)
                        if (_response?.weatherIcon != null)
                          Image.network(
                            _weatherResponse
                                .iconUrl('${_response?.weatherIcon}'),
                            scale: .6,
                          ),
                      if (_response != null)
                        Text(
                          '${_response?.date!.year}'
                                  ' - '
                                  '${_response?.date!.month}' +
                              ' - ' '${_response?.date!.day}',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      if (_response != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                '${_response?.areaName}, ${_response?.country}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Icon(Icons.location_on,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 35.0),
                          ],
                        ),
                      if (_response != null)
                        Text(
                          '${_response?.temperature?.celsius?.roundToDouble()}°',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      if (_response != null)
                        Container(
                          margin: EdgeInsets.all(5),
                          width: 400,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(121, 255, 255, 255),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (_response != null)
                              Container(
                                // margin: EdgeInsets.all(5),
                                height: 100,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_fiveDay?[6].date!.year}'
                                              ' - '
                                              '${_fiveDay?[6].date!.month}' +
                                          ' - ' '${_fiveDay?[6].date!.day}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[6].weatherIcon.toString()}'),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.network(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[6].weatherIcon.toString()}'),
                                      scale: 1.5,
                                    ),
                                    Text(
                                      '${_fiveDay?[6].temperature?.celsius?.roundToDouble()}°',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // color: Color.fromARGB(122, 72, 73, 73),
                                ),
                              ),
                            if (_response != null)
                              Container(
                                // margin: EdgeInsets.all(5),
                                height: 100,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_fiveDay?[14].date!.year}'
                                              ' - '
                                              '${_fiveDay?[14].date!.month}' +
                                          ' - ' '${_fiveDay?[14].date!.day}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.network(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[14].weatherIcon.toString()}'),
                                      scale: 1.5,
                                    ),
                                    Text(
                                      '${_fiveDay?[14].temperature?.celsius?.roundToDouble()}°',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // color: Color.fromARGB(122, 72, 73, 73),
                                ),
                              ),
                            if (_response != null)
                              Container(
                                // margin: EdgeInsets.all(5),
                                height: 100,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_fiveDay?[22].date!.year}'
                                              ' - '
                                              '${_fiveDay?[22].date!.month}' +
                                          ' - ' '${_fiveDay?[22].date!.day}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.network(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[22].weatherIcon.toString()}'),
                                      scale: 1.5,
                                    ),
                                    Text(
                                      '${_fiveDay?[22].temperature?.celsius?.roundToDouble()}°',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // color: Color.fromARGB(122, 72, 73, 73),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (_response != null)
                        Container(
                          width: 400,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(121, 255, 255, 255),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (_response != null)
                              Container(
                                // margin: EdgeInsets.all(5),
                                height: 100,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_fiveDay?[30].date!.year}'
                                              ' - '
                                              '${_fiveDay?[30].date!.month}' +
                                          ' - ' '${_fiveDay?[30].date!.day}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.network(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[30].weatherIcon}'),
                                      scale: 1.5,
                                    ),
                                    Text(
                                      '${_fiveDay?[30].temperature?.celsius?.roundToDouble()}°',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // color: Color.fromARGB(122, 72, 73, 73),
                                ),
                              ),
                            if (_response != null)
                              Container(
                                // margin: EdgeInsets.all(5),
                                height: 100,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_fiveDay?[38].date!.year}'
                                              ' - '
                                              '${_fiveDay?[38].date!.month}' +
                                          ' - ' '${_fiveDay?[38].date!.day}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.network(
                                      _weatherResponse.iconUrl(
                                          '${_fiveDay?[38].weatherIcon.toString()}'),
                                      scale: 1.5,
                                    ),
                                    Text(
                                      '${_fiveDay?[38].temperature?.celsius?.roundToDouble()}°',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // color: Color.fromARGB(122, 72, 73, 73),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          if (_response != null)
                            Container(
                              margin: EdgeInsets.all(5),
                              // height: 300,
                              width: 350,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Icon(Icons.water_drop,
                                                color: Color.fromARGB(
                                                    181, 255, 255, 255),
                                                size: 30.0),
                                            Text(
                                              'Humidity'
                                              '\n'
                                              '${_response?.humidity}%',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Icon(Icons.thermostat,
                                                color: Color.fromARGB(
                                                    181, 255, 255, 255),
                                                size: 30.0),
                                            Text(
                                              'Feels Like'
                                              '\n'
                                              '${_response?.tempFeelsLike?.celsius?.roundToDouble()}°',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Icon(Icons.air,
                                                color: Color.fromARGB(
                                                    181, 255, 255, 255),
                                                size: 30.0),
                                            Text(
                                              'Wind Speed'
                                              '\n'
                                              '<${_response?.windSpeed} hm/h',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Color.fromARGB(74, 79, 78, 87),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getSearch() async {
    final response = await _dataService.weather(_searchContent.text);
    setState(() => _response = response);
  }

  getFiveDay() async {
    final response =
        await _dataService.fiveDayWeatherForecast(_searchContent.text);
    setState(() => _fiveDay = response);
  }
}
