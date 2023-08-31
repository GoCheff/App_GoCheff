import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  static const spinner = SpinKitRing(
    color: CustomColors.primary,
    size: 35.0,
    lineWidth: 2,
  );

  @override
  Widget build(BuildContext context) {
    return spinner;
  }
}
