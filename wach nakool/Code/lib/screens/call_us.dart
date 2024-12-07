import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart'; // Ensure BackArrow is defined here.
import 'help_center.dart'; // Import HelpCenter for navigation.

class CallUs extends StatefulWidget {
  const CallUs({super.key});

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  // Track the active tab
  String _activeTab = 'اتصل بنا';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFD5D69)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'مركز الدعم',
          style: TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildTabBar(), // Tab bar with navigation logic
          Expanded(
            // Wrap the ListView with Expanded
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildContactItem('Facebook', facebook),
                buildContactItem('Instagram', instagram),
                buildContactItem('WhatsApp', whatsapp),
                buildContactItem('Website', website),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTab('FAQ', onPressed: () {
            setState(() {
              _activeTab = 'FAQ'; // Mark FAQ as active
            });
            // Navigate to the FAQ page
Get.off(const HelpCenter());
          }),
          buildTab('اتصل بنا', onPressed: () {
            setState(() {
              _activeTab = 'اتصل بنا'; // Mark Call Us as active
            });
          }),
          buildTab('خدمات', onPressed: () {
            setState(() {
              _activeTab = 'خدمات'; // Handle active state for Services
            });
          }),
          buildTab('مقالات', onPressed: () {
            setState(() {
              _activeTab = 'مقالات'; // Handle active state for Articles
            });
          }),
        ],
      ),
    );
  }

  Widget buildTab(String title, {required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: _activeTab == title
            ? const Color(0xFFFFC6C9) // Highlighted background for active tab
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: _activeTab == title
              ? const Color(0xFFFD5D69) // Highlighted text color for active tab
              : Colors.grey, // Default text color for inactive tabs
        ),
      ),
    );
  }

  Widget buildContactItem(String title, Widget icon) {
    return ListTile(
      leading: icon,
      title: Text(title),
      trailing: ArrowRight,
      onTap: () {
        // You can handle tap events for each contact item here.
      },
    );
  }
}
