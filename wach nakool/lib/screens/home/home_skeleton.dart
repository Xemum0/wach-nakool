
import 'package:flutter/material.dart';

import 'package:mobile_project/screens/home/home_content.dart';
import '../../data/functions.dart';
import '../../data/vars.dart';

import '../../data/colors_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late int selected;
  @override
  void initState() {
    super.initState();
selected = 0;
  }

  //final dishes =


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (showSearch_bar==true)
            {showSearch_bar = false;

            setState(() {});}
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
                      MainHome()

                      //testing
                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
                       if (showSearch_bar) Extendedsearch(this, context),

              //if(bottom)
              bottombar('home')
             
            ]),
          ),
        ),
      ),
    );
  }
}
