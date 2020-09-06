import 'package:flutter/cupertino.dart';
import 'package:smartmirror/views/dots_clock/models/dots_clock_style.dart';
import 'package:smartmirror/views/dots_clock/widgets/dots_clock.dart';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';

class DotsClockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      ClockCustomizer(
            (ClockModel model) => LayoutBuilder(
          builder: (context, constraints) => DotsClock(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            model: model,
            // For other clocks, replace DotsClockStyle with the
            // following ones or make your own clock and reload.
            //
            // DotsClockStyle.blobs(),
            // DotsClockStyle.cellularNoise(),
            // DotsClockStyle.cubicNoise(),
            // DotsClockStyle.gooey(),
            // DotsClockStyle.simplexNoise(),
            // DotsClockStyle.valueNoise(),
            // DotsClockStyle.whiteNoise()
            style: DotsClockStyle.cubicNoise().copyWith(
              // Use box constraint height dependant units for consistent sizing
              // on all displays since aspect ratio is always the same for the contest.
              dotSpacing: constraints.maxHeight * 0.017,
              dotBaseSize: 0.5,
              dotActiveScale: constraints.maxHeight * 0.013,
              brightBackgroundColor: Color(0xFFF4F4F4),
              darkBackgroundColor: Color(0xFF10151B),
            ),
          ),
        ),
      );
  }
}
