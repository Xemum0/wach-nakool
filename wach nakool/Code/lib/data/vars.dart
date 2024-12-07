import 'icons.dart';
bool showSearch_bar = false;
bool bottom = true;
double height = 350;
bool entering_ingredients = false;
List Favourite=[Favourite_Button,Favourite_Button_Selected];
List search_suggestions = [
  'كسكس',
  'تيراميسو أرز',
  'سندويش دجاج',
  'الطوابع',
  'مقروض',
  'شربة',
  'مسفوف',
  'رفيس',
  'لوبيا'
];
List<Map<String, dynamic>> ingridients = [];

List nav_bar_filters = [
  {'txt': 'فطور', 'selected': true},
  {'txt': 'غداء', 'selected': false},
  {'txt': 'عشاء', 'selected': false},
  {'txt': 'أكل نباتي', 'selected': false}
];

List search_result = [
  {
    'image': 'assets/homescreen/pasta.png',
    'text': 'معكرونة البشاميل ',
    'subtext': 'كريمة ولذيذة',
    'time': '30',
    'stars': '4',
  },
  {
    'image': 'assets/homescreen/meat.png',
    'text': 'أسياخ مشوية',
    'subtext': 'قطع شهية',
    'time': '30',
    'stars': '4',
  },
  {
    'image': 'assets/homescreen/cake.png',
    'text': 'كعكة براوني الجوز',
    'subtext': 'حلوى غنية ولذيذة...',
    'time': '30',
    'stars': '4',
  },
  {
    'image': 'assets/homescreen/panckakes.png',
    'text': 'فطائر الشوفان',
    'subtext': 'تقدم هذه المأكولات الشهية المغذية...',
    'time': '30',
    'stars': '4',
  },
];

List<Map<String, String>> categories = [
  {
    'image': 'assets/homescreen/bourek.png',
    'text': 'عشاء',
  },
  {
    'image': 'assets/homescreen/gaufre.png',
    'text': 'افطار',
  },
  {
    'image': 'assets/homescreen/panini.png',
    'text': 'أكل سريع',
  },
  {
    'image': 'assets/homescreen/lasagna.png',
    'text': 'أكل نباتي',
  },
  {
    'image': 'assets/homescreen/macaron.png',
    'text': 'مقبلات',
  },
  {
    'image': 'assets/homescreen/mojito2.png',
    'text': 'مشروبات',
  },
];
