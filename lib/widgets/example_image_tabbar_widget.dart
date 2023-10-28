import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExampleImageTabBar extends StatefulWidget {
  const ExampleImageTabBar({super.key});

  @override
  State<ExampleImageTabBar> createState() => _ExampleImageTabBarState();
}

class _ExampleImageTabBarState extends State<ExampleImageTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  // ignore: unused_field
  late Timer _everySecond;

  @override
  void initState() {
    super.initState();

    _nestedTabController = TabController(
      length: 3,
      vsync: this,
    );

    _everySecond = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      _nestedTabController.animateTo((_nestedTabController.index + 1) % 3);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TabBar(
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Creates border
              color: Colors.blueAccent),
          labelColor: Colors.white,
          controller: _nestedTabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          tabs: [
            Tab(
              child: Text(
                "예시1",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Tab(
              child: Text(
                "예시2",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Tab(
              child: Text(
                "예시3",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: screenHeight * 0.3,
          child: TabBarView(
            controller: _nestedTabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset("assets/example1.png"),
              Image.asset("assets/example2.png"),
              Image.asset("assets/example3.png"),
            ],
          ),
        )
      ],
    );
  }
}
