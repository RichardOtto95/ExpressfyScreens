import 'package:delivery_screens/shared/color_theme.dart';
import 'package:delivery_screens/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool montantVisible = false;
  bool online = true;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 10000),
    );
    animationController.forward();
    animationController.addListener(() {
      // setState(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.repeat();
      }
      // });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(257, context),
        width: wXD(342, context),
        padding: EdgeInsets.symmetric(
            horizontal: wXD(21, context), vertical: wXD(14, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(27)),
          border: Border.all(color: Color(0xfff1f1f1)),
          color: ColorTheme.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x30000000),
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Nível 1',
                      style: textFamily(
                        fontSize: 16,
                        color: ColorTheme.textTotalBlack,
                      ),
                    ),
                    Text(
                      '21 XP',
                      style: textFamily(
                        fontSize: 12,
                        color: ColorTheme.primaryOrange,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      montantVisible ? Icons.visibility : Icons.visibility_off,
                      color: ColorTheme.totalBlack,
                      size: wXD(25, context),
                    ),
                    Column(
                      children: [
                        SizedBox(height: wXD(4, context)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              montantVisible = !montantVisible;
                            });
                          },
                          child: montantVisible
                              ? Text(
                                  ' R\$ 15.500,00',
                                  style: textFamily(
                                    fontSize: 16,
                                    color: ColorTheme.textTotalBlack,
                                  ),
                                )
                              : Container(
                                  height: wXD(17, context),
                                  width: wXD(98, context),
                                  margin:
                                      EdgeInsets.only(left: wXD(3, context)),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: ColorTheme.grey.withOpacity(.3)),
                                ),
                        ),
                        Text(
                          'Ganho semanal',
                          style: textFamily(
                            height: 1.4,
                            fontSize: 12,
                            color: ColorTheme.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: wXD(160, context),
              width: wXD(160, context),
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: wXD(160, context),
                    width: wXD(160, context),
                    child: CustomPaint(
                      painter: ShadowPainter(),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(animationController),
                        child: SizedBox(
                          height: wXD(160, context),
                          width: wXD(160, context),
                          child: CustomPaint(
                            painter: Painter(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // AnimatedBuilder(
                  //   animation: animationController,
                  //   builder: (context, child) {
                  //     return
                  //      SizedBox(
                  //       height: wXD(160, context),
                  //       width: wXD(160, context),
                  //       child: CustomPaint(
                  //         painter: Painter(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  Text(
                    '08:44',
                    style: GoogleFonts.montserrat(
                        fontSize: 44,
                        color: ColorTheme.textTotalBlack,
                        shadows: [
                          Shadow(
                            blurRadius: 0,
                            color: ColorTheme.grey.withOpacity(.8),
                            offset: Offset(2, 0),
                          )
                        ],
                        fontWeight: FontWeight.normal),
                  ),
                  Positioned(
                    right: wXD(15, context),
                    bottom: wXD(8, context),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          online = !online;
                        });
                      },
                      child: Container(
                        height: wXD(25, context),
                        width: wXD(25, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorTheme.white),
                          color: online ? ColorTheme.green : ColorTheme.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  online = !online;
                });
              },
              child: Text(
                online ? 'Toque para ficar offline' : 'Toque para ficar online',
                style: textFamily(
                  fontSize: 16,
                  color: ColorTheme.textTotalBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    canvas.translate(size.width / 2, size.height / 2);
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, 3), radius: radius));

    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawPath(oval, shadowPaint);
  }

  @override
  bool shouldRepaint(ShadowPainter oldDelegate) {
    return false;
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    canvas.translate(size.width / 2, size.height / 2);
    Offset center = Offset(0.0, 0.0);
    // draw shadow first
    // Path oval = Path()
    //   ..addOval(Rect.fromCircle(center: Offset(0, 3), radius: radius));

    // Paint shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(.3)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 5;
    // canvas.drawPath(oval, shadowPaint);
    // draw circle
    Paint thumbPaint = Paint()
      ..shader = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade800,
                Colors.red,
                Colors.yellow.shade700
              ],
              tileMode: TileMode.mirror)
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    // canvas.drawCircle(center, radius, thumbPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 50, 50,
        false, thumbPaint);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return false;
  }
}
