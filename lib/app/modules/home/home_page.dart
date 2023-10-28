import 'package:delivery_screens/shared/color_theme.dart';
import 'package:delivery_screens/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/black_app_bar.dart';
import 'widgets/home_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int selected = 1;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: wXD(78, context), width: maxWidth(context)),
                SeeRoute(),
                HomeCard(),
                Padding(
                  padding: EdgeInsets.only(
                    left: wXD(16, context),
                    top: wXD(12, context),
                    bottom: wXD(16, context),
                  ),
                  child: Text(
                    'Operações/Estatísticas',
                    style: textFamily(
                      fontSize: 17,
                      color: ColorTheme.textTotalBlack,
                    ),
                  ),
                ),
                Period(
                  onToday: () => setState(() => selected = 1),
                  onWeek: () => setState(() => selected = 2),
                  onMonth: () => setState(() => selected = 3),
                  selected: selected,
                ),
                PerformanceCard(),
                SizedBox(height: wXD(90, context), width: maxWidth(context)),
              ],
            ),
          ),
          BlackAppBar('Rua 3c Chácara 26...5 Vicente Pires, 25'),
        ],
      ),
    );
  }
}

class SeeRoute extends StatelessWidget {
  const SeeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: wXD(56, context),
            width: wXD(343, context),
            margin: EdgeInsets.symmetric(vertical: wXD(24, context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Color(0xfffff4e4),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 3),
                  color: ColorTheme.totalBlack.withOpacity(.2),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rota em andamento',
                  style: textFamily(
                    fontSize: 14,
                    color: ColorTheme.primaryOrange,
                  ),
                ),
                SizedBox(height: wXD(4, context)),
                Text(
                  'Ver rota em andamento',
                  style: textFamily(
                    fontSize: 10,
                    color: ColorTheme.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: wXD(12, context),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: wXD(30, context),
              color: ColorTheme.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17, 21, 0, 7),
          child: Text(
            "Sua atividade hoje",
            style: textFamily(fontSize: 12),
          ),
        ),
        Center(
          child: Container(
            height: wXD(179, context),
            width: wXD(362, context),
            padding: EdgeInsets.symmetric(
                horizontal: wXD(8, context), vertical: wXD(10, context)),
            decoration: BoxDecoration(
              border:
                  Border.all(color: ColorTheme.veryLightGrey.withOpacity(.3)),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorTheme.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 3),
                    color: ColorTheme.totalBlack.withOpacity(.1))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PerformanceData(qtd: 4, title: "Pedidos entregues"),
                    PerformanceData(qtd: 5, title: "Ofertas aceitas"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PerformanceData(qtd: 2, title: "Pedidos entregues"),
                    PerformanceData(qtd: 1, title: "Ofertas aceitas"),
                  ],
                ),
                InkWell(
                  onTap: () => Modular.to.pushNamed("/home/full-performance"),
                  child: Container(
                    height: wXD(28, context),
                    width: wXD(332, context),
                    padding: EdgeInsets.only(
                      left: wXD(2, context),
                      right: wXD(13, context),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: ColorTheme.grey.withOpacity(.3)))),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Text(
                          "Ver desempenho completo",
                          style: textFamily(
                            color: ColorTheme.primaryOrange,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorTheme.primaryOrange,
                          size: wXD(20, context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PerformanceData extends StatelessWidget {
  final int qtd;
  final String title;

  const PerformanceData({Key? key, required this.qtd, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(162, context),
      height: wXD(56, context),
      padding: EdgeInsets.only(top: wXD(8, context), bottom: wXD(7, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        border: Border.all(color: ColorTheme.primaryOrange.withOpacity(.4)),
      ),
      child: Column(
        children: [
          Text(
            qtd.toString(),
            style: textFamily(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorTheme.primaryOrange,
            ),
          ),
          Spacer(),
          Text(
            title,
            style: textFamily(
              fontWeight: FontWeight.w400,
              color: Color(0xff4D4D4D),
            ),
          ),
        ],
      ),
    );
  }
}

class Period extends StatelessWidget {
  final void Function() onToday;
  final void Function() onWeek;
  final void Function() onMonth;
  final int selected;

  Period(
      {required this.onToday,
      required this.onWeek,
      required this.onMonth,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(40, context),
        width: wXD(342, context),
        decoration: BoxDecoration(
          border: Border.all(
              color: ColorTheme.totalBlack, width: wXD(1.6, context)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: onToday,
              child: Text(
                'Hoje',
                style: textFamily(
                  fontSize: 16,
                  color: selected == 1
                      ? ColorTheme.primaryOrange
                      : ColorTheme.textTotalBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: wXD(40, context),
              width: wXD(150, context),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: ColorTheme.totalBlack,
                    width: wXD(2, context),
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: onWeek,
                child: Text(
                  'Semana',
                  style: textFamily(
                    fontSize: 16,
                    color: selected == 2
                        ? ColorTheme.primaryOrange
                        : ColorTheme.textTotalBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: onMonth,
              child: Text(
                'Mês',
                style: textFamily(
                  fontSize: 16,
                  color: selected == 3
                      ? ColorTheme.primaryOrange
                      : ColorTheme.textTotalBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
