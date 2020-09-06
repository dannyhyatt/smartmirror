import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {

  bool isLoading = true;
  WeatherFactory wf = new WeatherFactory("0933cc483345efd7b648435facf6e475");
  Weather w; // current weather
  String city = 'Potomac';

  bool showingToday = true; // false means showingWeek

//  List<Weather> dayForecast;
  List<Weather> weekForecast;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    w = await wf.currentWeatherByCityName(city);
    weekForecast = await wf.fiveDayForecastByCityName(city);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'feels like ${w.tempFeelsLike.fahrenheit.round()}°F',
          style: Theme.of(context).textTheme.headline5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 16, 0),
              child: Icon(
                strToIcon('01d'),
                color: Colors.white,
                size: 42,
              ),
            ),
            Text(
              '${w.temperature.fahrenheit.round()}°F',
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 80),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _generateWeekForecastView(),
            ),
          ),
        ),
//        Container(
//          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(8),
//              border: Border.all(
//                color: Colors.white,
//              )
//          ),
//          child: Row(
//            children: [
//              FlatButton(
//                onPressed: () {
//                  setState(() {
//                    showingToday = true;
//                  });
//                },
//                color: showingToday ? Colors.white : Colors.black,
//                child: Text('Day',
//                    style: showingToday ? Theme.of(context).textTheme.headline6.copyWith(color: Colors.black, fontWeight: FontWeight.w300) : Theme.of(context).textTheme.headline6),
//              ),
//              FlatButton(
//                onPressed: () {
//                  setState(() {
//                    showingToday = false;
//                  });
//                },
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//                padding: EdgeInsets.all(0),
//                color: showingToday ? Colors.black : Colors.white,
//                child: Text('Week',
//                    style: showingToday ? Theme.of(context).textTheme.headline6 : Theme.of(context).textTheme.headline6.copyWith(color: Colors.black, fontWeight: FontWeight.w300)),
//              ),
//            ],
//          ),
//        )
      ],
    );
  }

  IconData strToIcon(String iconName) {
    const strToIcons = {
      '01d' : WeatherIcons.wiDaySunny,
      '02d' : WeatherIcons.wiDaySunnyOvercast,
      '03d' : WeatherIcons.wiDayCloudy,
      '04d' : WeatherIcons.wiDayCloudy,
      '09d' : WeatherIcons.wiDayShowers,
      '10d' : WeatherIcons.wiDayRain,
      '11d' : WeatherIcons.wiDayStormShowers,
      '13d' : WeatherIcons.wiDaySnow,
      '50d' : WeatherIcons.wiDayFog,
      '01n' : WeatherIcons.wiNightClear,
      '02n' : WeatherIcons.wiNightCloudyHigh,
      '03n' : WeatherIcons.wiNightCloudy,
      '04n' : WeatherIcons.wiNightCloudy,
      '09n' : WeatherIcons.wiNightShowers,
      '10n' : WeatherIcons.wiNightRain,
      '11n' : WeatherIcons.wiNightStormShowers,
      '13n' : WeatherIcons.wiNightSnow,
      '50n' : WeatherIcons.wiNightFog,
    };

    return strToIcons[iconName] ?? WeatherIcons.wiDaySunny;
  }

  List<Widget> _generateWeekForecastView() {
    List<Widget> days = List<Widget>();
    for(int i = 0; i < 14; i++) {
      days.add(Container(
        decoration: i != 13 ? BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.white,
              width: 1,
            )
          )
        ) : BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Icon(
                  strToIcon(weekForecast[i].weatherIcon),
                  size: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                '${weekForecast[i].temperature.fahrenheit.round()}°F',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                  (i > 6 ? '+' : '') + DateFormat().add_E().format(DateTime.now().add(Duration(days: i * 1 + 1))),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ));
    }
    return days;
  }
}
