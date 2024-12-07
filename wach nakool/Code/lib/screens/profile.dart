// import 'dart:ffi';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:mobile_project/data/functions.dart';
// import 'package:mobile_project/screens/Addreciep.dart';
// import 'package:mobile_project/screens/editprofile.dart';
// import 'package:mobile_project/screens/favoritDetails.dart';
// import 'package:mobile_project/screens/login.dart';
// import 'package:mobile_project/screens/settings.dart';
// import 'package:mobile_project/screens/utilitis.dart';
// import '../styles/style.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   int selectedIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF5F5),
//       key: _scaffoldKey,
//       endDrawer: _buildEndDrawer(),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: _buildProfileHeader(),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildActionButtons(),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildTabNavigation(),
//               ),
//               _buildRecipeContent(),
//             ],
//           ),
//           bottombar('Profile')]
//         ),
//       ),
//     );
//   }

//   Widget _buildEndDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFFC6C9), Colors.white],
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Color(0xFFFFC6C9),
//               ),
//               child: Text(
//                 'مرحبًا بك!',
//                 style: AppStyles.drawerHeaderTextStyle.copyWith(
//                   shadows: [
//                     Shadow(
//                       blurRadius: 10.0,
//                       color: Colors.black.withOpacity(0.3),
//                       offset: const Offset(2, 2),
//                     )
//                   ],
//                 ),
//                 textDirection: TextDirection.rtl,
//               ),
//             ),
//             _buildDrawerItem(Icons.settings, 'الإعدادات', () {
//               Get.to(Settings());
//             }),
//             _buildDrawerItem(Icons.logout, 'تسجيل الخروج', () {
//               Get.offAll(Login());
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFFF7646D)),
//       title: Text(
//         title,
//         textDirection: TextDirection.rtl,
//         style: const TextStyle(color: Colors.black87),
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Stack(
//         children: [
//           Row(
//             children: [
//               Hero(
//                 tag: 'profile_image',
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: const AssetImage('assets/img/defaultprofile.png'),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: const Color(0xFFFFC6C9),
//                         width: 3,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sarah Mb',
//                       style: AppStyles.profileNameStyle.copyWith(
//                         color: const Color(0xFFF7646D),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 40),
//                       child: Text(
//                         'طباخة تشارك وصفاتها اليومية لتمتعكم بكل ما تشتهون',
//                         style: AppStyles.profileDescriptionStyle,
//                         textDirection: TextDirection.rtl,
//                         textAlign:
//                             TextAlign.right, // Align the text to the right
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '@sarah233',
//                       style: AppStyles.profileUsernameStyle,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.topRight, // Position the icon at the top-right
//             child: IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
//               color: const Color(0xFFF7646D),
//             ),
//           ),
//         ],
//       ),
//     ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0);
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: () {
//                  Get.to(()=> ( EditProfile()));// Navigate to EditProfile
//               },
//               icon: const Icon(Icons.edit, color: Color(0xFFF7646D)),
//               label: const Text('تعديل الملف '),
//               style: AppStyles.editProfileButtonStyle,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: () {
//                  Get.to(()=> ( AddOnereciep()));
//               },
//               icon: const Icon(Icons.add, color: Color(0xFFF7646D)),
//               label: const Text('إضافة وصفة'),
//               style: AppStyles.editProfileButtonStyle,
//             ),
//           ),
//         ],
//       ),
//     ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0);
//   }

//   Widget _buildTabNavigation() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.spaceBetween, // Distribute items evenly
//         children: [
//           Expanded(
//             child: _buildNavItem('وصفاتي', 0),
//           ),
//           SizedBox(width: 16), // Space between the two items
//           Expanded(
//             child: _buildNavItem('المفضلة', 1),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(String title, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Column(
//         mainAxisAlignment:
//             MainAxisAlignment.center, // Align vertically in the center
//         crossAxisAlignment:
//             CrossAxisAlignment.center, // Align horizontally in the center
//         children: [
//           AnimatedDefaultTextStyle(
//             duration: const Duration(milliseconds: 300),
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: selectedIndex == index
//                   ? const Color(0xFFF7646D)
//                   : Colors.black54,
//             ),
//             child: Text(title),
//           ),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             height: 3,
//             width: selectedIndex == index ? 60 : 0,
//             color: const Color(0xFFF7646D),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecipeContent() {
//     return selectedIndex == 0
//         ? _buildGridView()
//         : SliverToBoxAdapter(child: _buildFavoritesView());
//   }

//   Widget _buildGridView() {
//     return SliverGrid(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 0,
//         mainAxisSpacing: 0,
//         childAspectRatio: 0.7,
//       ),
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return _buildRecipeItem(index);
//         },
//         childCount: 20,
//       ),
//     );
//   }

//   Widget _buildRecipeItem(int index) {
//     return Suggestions(
//             'assets/img/reci1.jpg', // image path
//             'عنوان الوصفة',
//             "باذنجان مخبوز في الفرن مع طاجن", // recipe title
//             '4.5', // stars rating
//             '30' // cooking time
//             )
//         .animate(delay: (index * 50).ms)
//         .fadeIn(duration: 250.ms)
//         .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
//   }

// // Assuming you have these variables/methods defined elsewhere

//   Widget _buildFavoritesView() {
//     // Mock grouped favorite data
//     final Map<String, List<Map<String, String>>> favoriteGroups = {
//       // 'الإفطار': [
//       //   {'image': 'assets/breakfast1.jpg', 'text': 'فطور سريع', 'description': 'وجبة خفيفة ولذيذة', 'stars': '4.5', 'time': '15'},
//       // ],
//       // 'الغداء': [
//       //   {'image': 'assets/lunch1.jpg', 'text': 'غداء صحي', 'description': 'وجبة متوازنة', 'stars': '4.7', 'time': '30'},
//       // ],
//       // 'العشاء': [
//       //   {'image': 'assets/dinner1.jpg', 'text': 'عشاء خفيف', 'description': 'وصفة مثالية للعشاء', 'stars': '4.8', 'time': '20'},
//       // ],
//     };

//     if (favoriteGroups.isEmpty) {
//       return const Center(
//         child: Text(
//           'المفضلة فارغة حاليا',
//           style: AppStyles.favoriteEmptyTextStyle,
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: favoriteGroups.length,
//       itemBuilder: (context, index) {
//         final groupName = favoriteGroups.keys.elementAt(index);
//         final groupRecipes = favoriteGroups[groupName];

//         // Safety check: If groupRecipes is null, return an empty widget
//         if (groupRecipes == null) {
//           return Text(
//               "msvkn;dslkjvnsdoa;v"); // Return an empty widget for the null case
//         }

//         return GestureDetector(
//           onTap: () {
//   Get.to(()=> ( FavoriteGroupScreen(
//                   groupName: groupName,
//                   recipes: groupRecipes,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   groupName,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const Icon(Icons.arrow_forward_ios, color: Colors.red),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_project/data/functions.dart';
import 'package:mobile_project/screens/Addreciep.dart';
import 'package:mobile_project/screens/editprofile.dart';
import 'package:mobile_project/screens/favoritDetails.dart';
import 'package:mobile_project/screens/login.dart';
import 'package:mobile_project/screens/settings.dart';
import 'package:mobile_project/screens/utilitis.dart';
import '../styles/style.dart';
import '../data/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var username = userController.username.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      key: _scaffoldKey,
      endDrawer: _buildEndDrawer(),
      body: SafeArea(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildProfileHeader(),
              ),
              SliverToBoxAdapter(
                child: _buildActionButtons(),
              ),
              SliverToBoxAdapter(
                child: _buildTabNavigation(),
              ),
              _buildRecipeContent(),
            ],
          ),
          bottombar('Profile')
        ]),
      ),
    );
  }

  Widget _buildEndDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFC6C9), Colors.white],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFFC6C9),
              ),
              child: Text(
                'مرحبًا بك!',
                style: AppStyles.drawerHeaderTextStyle.copyWith(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            _buildDrawerItem(Icons.settings, 'الإعدادات', () {
              Get.to(const Settings());
            }),
            _buildDrawerItem(Icons.logout, 'تسجيل الخروج', () {
              Get.offAll(const Login());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFF7646D)),
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        style: const TextStyle(color: Colors.black87),
      ),
      onTap: onTap,
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Row(
            children: [
              Hero(
                tag: 'profile_image',
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      const AssetImage('assets/img/defaultprofile.png'),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFC6C9),
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username, // Use dynamic username
                      style: AppStyles.profileNameStyle.copyWith(
                        color: const Color(0xFFF7646D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        'طباخة تشارك وصفاتها اليومية لتمتعكم بكل ما تشتهون',
                        style: AppStyles.profileDescriptionStyle,
                        textDirection: TextDirection.rtl,
                        textAlign:
                            TextAlign.right, // Align the text to the right
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@$username', // Dynamic username with @ symbol
                      style: AppStyles.profileUsernameStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight, // Position the icon at the top-right
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              color: const Color(0xFFF7646D),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0);
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const EditProfile()); // Navigate to EditProfile
              },
              icon: const Icon(Icons.edit, color: Color(0xFFF7646D)),
              label: const Text('تعديل الملف '),
              style: AppStyles.editProfileButtonStyle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const AddOnereciep());
              },
              icon: const Icon(Icons.add, color: Color(0xFFF7646D)),
              label: const Text('إضافة وصفة'),
              style: AppStyles.editProfileButtonStyle,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0);
  }

  Widget _buildTabNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Distribute items evenly
        children: [
          Expanded(
            child: _buildNavItem('وصفاتي', 0),
          ),
          const SizedBox(width: 16), // Space between the two items
          Expanded(
            child: _buildNavItem('المفضلة', 1),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Align vertically in the center
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align horizontally in the center
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: selectedIndex == index
                  ? const Color(0xFFF7646D)
                  : Colors.black54,
            ),
            child: Text(title),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3,
            width: selectedIndex == index ? 60 : 0,
            color: const Color(0xFFF7646D),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeContent() {
    return selectedIndex == 0
        ? _buildGridView()
        : SliverToBoxAdapter(child: _buildFavoritesView());
  }

  Widget _buildGridView() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildRecipeItem(index);
        },
        childCount: 20,
      ),
    );
  }

  Widget _buildRecipeItem(int index) {
    return Suggestions(
            'assets/img/reci1.jpg', // image path
            'عنوان الوصفة',
            "باذنجان مخبوز في الفرن مع طاجن", // recipe title
            '4.5', // stars rating
            '30' // cooking time
            )
        .animate(delay: (index * 50).ms)
        .fadeIn(duration: 250.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildFavoritesView() {
    // Mock grouped favorite data
    final Map<String, List<Map<String, String>>> favoriteGroups = {
      // 'الإفطار': [
      //   {'image': 'assets/breakfast1.jpg', 'text': 'فطور سريع', 'description': 'وجبة خفيفة ولذيذة', 'stars': '4.5', 'time': '15'},
      // ],
      // 'الغداء': [
      //   {'image': 'assets/lunch1.jpg', 'text': 'غداء صحي', 'description': 'وجبة متوازنة', 'stars': '4.7', 'time': '30'},
      // ],
      // 'العشاء': [
      //   {'image': 'assets/dinner1.jpg', 'text': 'عشاء خفيف', 'description': 'وصفة مثالية للعشاء', 'stars': '4.8', 'time': '20'},
      // ],
    };

    if (favoriteGroups.isEmpty) {
      return const Center(
        child: Text(
          'المفضلة فارغة حاليا',
          style: AppStyles.favoriteEmptyTextStyle,
        ),
      );
    }

    return ListView.builder(
      itemCount: favoriteGroups.length,
      itemBuilder: (context, index) {
        final groupName = favoriteGroups.keys.elementAt(index);
        final groupRecipes = favoriteGroups[groupName];

        // Safety check: If groupRecipes is null, return an empty widget
        if (groupRecipes == null) {
          return const Text(
              "msvkn;dslkjvnsdoa;v"); // Return an empty widget for the null case
        }

        return GestureDetector(
          onTap: () {
            Get.to(() => FavoriteGroupScreen(
                  groupName: groupName,
                  recipes: groupRecipes,
                ));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.red),
              ],
            ),
          ),
        );
      },
    );
  }
}
