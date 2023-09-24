import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  late double size;

  LoadingSpinner({Key? key, double size = 35.0}) : super(key: key) {
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    SpinKitRing spinner = SpinKitRing(
      color: CustomColors.primary,
      size: size,
      lineWidth: 2,
    );

    return spinner;
  }
}
