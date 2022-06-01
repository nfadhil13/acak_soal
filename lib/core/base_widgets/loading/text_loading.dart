import 'dart:async';

import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  final String data;
  final TextStyle? style;
  final Duration loadingDuration;
  final int numberOfDots;
  final TextAlign textAlign;
  const LoadingText(this.data,
      {Key? key,
      this.style,
      this.loadingDuration = const Duration(milliseconds: 500),
      this.numberOfDots = 5,  this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  _LoadingTextState createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {
  Timer? _debounce;

  var text = "";
  var currentLoop = 0;

  @override
  void initState() {
    text = widget.data;
    _debounce = Timer.periodic(widget.loadingDuration, (_) {
      if (currentLoop < widget.numberOfDots) {
        text += " .";
        currentLoop++;
      } else {
        currentLoop = 0;
        text = widget.data;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: widget.style,
      textAlign: widget.textAlign,
    );
  }
}
