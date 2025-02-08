import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_project/data/functions.dart';
import 'package:mobile_project/screens/Addreciep.dart';
import 'package:mobile_project/screens/dish.dart';
import 'package:mobile_project/screens/editprofile.dart';
import 'package:mobile_project/screens/favoritDetails.dart';
import 'package:mobile_project/screens/login.dart';
import 'package:mobile_project/screens/settings.dart';
import 'package:mobile_project/screens/utilitis.dart';
import 'package:mobile_project/supabase/reciepes.dart';
import 'package:mobile_project/supabase/user.dart';
import '../styles/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic>? userProfile;
  List<dynamic>? userRecipes;
  List<dynamic>? userFavorites;
  String userId = "1"; // Replace with actual user ID
  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _fetchUserRecipes();
    _fetchUserFavorites();
  }

  Future<void> _fetchUserProfile() async {
    
    Map<String, dynamic>? profile = await getUserProfile(userId);
    if (profile != null) {
      setState(() {
        userProfile = profile;
      });
    }
  }

  Future<void> _fetchUserRecipes() async {
    
    Map<String, dynamic>? response = await getUserRecipes(userId);
    if (response != null) {
      setState(() {
        userRecipes = response['recipes'].reversed.toList();
      });
    }
  }

  Future<void> _fetchUserFavorites() async {
    
    Map<String, dynamic>? response = await getUserFavorites(userId);
    if (response != null) {
      setState(() {
        userFavorites = response['recipes'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      key: _scaffoldKey,
      endDrawer: _buildEndDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
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
          ],
        ),
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
              Get.to(Settings());
            }),
            _buildDrawerItem(Icons.logout, 'تسجيل الخروج', () {
              Get.offAll(Login());
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
                  backgroundImage: userProfile?['profile_img'] != null
                      ? NetworkImage(userProfile!['profile_img'])
                      : AssetImage('assets/img/defaultprofile.png')
                          as ImageProvider,
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
                      userProfile?['full_name'] ?? 'Sarah Mb',
                      style: AppStyles.profileNameStyle.copyWith(
                        color: const Color(0xFFF7646D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        userProfile?['bio'] ??
                            'طباخة تشارك وصفاتها اليومية لتمتعكم بكل ما تشتهون',
                        style: AppStyles.profileDescriptionStyle,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userProfile?['username'] ?? '@sarah233',
                      style: AppStyles.profileUsernameStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
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
                Get.to(() => EditProfile(imagePath: userProfile?['profile_img'] ?? '', username: userProfile?['username'] ?? '', bio: userProfile?['bio'] ?? '', fullName: userProfile?['full_name'] ?? '', userID: userId));
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
                Get.to(() => AddOnereciep());
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildNavItem('وصفاتي', 0),
          ),
          const SizedBox(width: 16),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
    return selectedIndex == 0 ? _buildGridView() : _buildFavoritesView();
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
        childCount: userRecipes?.length ?? 0,
      ),
    );
  }

Widget _buildRecipeItem(int index) {
  final recipe = userRecipes?[index];

  return GestureDetector(
    onTap: () {
      if (recipe != null) {
        Map<String, dynamic> dataS = {'id': recipe['id']};  
        Get.to(() => const PopularDishe(), arguments: dataS);
      }
    },
    child: Suggestions(
      recipe?['Media']?["images"]?[0]?.toString() ?? 'assets/img/reci1.jpg',
      recipe?['title']?.toString() ?? 'عنوان الوصفة',
      recipe?['description']?.toString() ?? "باذنجان مخبوز في الفرن مع طاجن",
      recipe?['rating']?.toString() ?? '4.5',
      recipe?['time']?.toString() ?? '30',
    )
        .animate(delay: (index * 50).ms)
        .fadeIn(duration: 250.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
  );
}

Widget _buildFavoritesView() {
  if (userFavorites == null || userFavorites!.isEmpty) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          'المفضلة فارغة حاليا',
          style: AppStyles.favoriteEmptyTextStyle,
        ),
      ),
    );
  }

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final recipe = userFavorites![index];
        final imageUrl = recipe['Media']?["images"]?[0]?.toString();

        return GestureDetector(
          onTap: () {
            // Navigate to the recipe details screen
            // Get.to(() => FavoriteDetailsScreen(recipe: recipe));
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl != null && imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/reci1.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          imageUrl ?? 'assets/img/reci1.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe['title']?.toString() ?? 'عنوان الوصفة',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe['description']?.toString() ?? "وصفة لذيذة",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            recipe['rating']?.toString() ?? '4.5',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.timer, color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            recipe['time']?.toString() ?? '30',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      childCount: userFavorites!.length,
    ),
  );
}}
