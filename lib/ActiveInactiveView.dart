import 'dart:async';

import 'package:flutter/material.dart';

class ActiveInactiveView extends StatefulWidget {

  final int seconds;
  final Widget active, inactive;

  ActiveInactiveView({
    this.seconds,
    this.active,
    this.inactive
  });

  @override
  _ActiveInactiveViewState createState() => _ActiveInactiveViewState();
}

class _ActiveInactiveViewState extends State<ActiveInactiveView> {

  bool active = true;
  Timer t;

  @override
  void initState() {
    t = Timer(Duration(seconds: widget.seconds), _makeInactive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        _refreshTimer();
      },
      child: GestureDetector(
        onTapDown: (_) {
          _makeActive();
        },
        child: active ? widget.active : widget.inactive,
      ),
    );
  }

  void _makeActive() => setState(() => active = true);
  void _makeInactive() => setState(() => active = false);
  void _refreshTimer() {
    t.cancel();
    t = Timer(Duration(seconds: widget.seconds), _makeInactive);
  }
}
