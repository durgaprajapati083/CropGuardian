import 'package:flutter/material.dart';

import '../../Widgets/app_drawer.dart';
import 'widgets/feature_card.dart';
import 'widgets/hero_section.dart';
import 'widgets/stats_row.dart';
import 'widgets/trust_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FFF8),
      drawer: AppDrawer(selectedIndex: 0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 45),
          child: Row(
            children: [
              Image.asset('assets/images/flogo.png',height: 35,width: 35,),
              SizedBox(width: 10,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "CropGuardian",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("कृषि रक्षक",style: TextStyle(color: Colors.green, fontSize: 18)),
                    ),
                  ]
              ),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu, color: Colors.black),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            StatsRow(),
            FeatureSection(),
            TrustSection(),
          ],
        ),
      ),
    );
  }
}
