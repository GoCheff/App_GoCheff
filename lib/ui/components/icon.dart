import 'package:customer_app/assets/icons/logo_icon.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/cupertino.dart';

class IconWidget extends StatelessWidget {
  final String name;
  final double? size;
  final double width;
  final double height;
  final Color fill;

  const IconWidget({
    super.key,
    required this.name,
    this.size,
    this.width = 24.0,
    this.height = 24.0,
    this.fill = CustomColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> icon = {
      'logo': LogoIcon(
        width: size ?? width,
        height: size ?? height,
        fill: fill,
      ),
    };

    return Container(
      child: icon[name],
    );
  }
}
