import 'package:croupguardiandurgaprajapati/responsive_page.dart';
import 'package:flutter/material.dart';

class WebDashboard extends StatelessWidget {
  const WebDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Scaffold(
        body: Row(
          children: [
            // Side Navigation Bar for Web
            NavigationRail(
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.analytics), label: Text('Diagnosis')),
              ],
              selectedIndex: 0,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // Main Content Area
            const Expanded(child: Center(child: Text("Welcome to Crop Guardian Web"))),
          ],
        ),
      ),
    );
  }
}