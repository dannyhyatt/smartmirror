import 'package:flutter/material.dart';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:smartmirror/views/generative_clock/digital_clock.dart';
class GenerativeClockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return ClockCustomizer((ClockModel model) {
//      debugPrint('MODEL: ${model.temperature} ${model.high} ${model.low} ${model.location} ${model.unit} ${model.weatherCondition} ${model.is24HourFormat}');
//      return DigitalClock(model..is24HourFormat=false);
//    });
    ClockModel model = ClockModel();
    model.temperature=(22.0);
    model.high=(26.0);
    model.low=(19.0);
    model.location=('Mountain View, CA');
    model.unit=(TemperatureUnit.celsius);
    model.weatherCondition=(WeatherCondition.sunny);
    model.is24HourFormat=(false);
    return SafeArea(
      child: DigitalClock(model)
    );
  }
}
