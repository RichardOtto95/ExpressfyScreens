import 'package:delivery_screens/shared/color_theme.dart';
import 'package:delivery_screens/shared/utilities.dart';
import 'package:flutter/material.dart';

class BlackAppBar extends StatelessWidget {
  final String title;
  BlackAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: wXD(25, context)),
          width: maxWidth(context),
          height: wXD(78, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48)),
            color: ColorTheme.totalBlack,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x30000000),
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: ColorTheme.white,
              ),
              SizedBox(width: wXD(4, context)),
              Text(
                'Rua 3c Chácara 26...5 Vicente Pires, 25',
                style: textFamily(
                  fontSize: 14,
                  color: ColorTheme.white,
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: wXD(9, context),
        //   left: wXD(31, context),
        //   child: InkWell(
        //     onTap: () => Modular.to.pop(),
        //     child: Icon(Icons.arrow_back,
        //         color: ColorTheme.darkGrey, size: wXD(25, context)),
        //   ),
        // ),
        // Positioned(
        //   bottom: wXD(9, context),
        //   child: Text(
        //     title,
        //     style: TextStyle(
        //       color: ColorTheme.textBlack,
        //       fontSize: 20,
        //       fontWeight: FontWeight.w600,
        //       fontFamily: 'Montserrat',
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
