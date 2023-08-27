import 'package:flutter/material.dart';

class CustomColors{
  Color _activePrimaryButton = Color.fromARGB(255, 63, 81, 181);
  Color _activeSecondaryButton = Color.fromARGB(255, 200, 200, 200);

  Color getActivePrimaryButtonColor() {

    return _activePrimaryButton;
  }

  Color getActiveSecondaryButtonColor() {
    return _activeSecondaryButton;

  }
}

