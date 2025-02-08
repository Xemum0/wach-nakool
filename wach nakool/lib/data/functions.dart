import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:mobile_project/data/icons.dart';
import 'package:mobile_project/screens/home/home_skeleton.dart';
import 'package:mobile_project/screens/profile.dart';
import 'package:mobile_project/supabase/apis/ingridients.dart';
import 'package:mobile_project/supabase/reciepes.dart';
import '../screens/search_result.dart';
import 'vars.dart';
import 'colors_fonts.dart';
import '../screens/dish.dart';
import 'package:mobile_project/screens/categories/categories.dart';
import '../screens/notifications.dart';
import 'package:mobile_project/supabase/user.dart';
import '../screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                  onPressed: () async {
                    showSearch_bar = false;

                    // Get the current user asynchronously
                    final currentUser = await UserHelper.getCurrentUser();

                    // Navigate based on whether a user is logged in
                    if (currentUser == null) {
                      Get.to(
                        () => RegistrationPage(),
                        transition: Transition.leftToRightWithFade,
                        duration: Duration(milliseconds: 500),
                      );
                    } else {
                      Get.to(
                        () => ProfileScreen(),
                        transition: Transition.leftToRightWithFade,
                        duration: Duration(milliseconds: 500),
                      );
                    }
                  },
                  icon: icons['Profile']!),
            ],
          ),
        )
      ],
    ),
  );
}
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

Widget get_custom_search_bar(object, Widget Text, goBack) {
  if (!goBack) {
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
  } else {
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
}

Widget Extendedsearch(object, context) {
  // final TextEditingController _controller = TextEditingController();

  return GestureDetector(
    onTap: () {
      showSearch_bar = true;
      FocusScope.of(context).unfocus();
    },
    child: Container(

      height: get_custom_height(context),
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
                //controller: _controller,
                onTap: () {
                  object.setState(() {});
                },
                onChanged: (value) {
                  search_bar_text = value;

                  if (entering_ingredients) {
                    ingridients_suggestions =
                        Ingridients_Helper.Search_Ingridients(value);
                  } else {
                    if (value.length >= 3) {
                      reciepes_suggestions =
                          Reciepe_Helper.Get_Reciepes_By_Name(value, true);
                    }
                  }
                  object.setState(() {});
                },

                onSubmitted: (value) {
                  showSearch_bar = false;

                  if (!entering_ingredients) {
                    search_bar_text = value;
                    ingridients.clear();
                    entering_ingredients = false;
                    Get.to(() => (const Search_result()),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 500),
                        arguments: {
                          'type': 'byname',
                          'title': search_bar_text
                        });
                    search_bar_text = '';
                    object.setState(() {});
                  }
                  //               else{
                  //                 for (int i=0;i<ingridients.length;i++){
                  //                   if(ingridients[i]['ingridient']==value||value=='')
                  //                   return;
                  //                 }
                  //                 ingridients.add({'ingridient':value.toString(),'quantity':50});
                  //                 height+=80;
                  //                    object.setState(() {

                  // });
                  //               }   },
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
          if (entering_ingredients)
            SizedBox(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text('مكونات مقترحة'),
                    ),
                  ],
                ),
              ),
            ),
          if (!entering_ingredients)
            SizedBox(
              child: const Padding(
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
            ),
          if (entering_ingredients && search_bar_text.isNotEmpty)
            FutureBuilder(
                future: ingridients_suggestions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      for (int i = 0; i < snapshot.data!.length; i += 3)
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (contains_map((snapshot.data![i])) == false)
                                  get_search_suggestions(
                                      snapshot.data![i], false, object, false),
                                if (contains_map((snapshot.data![i])) == true)
                                  get_search_suggestions(
                                      snapshot.data![i], false, object, true),
                                if (i + 1 < snapshot.data!.length)
                                  if (contains_map((snapshot.data![i + 1])) ==
                                      false)
                                    get_search_suggestions(snapshot.data![i + 1],
                                        false, object, false),
                                if (i + 1 < snapshot.data!.length)
                                  if (contains_map((snapshot.data![i + 1])) ==
                                      true)
                                    get_search_suggestions(snapshot.data![i + 1],
                                        false, object, true),
                                if (i + 2 < snapshot.data!.length)
                                  if (contains_map((snapshot.data![i + 2])) ==
                                      false)
                                    get_search_suggestions(snapshot.data![i + 2],
                                        false, object, false),
                                if (i + 2 < snapshot.data!.length)
                                  if (contains_map((snapshot.data![i + 2])) ==
                                      true)
                                    get_search_suggestions(snapshot.data![i + 2],
                                        false, object, true),
                              ],
                            ),
                          ),
                        ),
                    ]);
                  } else {
                    return SizedBox(child: Center());
                  }
                }),
          if (!entering_ingredients && search_bar_text.length >= 3)
            FutureBuilder(
                future: reciepes_suggestions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      for (int i = 0; i < snapshot.data!.length; i += 3)
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                get_search_suggestions(
                                    snapshot.data![i], true, object, false),
                                if (i + 1 < snapshot.data!.length)
                                  get_search_suggestions(
                                      snapshot.data![i + 1], true, object, false),
                                if (i + 2 < snapshot.data!.length)
                                  get_search_suggestions(
                                      snapshot.data![i + 2], true, object, false),
                              ],
                            ),
                          ),
                        ),
                    ]);
                  } else {
                    return SizedBox(child: Center());
                  }
                }),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   // child: Row(
          //   //   mainAxisAlignment: MainAxisAlignment.end,
          //   //   children: [
          //   //     GestureDetector(
          //   //       onTap: (){

          //   //       },
          //   //       child: Container(
          //   //         child: Center(
          //   //           child:Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),)
          //   //         ),
          //   //       ),
          //   //     ),
          //   //     const Padding(
          //   //       padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
          //   //       child: Text(
          //   //         'أضف حساسية',
          //   //       ),
          //   //     ),
          //   //   ],
          //   // ),
          // ),
          if (entering_ingredients)
            SizedBox(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!entering_ingredients)
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mycolor,
                            ),
                            onPressed: () {
                              entering_ingredients = true;
                              if(search_bar_text.isNotEmpty){
                                ingridients_suggestions =  Ingridients_Helper.Search_Ingridients(search_bar_text);
                              }
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
                    ),
                  ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mycolor,
                          ),
                          onPressed: () {

                            if (!entering_ingredients) {
                              print('here');
                              Get.off(() => (Search_result()),
                               preventDuplicates: false,
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 500),
                                  arguments: {
                                    'type': 'byname',
                                    'title': search_bar_text
                                  });
                              
                            }
else{
  print('here');
  print(ingridients.toList());
  Get.off(() => (Search_result()),
  preventDuplicates: false,
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 500),
                                  arguments: {
                                    'type': 'byingridients',
                                    'ingridients': ingridients.toList(),
                                    
                                  });
}




                            object.setState(() {
                              entering_ingredients = false;
                            search_bar_text = '';
                              ingridients.clear();
                              showSearch_bar = false;
                            });
                          },
                          child: Text(
                            'بحث',
                            style: TextStyle(
                                fontFamily: myfont,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
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
  print(ingridients[id]);
  return Padding(
    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0.0),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color:mycolor3,
                borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.sizeOf(context).width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
if (ingridients[id]['byweight'] == true)
SizedBox(
  
  width: MediaQuery.sizeOf(context).width * 0.35,
  
  child: InputQty(
    steps: 50,
                  decoration: QtyDecorationProps(
                    border: InputBorder.none,
                    width: (MediaQuery.sizeOf(context).width * 0.35).toInt(),
                    iconColor: Colors.black,
                    btnColor: Colors.black
                    
                  ), //color of the increase and decrease icon 
                  maxVal: 1000, //max val to go 
                  initVal: 0,  //min starting val 
                  onQtyChanged: (val) { 
                     ingridients[id]['quantity']=val.toInt();
                    //on value changed we may set the value 
                    //setstate could be called 
                  }, 
                ),
),
if (ingridients[id]['byweight'] != true)
SizedBox(
  width: MediaQuery.sizeOf(context).width * 0.35,
  child: InputQty(
    steps: 1,
                  decoration: QtyDecorationProps(
                    border: InputBorder.none,
                    width: (MediaQuery.sizeOf(context).width * 0.35).toInt(),
                    iconColor: Colors.black,
                    btnColor: Colors.black
                  ), //color of the increase and decrease icon 
                  maxVal: 50, //max val to go 
                  initVal:0,  //min starting val 
                  onQtyChanged: (val) { 
                     ingridients[id]['quantity']=val;
                    //on value changed we may set the value 
                    //setstate could be called 
                  }, 
                ),
),















                // Container(
                //   color: Colors.blue,
                //   width: MediaQuery.sizeOf(context).width * 0.1,
                //   height: MediaQuery.sizeOf(context).width * 0.1,
                  
                //   child: Center(
                //     child: ElevatedButton(
                  
                //         onPressed: () {
                //           if (ingridients[id]['quantity'] > 0) {
                //             ingridients[id]['quantity'] -= 50;
                //           }
                //           object.setState(() {});
                //         },
                //         child: Center(

                //           child: Container(
                //             color: Colors.black,
                //             child: Text(
                //               textAlign: TextAlign.start,
                //               "-",
                //               style: TextStyle(
                //                   fontSize: 25,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.black),
                //             ),
                //           ),
                //         )),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                //   child: Text(
                //     ingridients[id]['quantity'].toString() + "   g",
                //     textAlign: TextAlign.end,
                //     style: TextStyle(fontFamily: myfont, fontSize: 20),
                //   ),
                // ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width * 0.1,
                //  // height: MediaQuery.sizeOf(context).height * 0.1,
                //   child: Center(
                //     child: ElevatedButton(
                //         onPressed: () {
                //           if (ingridients[id]['quantity'] < 1000) {
                //             ingridients[id]['quantity'] += 50;
                //           }
                //           object.setState(() {});
                //         },
                //         child: Center(
                //           child: Text(
                //             textAlign: TextAlign.center,
                //             "+",
                //             style: TextStyle(
                //                 fontSize: 25,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //           ),
                //         )),
                //   ),
                // ),
                Expanded(
                  
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Text(textAlign: TextAlign.end,
                                         ingridients[id]['byweight']==true?"  (g)   ${ingridients[id]['ingridient']}":ingridients[id]['ingridient'].toString(),
                                          style: TextStyle(fontFamily: myfont, fontSize: 20),
                                        ),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Center(
                child: IconButton(
                  color: mycolor3,
                  icon: trash,
                  onPressed: () {
                    print(ingridients);
                    ingridients.removeAt(id);
                            print(ingridients);
                    object.setState(() {});
                  },
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget get_category_filters(id, categories, object) {
  if (categories[id]['selected']) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
            color: mycolor, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          categories[id]['category'],
          style: TextStyle(
              fontFamily: myfont,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: SizedBox(
        child: Center(
            child: Text(
          categories[id]['category'],
          style: TextStyle(
              fontFamily: myfont,
              fontSize: 16,
              color: mycolor,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

Widget reciepe_suggestion(suggestion, context, object) {
  return GestureDetector(
    onTap: () {
      Map<String, dynamic> dataS = {'id': suggestion['id']};
      Get.to(() => (const PopularDishe()), arguments: dataS);
      //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
      // setState(() {

      // });
    },
    child: Column(
      children: [
        FutureBuilder(
          future: Reciepe_Helper.Get_Dish_Media(suggestion['media']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        snapshot.data['images'][0],
                        fit: BoxFit.fill,
                      )),
                ),

FutureBuilder(
                                  future: UserHelper.getfavourites(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //check if data['id'] is in favourites
                                      if(snapshot.data!['favourites']!.contains(suggestion['id'])){
                                      return                 SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async{
await UserHelper.remove_favourite(snapshot.data!['ids'][snapshot.data!['favourites'].indexOf(suggestion['id'])]);
object.setState(() {});
                          },
                          icon: Favourite_Button_Selected)
                    ],
                  ),
                );}
                                else{





                                  return                 SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: ()async {
                          await UserHelper.add_favourite(suggestion['id']);
                            object.setState(() {});
                          },
                          icon: Favourite_Button)
                    ],
                  ),
                );
                                
                                
                                }
                                    }
                                    else{
                                      return Center();
                                    }}
                                    
                                    )




              ]);
            } else {
              return Center();
            }
          },
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.4,
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
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.32,
                  child: Text(
                    suggestion['title'].toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.32,
                  child: Text(
                    suggestion['subtitle'].toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w200),
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
                          suggestion['rating'].toString(),
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
                          suggestion['time'].toString(),
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

Widget get_row(index, data, context, object) {
  if (index + 1 < data.length) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          reciepe_suggestion(data[index], context, object),
          reciepe_suggestion(data[index + 1], context, object),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          reciepe_suggestion(data[index], context, object),
        ],
      ),
    );
  }
}

Widget get_search_suggestions(result, reciepe, object, bool selected) {
  if (reciepe) {
    return GestureDetector(
      onTap: () {
        ingridients.clear();
        entering_ingredients = false;
        showSearch_bar = false;
        search_bar_text = '';
        Get.to(() => (PopularDishe()), arguments: {'id': result['id']});
        object.setState(() {});

        //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
        // setState(() {

        // });
      },
      child: Container(

        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 198, 201, 1),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                        result['title'].toString(),
                        style: TextStyle(
                fontFamily: myfont,
                fontSize: 16,
                color: mycolor,
                fontWeight: FontWeight.bold),
                      ),
            )),
      ),
    );
  } else {
    return GestureDetector(
      onTap: () {
        bool contains = false;
        for (int i = 0; i < ingridients.length; i++) {
          if (ingridients[i]['ingridient'] == result['ingridient']) {
            contains = true;
            break;
          }
        }
        if (contains == false) {
          if(result['byweight']==true){
            ingridients.add(
                {'ingridient': result['ingridient'].toString(), 'quantity': 0,'byweight':result['byweight']});
          }
          else{
            ingridients.add(
                {'ingridient': result['ingridient'].toString(), 'quantity': 0,'byweight':result['byweight']});
          }
         

          object.setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: selected == true
                ? mycolor
                : const Color.fromRGBO(255, 198, 201, 1),
            borderRadius: BorderRadius.circular(15)),
        height: 40,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              result['ingridient'].toString(),
              style: TextStyle(
                  fontFamily: myfont,
                  fontSize: 16,
                  color: selected == true ? Colors.white : mycolor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

int getwordsindex(int num, String word) {
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

List<Map<String, dynamic>> SortAscendingDishes(
    List<Map<String, dynamic>> dishes) {
  dishes.sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
      b['rating'].compareTo(a['rating']));
  return dishes;
}
