import 'package:flutter/material.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import 'package:get/get.dart';
import '../data/icons.dart';
import 'dish.dart';
import '../data/colors_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var isFavourite = [Favourite[0], Favourite[0]];
  var isFavourite_popular = Favourite[0];
  List isFavourite2 = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < search_result.length; i++) {
      isFavourite2.add(Favourite[0]);
    }
  }

  Widget populardishes(NUM, image, text, stars, time) {
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> dataS = {
          'id': 0,
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
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image)),
            ),
            SizedBox(
              width: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        if (isFavourite[NUM] == Favourite[0]) {
                          isFavourite[NUM] = Favourite[1];
                        } else {
                          isFavourite[NUM] = Favourite[0];
                        }
                        setState(() {});
                      },
                      icon: isFavourite[NUM])
                ],
              ),
            )
          ]),
          Container(
            width: 180,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(fontFamily: myfont, fontSize: 18),
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
                            style: TextStyle(
                                fontFamily: myfont,
                                color: mycolor,
                                fontSize: 16),
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
                            style: TextStyle(
                                fontFamily: myfont,
                                color: mycolor,
                                fontSize: 16),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            bottom = true;
            showSearch_bar = false;

            setState(() {});
          },
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Stack(children: [
              ListView(
                children: [
                  Column(
                    children: [
                      if (!showSearch_bar)
                        get_custom_search_bar(
                            this,
                            Column(
                              children: [
                                Text(
                                  'مرحبا!',
                                  style: TextStyle(
                                      fontFamily: myfont,
                                      color: mycolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ماذا ستطبخ اليوم ؟',
                                  style: TextStyle(
                                      fontFamily: myfont,
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            false),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 25,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 0; i < nav_bar_filters.length; i++)
                                getoptions(i, nav_bar_filters[i]['txt'],
                                    nav_bar_filters[i]['selected'], this)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Map<String, dynamic> dataS = {
                            'id': 0,
                            'title': "بيتزا منزلية بالحم والخضر",
                            'stars': "5",
                            'time': '30',
                            'image': 'assets/homescreen/pizza.png'
                          };
                          print(dataS.runtimeType);
                          Get.to(() => (const PopularDishe()),
                              arguments: dataS);
                          //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
                          // setState(() {

                          // });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'الطبخات الشائعة',
                                    style: TextStyle(
                                      fontFamily: myfont,
                                      fontSize: 18,
                                      color: mycolor,
                                    ),
                                  )
                                ],
                              ),
                              Stack(children: [
                                Container(
                                  child: Image.asset(
                                      'assets/homescreen/pizza.png'),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (isFavourite_popular ==
                                                Favourite[0]) {
                                              isFavourite_popular =
                                                  Favourite[1];
                                            } else {
                                              isFavourite_popular =
                                                  Favourite[0];
                                            }
                                            setState(() {});
                                          },
                                          icon: isFavourite_popular)
                                    ],
                                  ),
                                )
                              ]),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: mycolor),
                                        left: BorderSide(color: mycolor),
                                        right: BorderSide(color: mycolor)),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      child: Column(
                                        children: [
                                          Text('   بيتزا منزلية بالحم والخضر ',
                                              style: TextStyle(
                                                  fontFamily: myfont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          Text(' لحم , طماطم , طحين ...',
                                              style: TextStyle(
                                                  fontFamily: myfont,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Time_Red,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                child: Text(
                                                  '30 mins',
                                                  style: TextStyle(
                                                      fontFamily: myfont,
                                                      color:
                                                          const Color.fromRGBO(
                                                              253, 93, 105, 1),
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 5, 0),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                      fontFamily: myfont,
                                                      color:
                                                          const Color.fromRGBO(
                                                              253, 93, 105, 1)),
                                                ),
                                              ),
                                              Star_Red
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 270,
                        decoration: BoxDecoration(
                            color: mycolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'وصفاتك الاخيرة',
                                    style: TextStyle(
                                      fontFamily: myfont,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                populardishes(0, 'assets/homescreen/burger.png',
                                    'برجر بالحم والخضروات', '5', '15'),
                                populardishes(
                                    1,
                                    'assets/homescreen/tiramisu.png',
                                    'تيراميسو بالشكولاته',
                                    '5',
                                    '15'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'وصفات مقترحة',
                              style: TextStyle(
                                fontFamily: myfont,
                                fontSize: 18,
                                color: const Color.fromRGBO(253, 93, 105, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < search_result.length; i += 2)
                        get_row(isFavourite2, i, search_result, context, this)

                      //testing
                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              //if(bottom)
              bottombar('home'),
              if (showSearch_bar) Extendedsearch(this, context),
            ]),
          ),
        ),
      ),
    );
  }
}
