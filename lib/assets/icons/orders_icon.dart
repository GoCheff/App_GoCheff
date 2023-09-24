import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class OrdersIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color fill;

  const OrdersIcon({
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
        '''<svg width="108" height="120" viewBox="0 0 108 120" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M95.4167 12.7501H89.5V0.916748H77.6667V12.7501H30.3333V0.916748H18.5V12.7501H12.5833C6.075 12.7501 0.75 18.0751 0.75 24.5834V107.417C0.75 113.925 6.075 119.25 12.5833 119.25H95.4167C101.925 119.25 107.25 113.925 107.25 107.417V24.5834C107.25 18.0751 101.925 12.7501 95.4167 12.7501ZM95.4167 107.417H12.5833V48.2501H95.4167V107.417ZM12.5833 36.4167V24.5834H95.4167V36.4167H12.5833ZM24.4167 60.0834H83.5833V71.9167H24.4167V60.0834ZM24.4167 83.7501H65.8333V95.5834H24.4167V83.7501Z" fill="#C7C7C7"/>
</svg>''',
        color: fill,
      ),
    );
  }
}