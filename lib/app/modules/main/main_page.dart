import 'package:delivery_screens/shared/color_theme.dart';
import 'package:delivery_screens/shared/utilities.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_screens/app/modules/main/main_store.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ModularState<MainPage, MainStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery screens"),
        backgroundColor: ColorTheme.primaryOrange,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Tile(title: "Home", page: "/home"),
            // Tile(title: "Full Performance", page: FullPerformance()),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final String title;
  final String page;
  Tile({Key? key, required this.title, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(page),
      child: Container(
        height: wXD(50, context),
        width: maxWidth(context),
        padding: EdgeInsets.symmetric(horizontal: wXD(20, context)),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: ColorTheme.veryLightGrey))),
        child: Row(
          children: [
            Text(title, style: textFamily(fontSize: 15)),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorTheme.lightGrey,
              size: wXD(15, context),
            )
          ],
        ),
      ),
    );
  }
}
