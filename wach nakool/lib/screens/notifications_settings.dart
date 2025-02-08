// import 'package:flutter/material.dart';
// import 'package:mobile_project/data/icons.dart';
// class NotificationsSettingsPage extends StatefulWidget {
//   const NotificationsSettingsPage({super.key});

//   @override
//   State<NotificationsSettingsPage> createState() =>
//       _NotificationsSettingsPageState();
// }

// class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: BackArrow,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'الإشعارات',
//           style:
//               TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           buildNotificationToggle('إشعارات عامة', true),
//           buildNotificationToggle('الأصوات', false),
//           buildNotificationToggle('الإهتزازات', true),
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   type: BottomNavigationBarType.fixed,
//       //   selectedItemColor: Color(0xFFFD5D69),
//       //   unselectedItemColor: Colors.grey,
//       //   items: [
//       //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//       //     BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
//       //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
//       //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//       //   ],
//       // ),
//     );
//   }

//   Widget buildNotificationToggle(String title, bool value) {
//     return SwitchListTile(
//       title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//       value: value,
//       activeColor: Color(0xFFFD5D69),
//       onChanged: (newValue) {},
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_project/data/icons.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  // State variables for switches
  bool _generalNotifications = true;
  bool _sounds = false;
  bool _vibrations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: BackArrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'الإشعارات',
          style:
              TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildNotificationToggle(
              'إشعارات عامة', _generalNotifications, (newValue) {
            setState(() {
              _generalNotifications = newValue;
            });
          }),
          buildNotificationToggle('الأصوات', _sounds, (newValue) {
            setState(() {
              _sounds = newValue;
            });
          }),
          buildNotificationToggle('الإهتزازات', _vibrations, (newValue) {
            setState(() {
              _vibrations = newValue;
            });
          }),
        ],
      ),
    );
  }

  Widget buildNotificationToggle(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      value: value,
      activeColor: const Color(0xFFFD5D69),
      onChanged: onChanged,
    );
  }
}
