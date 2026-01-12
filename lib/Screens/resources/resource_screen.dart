import 'package:flutter/material.dart';
import 'pages/government_schemes_page.dart';
import 'pages/learning_resources_page.dart';
import 'pages/market_prices_page.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;
  String searchQuery = ""; // This holds the search text

  void _onTabTap(int index) {
    setState(() => selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F5),
      body: Column(
        children: [
          // Header Section with Search
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20, right: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Farmer Resources",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text("किसान संसाधन केंद्र", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 20),
                // SEARCH INPUT
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase(); // Updates search in real-time
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search alphabetically... / खोजें...",
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF1B5E20)),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => searchQuery = "");
                          })
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          _buildTabs(),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => selectedIndex = index),
              children: [
                GovernmentSchemesPage(searchQuery: searchQuery),
                MarketPricesPage(searchQuery: searchQuery),
                LearningResourcesPage(searchQuery: searchQuery),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tabItem(0, "Schemes", Icons.gavel_rounded),
          _tabItem(1, "Market", Icons.trending_up_rounded),
          _tabItem(2, "Learning", Icons.auto_stories_rounded),
        ],
      ),
    );
  }

  Widget _tabItem(int index, String label, IconData icon) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.green.shade100),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.green),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}