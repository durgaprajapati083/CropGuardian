import 'package:croupguardiandurgaprajapati/Screens/resources/widgets/app_footer.dart';
import 'package:flutter/material.dart';
import 'data/organic_database.dart';
import 'models/organic_item.dart';
import 'widgests/organic_solution_card.dart';

class OrganicSolutionPage extends StatefulWidget {
  const OrganicSolutionPage({super.key});

  @override
  State<OrganicSolutionPage> createState() => _OrganicSolutionPageState();
}

class _OrganicSolutionPageState extends State<OrganicSolutionPage> {
  List<OrganicItem> displayList = List.from(OrganicDatabase.items);

  void _search(String value) {
    setState(() {
      displayList = OrganicDatabase.items
          .where((item) =>
      item.title.toLowerCase().contains(value.toLowerCase()) ||
          item.problem.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B5E20),
        title: const Text("Organic Medicine", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Crop or Problem...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1B5E20)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: displayList.length,
              itemBuilder: (context, index) => OrganicSolutionCard(item: displayList[index]),
            ),
            AppFooter()
          ],
        ),
      ),
    );
  }
}