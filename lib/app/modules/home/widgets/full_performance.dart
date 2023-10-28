import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_screens/app/core/models/time_model.dart';
import 'package:delivery_screens/app/modules/home/home_store.dart';
import 'package:delivery_screens/shared/color_theme.dart';
import 'package:delivery_screens/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FullPerformance extends StatefulWidget {
  const FullPerformance({Key? key}) : super(key: key);

  @override
  _FullPerformanceState createState() => _FullPerformanceState();
}

class _FullPerformanceState extends State<FullPerformance>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  late TabController tabController;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundGrey,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (pg) => tabController.animateTo(pg),
            children: [
              PerformancStatistics(),
              Earnings(),
            ],
          ),
          PerformanceAppBar(
            tabController: tabController,
            onTap: (pg) async => await pageController.animateToPage(pg,
                duration: Duration(milliseconds: 300), curve: Curves.ease),
          ),
        ],
      ),
    );
  }
}

class PerformancStatistics extends StatefulWidget {
  PerformancStatistics({Key? key}) : super(key: key);

  @override
  _PerformancStatisticsState createState() => _PerformancStatisticsState();
}

class _PerformancStatisticsState extends State<PerformancStatistics> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: wXD(104, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Goals(),
          OffensiveCalendar(),
          Statistics(),
          CartesianChart(),
        ],
      ),
    );
  }
}

class CartesianChart extends StatefulWidget {
  const CartesianChart({Key? key}) : super(key: key);

  @override
  _CartesianChartState createState() => _CartesianChartState();
}

class _CartesianChartState extends State<CartesianChart> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      ChartData('CHN', 12),
      ChartData('GER', 15),
      ChartData('RUS', 30),
      ChartData('BRZ', 6.4),
      ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  List<String> weekDays = [
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
    "Dom",
  ];

  List<ChartData> takeLastWeek() {
    List<ChartData> chartDatas = [
      ChartData("Sáb", 0),
      ChartData("Dom", 300),
      ChartData("Seg", 250),
      ChartData("Ter", 500),
      ChartData("Qua", 70),
      ChartData("Qui", 237),
      ChartData("Sex", 600),
    ];

    // double score = 40;
    // for (int i = 6; i >= 0; i--) {
    //   DateTime aQeekAgo = DateTime.now().subtract(Duration(days: i));
    //   print("aQeekAgo $aQeekAgo");
    //   print("i: $i");
    //   chartDatas.add(ChartData(weekDays[aQeekAgo.weekday - 1], score));
    //   score += 70;
    // }
    return chartDatas;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(207, context),
        width: wXD(347, context),
        margin: EdgeInsets.symmetric(vertical: wXD(15, context)),
        decoration: BoxDecoration(
          border: Border.all(color: ColorTheme.grey),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorTheme.white,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: wXD(11, context)),
              width: wXD(306, context),
              height: wXD(40, context),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: wXD(12, context),
                        width: wXD(12, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorTheme.primaryOrange,
                        ),
                      ),
                      Text(
                        " Você",
                        style: textFamily(
                          color: ColorTheme.primaryOrange,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "374 XP",
                    style: textFamily(
                      color: ColorTheme.primaryOrange,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: wXD(165, context),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // primaryYAxis: NumericAxis(minimum: 0, maximum: 800, interval: 200),
                tooltipBehavior: _tooltip,

                series: <ChartSeries>[
                  LineSeries<ChartData, String>(
                    dataSource: takeLastWeek(),
                    xValueMapper: (ChartData _data, __) => _data.x,
                    yValueMapper: (ChartData _data, __) => _data.y,
                    color: ColorTheme.primaryOrange,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      color: ColorTheme.primaryOrange,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17, 20, 0, 18),
          child: Text(
            "Estatísticas",
            style: textFamily(
              fontSize: 17,
              color: ColorTheme.textTotalBlack,
            ),
          ),
        ),
        Container(
          width: maxWidth(context),
          height: wXD(120, context),
          padding: EdgeInsets.symmetric(horizontal: wXD(14, context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Statistic(
                    svgPath: "assets/svg/fire.svg",
                    data: "44",
                    description: "Dias de ofensiva",
                  ),
                  Statistic(
                    svgPath: "assets/svg/ray.svg",
                    data: "12517",
                    description: "Total de XP",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Statistic(
                    svgPath: "assets/svg/flag.svg",
                    data: "Pérola",
                    description: "Divisão",
                  ),
                  Statistic(
                    svgPath: "assets/svg/podium.svg",
                    data: "4",
                    description: "Pódios",
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Statistic extends StatelessWidget {
  final String svgPath;
  final String data;
  final String description;
  Statistic({
    Key? key,
    required this.svgPath,
    this.data = "Sem dados",
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(56, context),
      width: wXD(162, context),
      padding: EdgeInsets.fromLTRB(10, 11, 10, 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: ColorTheme.grey),
        color: ColorTheme.white,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgPath,
            semanticsLabel: 'Acme Logo',
            height: wXD(15, context),
            width: wXD(10, context),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          SizedBox(width: wXD(7, context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: wXD(2, context)),
              Text(
                data,
                style: textFamily(
                  fontWeight: FontWeight.w600,
                  color: ColorTheme.totalBlack,
                ),
              ),
              SizedBox(height: wXD(3, context)),
              Text(
                description,
                style: textFamily(
                  color: ColorTheme.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OffensiveCalendar extends StatefulWidget {
  const OffensiveCalendar({Key? key}) : super(key: key);

  @override
  _OffensiveCalendarState createState() => _OffensiveCalendarState();
}

class _OffensiveCalendarState extends State<OffensiveCalendar> {
  final HomeStore store = Modular.get();
  TextStyle calTextStyle({Color? color}) => textFamily(color: color);
  final rangePickerController = DateRangePickerController();

  @override
  void initState() {
    rangePickerController.displayDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    rangePickerController.dispose();
    super.dispose();
  }

  List<String> weekDays = [
    "Dom",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sab",
  ];
  @override
  Widget build(BuildContext context) {
    String month = DateFormat(
      "MMMM",
    ).format(rangePickerController.displayDate!);
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: wXD(294, context),
            width: wXD(342, context),
            decoration: BoxDecoration(
              color: ColorTheme.white,
              border: Border.all(color: Color(0xfff1f1f1)),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 3),
                  color: ColorTheme.totalBlack.withOpacity(.1),
                )
              ],
            ),
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(),
                  width: wXD(274, context),
                  height: wXD(280, context),
                  child: getSfCalendar(),
                ),
                Container(
                  width: wXD(274, context),
                  height: wXD(260, context),
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Positioned(
            top: wXD(20, context),
            child: Container(
              height: wXD(50, context),
              width: wXD(306, context),
              padding: EdgeInsets.only(bottom: wXD(6, context)),
              color: ColorTheme.white,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () =>
                            setState(() => rangePickerController.backward!()),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: wXD(15, context),
                          color: ColorTheme.totalBlack,
                        ),
                      ),
                      Text(
                        month.substring(0, 1).toUpperCase() +
                            month.substring(1) +
                            " de " +
                            rangePickerController.displayDate!.year.toString(),
                        style: textFamily(color: ColorTheme.totalBlack),
                      ),
                      InkWell(
                        onTap: () =>
                            setState(() => rangePickerController.forward!()),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: wXD(15, context),
                          color: ColorTheme.totalBlack,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(children: [
                    SizedBox(width: wXD(16, context)),
                    ...List.generate(
                      7,
                      (index) {
                        print(
                            "index: $index, weekDay: ${DateTime(2021, 11, 14).weekday}");
                        bool isToday = (index + 7 == DateTime.now().weekday ||
                                index == DateTime.now().weekday) &&
                            DateTime.now().toString().substring(0, 7) ==
                                rangePickerController.displayDate
                                    .toString()
                                    .substring(0, 7);
                        return Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              weekDays[index],
                              style: textFamily(
                                  color: isToday
                                      ? ColorTheme.primaryOrange
                                      : null),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: wXD(16, context)),
                  ]

                      //     weekDays.map((weekDay) {
                      //   bool thisWeek = weekDay = DateTime.now().w
                      //   return Expanded(
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         weekDay,
                      //         style: textFamily(),
                      //       ),
                      //     ),
                      //   );
                      // }).toList()
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSfCalendar() {
    return SfDateRangePicker(
      initialSelectedDates: [
        DateTime(2021, 11, 5),
        DateTime(2021, 11, 8),
      ],
      controller: rangePickerController,
      view: DateRangePickerView.month,
      selectionMode: DateRangePickerSelectionMode.multiRange,
      initialSelectedRanges: [
        PickerDateRange(DateTime(2021, 11, 2), DateTime.now()),
      ],
      startRangeSelectionColor: ColorTheme.primaryOrange,
      endRangeSelectionColor: ColorTheme.primaryOrange,
      rangeSelectionColor: Color(0xffFFCA7C),
      rangeTextStyle: calTextStyle(color: ColorTheme.primaryOrange),
      monthViewSettings: DateRangePickerMonthViewSettings(
        enableSwipeSelection: false,
      ),
      selectionTextStyle: calTextStyle(color: ColorTheme.white),
      monthCellStyle: DateRangePickerMonthCellStyle(
        textStyle: calTextStyle(),
        todayTextStyle: calTextStyle(),
        todayCellDecoration: BoxDecoration(
          color: Color(0xffA9A9A9),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Goals extends StatelessWidget {
  Goals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin:
            EdgeInsets.only(top: wXD(11, context), bottom: wXD(17, context)),
        height: wXD(58, context),
        width: wXD(302, context),
        decoration: BoxDecoration(
          color: ColorTheme.white,
          border: Border.all(color: ColorTheme.grey, width: wXD(1, context)),
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: wXD(135, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department_sharp,
                        size: wXD(22, context),
                      ),
                      Text(
                        "15 dias",
                        style: textFamily(
                          fontSize: 15,
                          color: ColorTheme.totalBlack,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Ofensiva atual",
                    style: textFamily(
                      fontSize: 15,
                      color: ColorTheme.totalBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: wXD(58, context),
              width: wXD(1, context),
              decoration:
                  BoxDecoration(border: Border.all(color: ColorTheme.grey)),
            ),
            SizedBox(
              width: wXD(135, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cases_outlined,
                        size: wXD(22, context),
                      ),
                      Text(
                        " 0 / 50 XP",
                        style: textFamily(
                          fontSize: 15,
                          color: ColorTheme.totalBlack,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Meta diária",
                    style: textFamily(
                      fontSize: 15,
                      color: ColorTheme.totalBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Earnings extends StatelessWidget {
  final HomeStore store = Modular.get();
  Earnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List earnings = [
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
      {
        "date": DateTime.now(),
        "value": 2.04,
      },
    ];
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: wXD(120, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GainFilterDate(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              wXD(24, context),
              wXD(14, context),
              wXD(0, context),
              wXD(15, context),
            ),
            child: Text(
              "Seus ganhos",
              style: textFamily(
                fontSize: 13,
                color: ColorTheme.totalBlack,
              ),
            ),
          ),
          Center(
            child: Container(
              // height: wXD(278, context),
              width: wXD(342, context),
              margin: EdgeInsets.only(bottom: wXD(20, context)),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ColorTheme.primaryOrange.withOpacity(.40)),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorTheme.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(0, 3),
                    color: ColorTheme.totalBlack.withOpacity(.2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      wXD(12, context),
                      wXD(14, context),
                      0,
                      wXD(15, context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ganhos totais",
                          style: textFamily(
                            fontSize: 13,
                            color: ColorTheme.totalBlack,
                          ),
                        ),
                        SizedBox(height: wXD(7, context)),
                        Text(
                          "R\$ 0,00",
                          style: textFamily(
                            fontSize: 17,
                            color: ColorTheme.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: wXD(38, context),
                    width: wXD(342, context),
                    color: ColorTheme.veryVeryLightOrange,
                    padding: EdgeInsets.symmetric(horizontal: wXD(15, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data e hora",
                          style:
                              textFamily(color: ColorTheme.grey, fontSize: 10),
                        ),
                        Container(
                          width: wXD(60, context),
                          child: Text(
                            "R\$ ",
                            style: textFamily(
                                color: ColorTheme.grey, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      if (store.isEmpty) {
                        return EarningEmptyState();
                      } else {
                        return Column(
                          children: earnings
                              .map((earn) => Earning(
                                    date: earn["date"],
                                    price: earn["value"],
                                  ))
                              .toList(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Earning extends StatelessWidget {
  final DateTime date;
  final double price;

  Earning({
    Key? key,
    required this.date,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeModel time = TimeModel();
    return Container(
      height: wXD(43, context),
      width: maxWidth(context),
      padding: EdgeInsets.only(left: wXD(16, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: wXD(90, context),
            child: Text(
                "${time.date(Timestamp.fromDate(date)).substring(0, 5)} - ${time.hour(Timestamp.fromDate(date))}",
                style: textFamily(
                  fontSize: 12,
                  color: ColorTheme.grey,
                )),
          ),
          Text("-",
              style: textFamily(
                fontSize: 12,
                color: ColorTheme.grey,
              )),
          Container(
            width: wXD(90, context),
            padding: EdgeInsets.only(left: wXD(15, context)),
            child: Text("${price.toString().replaceAll(".", ",")}",
                style: textFamily(
                  fontSize: 12,
                  color: ColorTheme.grey,
                )),
          ),
        ],
      ),
    );
  }
}

class EarningEmptyState extends StatelessWidget {
  const EarningEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(342, context),
      height: wXD(165, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            "./assets/svg/clipboards.svg",
            height: wXD(85, context),
            width: wXD(87, context),
          ),
          Text("Sem dados", style: textFamily(color: ColorTheme.primaryOrange)),
          Text(
            "A lista de todas as corridas que realizou estarão disponíveis\naqui. Fique online para receber ofertas!",
            textAlign: TextAlign.center,
            style: textFamily(
              fontSize: 10,
              color: ColorTheme.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class GainFilterDate extends StatefulWidget {
  GainFilterDate({Key? key}) : super(key: key);

  @override
  _GainFilterDateState createState() => _GainFilterDateState();
}

class _GainFilterDateState extends State<GainFilterDate> {
  final HomeStore store = Modular.get();

  late OverlayEntry filterOverlay;

  OverlayEntry getFilterOverlay() {
    double opacity = 0;
    double sigma = 0;
    double right = -270;
    bool backing = false;
    int filter = 0;
    DateTime? initialDate;
    DateTime? endDate;

    Widget getCheckPeriod(String title, int numb) {
      return StatefulBuilder(builder: (context, stateSet) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => stateSet(() => filter = numb),
              child: Container(
                margin: EdgeInsets.only(
                    right: wXD(16, context), top: wXD(15, context)),
                height: wXD(16, context),
                width: wXD(16, context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorTheme.primaryOrange),
                  color: ColorTheme.white,
                ),
                alignment: Alignment.center,
                child: Container(
                  height: wXD(10, context),
                  width: wXD(10, context),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filter == numb
                          ? ColorTheme.primaryOrange
                          : Colors.transparent),
                ),
              ),
            ),
            Text(
              title,
              style: textFamily(fontSize: 12, color: ColorTheme.grey),
            )
          ],
        );
      });
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          height: maxHeight(context),
          width: maxWidth(context),
          child: Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, stateSet) {
                if (!backing) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    stateSet(() {
                      opacity = .51;
                      sigma = 3;
                      right = 0;
                    });
                  });
                }
                return Stack(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        backing = true;
                        stateSet(() {
                          opacity = 0;
                          sigma = 0;
                          right = -270;
                          Future.delayed(
                            Duration(milliseconds: 400),
                            () => filterOverlay.remove(),
                          );
                        });
                      },
                      onDoubleTap: () => filterOverlay.remove(),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            ColorTheme.totalBlack.withOpacity(.2),
                            BlendMode.color,
                          ),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                            opacity: opacity,
                            child: Container(
                              color: ColorTheme.totalBlack,
                              height: maxHeight(context),
                              width: maxWidth(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease,
                      right: right,
                      child: Container(
                        height: maxHeight(context),
                        width: wXD(260, context),
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(80)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          wXD(11, context),
                          wXD(34, context),
                          wXD(8, context),
                          wXD(0, context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    backing = true;
                                    stateSet(() {
                                      opacity = 0;
                                      sigma = 0;
                                      right = -270;
                                      Future.delayed(
                                        Duration(milliseconds: 400),
                                        () => filterOverlay.remove(),
                                      );
                                    });
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: wXD(20, context),
                                    color: ColorTheme.grey,
                                  ),
                                ),
                                Spacer(flex: 3),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      filter = 0;
                                      initialDate = null;
                                      endDate = null;
                                    });
                                  },
                                  child: Text(
                                    "Limpar",
                                    style: textFamily(
                                      color: ColorTheme.grey,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    backing = true;
                                    store.isEmpty = !store.isEmpty;
                                    stateSet(() {
                                      opacity = 0;
                                      sigma = 0;
                                      right = -270;
                                      Future.delayed(
                                        Duration(milliseconds: 400),
                                        () => filterOverlay.remove(),
                                      );
                                    });
                                  },
                                  child: Text(
                                    "Filtrar",
                                    style: textFamily(
                                      color: ColorTheme.primaryOrange,
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: wXD(9, context)),
                              width: wXD(241, context),
                              color: ColorTheme.grey.withOpacity(.2),
                              height: wXD(.5, context),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  wXD(10, context),
                                  wXD(13, context),
                                  wXD(0, context),
                                  wXD(20, context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Período",
                                    style: textFamily(
                                      color: ColorTheme.primaryOrange,
                                    ),
                                  ),
                                  getCheckPeriod("Hoje", 0),
                                  getCheckPeriod("Ontem", 1),
                                  getCheckPeriod("1ª quinzena do mês", 2),
                                  getCheckPeriod("2ª quinzena do mês", 3),
                                  getCheckPeriod("Mês passado", 4),
                                  SizedBox(height: wXD(20, context)),
                                  Text(
                                    "Período específico",
                                    style: textFamily(
                                      color: ColorTheme.primaryOrange,
                                    ),
                                  ),
                                  SizedBox(height: wXD(15, context)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          filter = 5;
                                          pickDate(context, onConfirm: (date) {
                                            print("date: $date");
                                            if (endDate != null &&
                                                date != null &&
                                                date.isAfter(endDate!)) {
                                              showToast(
                                                  "A data inicial não pode ser depois da final");
                                            } else {
                                              initialDate = date;
                                            }
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: wXD(4, context)),
                                              height: wXD(29, context),
                                              width: wXD(76, context),
                                              decoration: BoxDecoration(
                                                color: Color(0xffe4e4e4),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Data inicial",
                                                style: textFamily(
                                                  fontSize: 10,
                                                  color: ColorTheme.textGrey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              TimeModel().date(
                                                  initialDate == null
                                                      ? null
                                                      : Timestamp.fromDate(
                                                          initialDate!)),
                                              style: textFamily(
                                                fontSize: 10,
                                                color: ColorTheme.textGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: wXD(10, context)),
                                      GestureDetector(
                                        onTap: () async {
                                          filter = 5;
                                          pickDate(context, onConfirm: (date) {
                                            print("date: $date");
                                            if (initialDate != null &&
                                                date != null &&
                                                date.isBefore(initialDate!)) {
                                              showToast(
                                                  "A data final não pode ser antes da inicial");
                                            } else {
                                              endDate = date;
                                            }
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: wXD(29, context),
                                              width: wXD(76, context),
                                              margin: EdgeInsets.only(
                                                  bottom: wXD(4, context)),
                                              decoration: BoxDecoration(
                                                color: Color(0xffe4e4e4),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Data final",
                                                style: textFamily(
                                                  fontSize: 10,
                                                  color: ColorTheme.textGrey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              TimeModel().date(endDate == null
                                                  ? null
                                                  : Timestamp.fromDate(
                                                      endDate!)),
                                              style: textFamily(
                                                fontSize: 10,
                                                color: ColorTheme.textGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: wXD(241, context),
                              color: ColorTheme.grey.withOpacity(.2),
                              height: wXD(.5, context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(42, context),
        width: wXD(343, context),
        padding: EdgeInsets.symmetric(horizontal: wXD(13, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: ColorTheme.lightOrange,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(0, 3),
              color: ColorTheme.totalBlack.withOpacity(.2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              "Hoje - 22/10/2021",
              style: textFamily(
                fontSize: 14,
                color: ColorTheme.primaryOrange,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                filterOverlay = getFilterOverlay();
                Overlay.of(context)!.insert(filterOverlay);
              },
              child: Text(
                "Filtros",
                style: textFamily(
                  fontSize: 10,
                  color: ColorTheme.primaryOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PerformanceAppBar extends StatelessWidget {
  final void Function(int) onTap;
  final TabController tabController;

  PerformanceAppBar(
      {Key? key, required this.onTap, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: wXD(104, context),
          padding: EdgeInsets.symmetric(horizontal: wXD(30, context)),
          width: maxWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            color: ColorTheme.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: Color(0x30000000),
              ),
            ],
          ),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Desempenho completo',
                style: textFamily(
                  fontSize: 20,
                  color: ColorTheme.darkBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: wXD(10, context)),
              DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: onTap,
                  controller: tabController,
                  indicatorColor: ColorTheme.primaryOrange,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.symmetric(vertical: 8),
                  labelColor: ColorTheme.primaryOrange,
                  labelStyle: textFamily(fontWeight: FontWeight.w400),
                  unselectedLabelColor: ColorTheme.darkGrey,
                  indicatorWeight: 3,
                  tabs: [
                    Text('Estatísticas'),
                    Text('Ganhos'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: wXD(30, context),
          top: wXD(33, context),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back,
                color: ColorTheme.darkGrey, size: wXD(25, context)),
          ),
        )
      ],
    );
  }
}
