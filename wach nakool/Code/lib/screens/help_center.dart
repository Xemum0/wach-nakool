import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'call_us.dart'; // Import your CallUs page

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  // To track which tab is active
  String _activeTab = 'FAQ';

  // Track expanded state for each item in the list
  final List<bool> _isExpandedList = List<bool>.filled(8, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: BackArrow,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'مركز الدعم',
          style:
              TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildTabBar(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.pink[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintStyle: const TextStyle(color: Colors.red),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _isExpandedList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: const Text('Lorem ipsum dolor sit amet?'),
                      trailing: Icon(
                        _isExpandedList[index]
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        setState(() {
                          // Toggle the expanded state for the tapped item
                          _isExpandedList[index] = !_isExpandedList[index];
                        });
                      },
                    ),
                    if (_isExpandedList[index])
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                  ],
                );
              },
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
          }),
          buildTab('اتصل بنا', onPressed: () {
            setState(() {
              _activeTab = 'اتصل بنا'; // Mark Call Us as active
            });
        Get.off(const CallUs());
          }),
          buildTab('خدمات', onPressed: () {
            setState(() {
              _activeTab = 'خدمات'; // Mark Services as active
            });
          }),
          buildTab('مقالات', onPressed: () {
            setState(() {
              _activeTab = 'مقالات'; // Mark Articles as active
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
            ? const Color(0xFFFFC6C9)
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: _activeTab == title ? const Color(0xFFFD5D69) : Colors.grey,
        ),
      ),
    );
  }
}
