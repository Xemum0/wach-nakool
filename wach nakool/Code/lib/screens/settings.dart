import 'package:get/get.dart';
import 'package:mobile_project/screens/login.dart';
import 'package:mobile_project/screens/notifications_settings.dart';
import 'package:mobile_project/screens/security.dart';
import 'package:mobile_project/screens/help_center.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/data/icons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: BackArrow,
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text(
          'الإعدادات',
          style:
              TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildSettingsItem(notification, 'الاشعارات'),
          buildSettingsItem(help_center, 'مركز الدعم'),
          buildSettingsItem(security, 'سياسة الخصوصية والأمان'),
          buildSettingsItem(logout, 'تسجيل الخروج', isLogout: true),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showDeleteAccountConfirmation(context); // Show delete account popup
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                'حذف الحساب',
                style: TextStyle(
                    color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      
    );
  }

  // Widget buildSettingsItem(var icon, String title, {bool isLogout = false}) {
  //   return ListTile(
  //     leading: icon,
  //     title: Text(
  //       title,
  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //     ),
  //     trailing: isLogout ? null : ArrowRight,
  //     onTap: () {
  //       if (isLogout) {
  //         showLogoutConfirmation(context); // Show the logout popup
  //       }
  //     },
  //   );
  // }

  Widget buildSettingsItem(var icon, String title, {bool isLogout = false}) {
  return ListTile(
    leading: icon,
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    trailing: isLogout ? null : ArrowRight,
    onTap: () {
      if (isLogout) {
        showLogoutConfirmation(context); // Show the logout popup
      } else {
        // Navigate to the corresponding screen
        switch (title) {
          case 'الاشعارات':
         Get.to(const NotificationsSettingsPage());
            break;
          case 'مركز الدعم':
Get.to(const HelpCenter());
            break;
          case 'سياسة الخصوصية والأمان':
Get.to(const Security());
            break;
          default:
            break;
        }
      }
    },
  );
}


  void showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return buildConfirmationPopup(
          context,
          title: 'نهاية الجلسة',
          message: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
          confirmButtonText: 'نعم، إنهاء الجلسة',
          onConfirm: () {
            Navigator.pop(context); // Close the popup
           
           
            // Add your logout logic here
           Get.offAll(const Login());
            print('User logged out!');
          },
        );
      },
    );
  }

  void showDeleteAccountConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return buildConfirmationPopup(
          context,
          title: 'حذف الحساب',
          message: 'هل أنت متأكد أنك تريد حذف حسابك؟\nلن تتمكن من استعادة الحساب مرة أخرى.',
          confirmButtonText: 'نعم، حذف الحساب',
          onConfirm: () {
            Navigator.pop(context); // Close the popup
            // Add your delete account logic here
           
                      Get.offAll(const Login());
            print('Account deleted!');
          },
        );
      },
    );
  }

  Widget buildConfirmationPopup(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmButtonText,
    required VoidCallback onConfirm,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(120, 45),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the popup
                },
                child: const Text(
                  'إلغاء',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD5D69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(120, 45),
                ),
                onPressed: onConfirm, // Trigger the confirmation action
                child: Text(
                  confirmButtonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
