import 'package:flutter/material.dart';

import '../../style/color.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CircularProgressIndicator(color: ColorTheme.primaryColor);
}
