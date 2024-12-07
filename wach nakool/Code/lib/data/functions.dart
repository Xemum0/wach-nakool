import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'package:mobile_project/screens/home.dart';
import 'package:mobile_project/screens/profile.dart';
import '../screens/search_result.dart';
import 'vars.dart';
import 'colors_fonts.dart';
import '../screens/dish.dart';
import 'package:mobile_project/screens/categories.dart';
import '../screens/notifications.dart';

Widget bottombar(currentpage) {
  var icons = {
    'home': currentpage == 'home' ? Homepage_Selected : Homepage,
    'Community': currentpage == 'Community' ? Community_Selected : Community,
    'Categories': currentpage == 'categorypage' || currentpage == 'categories'
        ? Categories_Selected
        : Categories_,
    'Profile': currentpage == 'Profile' ? Profile2 : Profile,
  };
  return Container(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    height: double.infinity,
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(253, 93, 105, 1),
          ),
          height: 50,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    showSearch_bar = false;
                    if (currentpage == 'categorypage' ||
                        currentpage == 'categories' ||
                        currentpage == 'search_results') {
                      Get.offAll(() => (const Home()),
                          transition: Transition.upToDown,
                          duration: const Duration(milliseconds: 500));
                    } else if (currentpage == 'home') {
                    } else {
                      Get.to(() => (const Home()),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 500));
                    }
                  },
                  icon: icons['home']!),
              IconButton(
                  onPressed: () {
                    showSearch_bar = false;
                    Get.to(() => (Notifications()),
                        transition: Transition.downToUp,
                        duration: Duration(milliseconds: 500));
                  },
                  icon: icons['Community']!),
              IconButton(
                  onPressed: () {
                    showSearch_bar = false;
                    if (currentpage != 'categorypage' ||
                        currentpage != 'home') {
                      Get.to(() => (const Categories()),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 500));
                    } else if (currentpage == 'categorypage') {
                    } else if (currentpage == 'home') {
                      Get.off(() => (const Categories()),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 500));
                    } else {
                      Get.to(() => (const Categories()),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 500));
                    }
                  },
                  icon: icons['Categories']!),
              IconButton(
                  onPressed: () {
                    showSearch_bar = false;
                    Get.to(() => (ProfileScreen()),
                        transition: Transition.leftToRightWithFade,
                        duration: Duration(milliseconds: 500));
                  },
                  icon: icons['Profile']!),
            ],
          ),
        )
      ],
    ),
  );
}

Widget get_custom_search_bar(object, Widget Text, go_back) {
  if (!go_back) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
        ),
        Padding(padding: const EdgeInsets.fromLTRB(25, 10, 0, 10), child: Text),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Center(
                  child: IconButton(
                      onPressed: () => {
                            Get.to(() => (const Notifications()),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500))
                          },
                      icon: Notifications_Icon)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                    child: IconButton(
                        onPressed: () {
                          showSearch_bar = true;
                          object.setState(() {});
                        },
                        icon: Search_Icon)),
              )
            ],
          ),
        )
      ],
    );
  } else
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Go_Back_Arrow),
        Text,
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Center(
                  child: IconButton(
                      onPressed: () => {
                            Get.to(() => (const Notifications()),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500))
                          },
                      icon: Notifications_Icon)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                    child: IconButton(
                        onPressed: () {
                          showSearch_bar = true;
                          object.setState(() {});
                        },
                        icon: Search_Icon)),
              )
            ],
          ),
        )
      ],
    );
}

Widget Extendedsearch(object, context) {
  return GestureDetector(
    onTap: () {
      showSearch_bar = true;
      FocusScope.of(context).unfocus();
      bottom = true;
    },
    child: Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 30,
              width: 250,
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: TextField(
                onTap: () {
                  bottom = false;
                  object.setState(() {});
                },
                onSubmitted: (value) {
                  if (!entering_ingredients) {
                    ingridients.clear();
                    entering_ingredients = false;
                    Get.to(() => (const Search_result()),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 500));
                  } else {
                    for (int i = 0; i < ingridients.length; i++) {
                      if (ingridients[i]['ingridient'] == value || value == '')
                        return;
                    }
                    ingridients
                        .add({'ingridient': value.toString(), 'quantity': 50});
                    height += 80;
                    object.setState(() {});
                  }
                },
                decoration: InputDecoration(
                  filled: true, // Enable filling the background
                  fillColor: const Color.fromRGBO(255, 198, 201, 1),
                  hintText: '...بحث',
                  hintStyle: TextStyle(fontFamily: myfont, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none, // No border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none, // No border when focused
                  ),
                  alignLabelWithHint: true, // Align hint text with label
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10), // Adjust vertical padding to center
                  // Reduce the height of the field, making it more compact
                ),
                textAlign: TextAlign.right, // Align text to the right
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 65, 0),
                  child: Text('طبخات مقترحة'),
                )
              ],
            ),
          ),
          for (int i = 0; i < search_suggestions.length; i += 3)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getsuggestions(search_suggestions[i], false, context),
                  getsuggestions(search_suggestions[i + 1], false, context),
                  getsuggestions(search_suggestions[i + 2], false, context),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Center(
                        child: Text(
                      "+",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                  child: Text(
                    'أضف حساسية',
                  ),
                ),
              ],
            ),
          ),
          if (entering_ingredients)
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Text(
                      ':قائمة المكونات المضافة',
                    ),
                  ),
                ],
              ),
            ),
          for (int i = 0; i < ingridients.length; i++)
            get_ingridient_measure(i, context, object),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!entering_ingredients)
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mycolor,
                        ),
                        onPressed: () {
                          entering_ingredients = true;
                          object.setState(() {});
                        },
                        child: Text(
                          'ادخال مكونات',
                          style: TextStyle(
                              fontFamily: myfont,
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mycolor,
                      ),
                      onPressed: () {
                        object.setState(() {
                          entering_ingredients = false;
                          height -= 80 * ingridients.length;
                          ingridients.clear();
                          showSearch_bar = false;
                        });
                        Get.to(() => (const Search_result()),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: Text(
                        'بحث',
                        style: TextStyle(
                            fontFamily: myfont,
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget get_ingridient_measure(id, context, object) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 200, 199, 199),
              borderRadius: BorderRadius.circular(30)),
          width: MediaQuery.sizeOf(context).width * 0.87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (ingridients[id]['quantity'] > 0) {
                      ingridients[id]['quantity'] -= 50;
                    }
                    object.setState(() {});
                  },
                  child: Text(
                    "-",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  ingridients[id]['quantity'].toString() + "   g",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontFamily: myfont, fontSize: 20),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (ingridients[id]['quantity'] < 1000) {
                      ingridients[id]['quantity'] += 50;
                    }
                    object.setState(() {});
                  },
                  child: Text(
                    "+",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                    child: Text(
                  ingridients[id]['ingridient'],
                  style: TextStyle(fontFamily: myfont, fontSize: 20),
                )),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 200, 199, 199),
              borderRadius: BorderRadius.circular(30)),
          width: MediaQuery.sizeOf(context).width * 0.12,
          height: MediaQuery.sizeOf(context).width * 0.12,
          child: IconButton(
            icon: trash,
            onPressed: () {
              ingridients.removeAt(id);
              height -= 80;
              object.setState(() {});
            },
          ),
        )
      ],
    ),
  );
}

Widget getoptions(id, text, selected, object) {
  if (selected) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 60,
          decoration: BoxDecoration(
              color: mycolor, borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontFamily: myfont,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: GestureDetector(
        onTap: () {
          for (int i = 0; i < 4; i++) {
            nav_bar_filters[i]['selected'] = false;
          }
          nav_bar_filters[id]['selected'] = true;
          //WE APLLY FILTERS ON OUR DATA IN ORDER TO DISPLAY IT
          object.setState(() {});
        },
        child: SizedBox(
          width: 60,
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontFamily: myfont,
                fontSize: 16,
                color: mycolor,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}

Widget suggestions(
    favourites, id, image, text, subtext, stars, time, context, object) {
  return GestureDetector(
    onTap: () {
      Map<String, dynamic> dataS = {
        'id': id,
        'title': text,
        'stars': stars,
        'time': time,
        'image': image
      };
      print(dataS.runtimeType);
      Get.to(() => (const PopularDishe()), arguments: dataS);
      //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
      // setState(() {

      // });
    },
    child: Column(
      children: [
        Stack(children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.45,
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      if (favourites[id] == Favourite[0]) {
                        favourites[id] = Favourite[1];
                      } else {
                        favourites[id] = Favourite[0];
                      }
                      object.setState(() {});
                    },
                    icon: favourites[id])
              ],
            ),
          )
        ]),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.42,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: mycolor),
                  left: BorderSide(color: mycolor),
                  right: BorderSide(color: mycolor)),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  child: Text(
                    text,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  child: Text(
                    subtext,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          stars,
                          style: TextStyle(fontSize: 18, color: mycolor),
                        ),
                      ),
                      Star_Red
                    ],
                  ),
                  Row(
                    children: [
                      Time_Red,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          time + ' mins',
                          style: TextStyle(fontSize: 16, color: mycolor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget get_row(favourites, i, search_results, context, object) {
  if (i + 1 < search_results.length) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          suggestions(
              favourites,
              i,
              search_results[i]['image'],
              search_results[i]['text'],
              search_results[i]['subtext'],
              search_results[i]['stars'],
              search_results[i]['time'],
              context,
              object),
          suggestions(
              favourites,
              i + 1,
              search_results[i + 1]['image'],
              search_results[i + 1]['text'],
              search_results[i + 1]['subtext'],
              search_results[i + 1]['stars'],
              search_results[i + 1]['time'],
              context,
              object),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          suggestions(
              favourites,
              i,
              search_result[i]['image'],
              search_result[i]['text'],
              search_result[i]['subtext'],
              search_result[i]['stars'],
              search_result[i]['time'],
              context,
              object),
        ],
      ),
    );
  }
}

Widget getsuggestions(text, selected, object) {
  {
    return GestureDetector(
      onTap: () {
        ingridients.clear();
        entering_ingredients = false;
        showSearch_bar = false;
        Get.to(() => (const Search_result()), arguments: text);
        object.setState(() {});
        //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
        // setState(() {

        // });
      },
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 198, 201, 1),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontFamily: myfont,
              fontSize: 12,
              color: mycolor,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

int getwordsindex(int num, String word) {
  print(word);
  int index = 0;
  int n = 0;
  for (int i = 0; i < word.length; i++) {
    index++;
    if (word[i] == ' ') {
      n++;
    }
    if (n == num) {
      break;
    }
  }
  return index;
}
