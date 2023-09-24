import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class MenuIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color fill;

  const MenuIcon({
    super.key,
    this.width = 24.0,
    this.height = 24.0,
    this.fill = CustomColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.string(
        '''<svg width="25" height="17" viewBox="0 0 25 17" xmlns="http://www.w3.org/2000/svg">
        <path d="M1.59863 8.33333H13.5001M1.59863 1H23.5986M1.59863 15.6667H23.5986" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>''',
        color: fill,
      ),
    );
  }
}
