import 'package:flutter/material.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import '../data/colors_fonts.dart';


class Search_result extends StatefulWidget {
  const Search_result({super.key});

  @override
  State<Search_result> createState() => _Search_resultState();
}

class _Search_resultState extends State<Search_result> {
  List isFavourite=[];
@override
  void initState() {
super.initState();
for(int i=0;i<search_result.length;i++){
  isFavourite.add(Favourite[0]);
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            bottom=true;
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
                      if (!showSearch_bar) get_custom_search_bar(this,        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: 
              Text(
                'نتائج البحث',
                style: TextStyle(
                    color: mycolor, fontSize: 18, fontWeight: FontWeight.bold),
              ),

            
          
        ),true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 25,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
for(int i=0;i<nav_bar_filters.length;i++)
getoptions(i,nav_bar_filters[i]['txt'], nav_bar_filters[i]['selected'],this)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: mycolor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
for (int i=0;i<search_result.length;i+=2)
get_row(isFavourite,i,search_result,context,this)


                      // //testing
                      // ,
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       suggestions('assets/homescreen/mojito.png', 'text',
                      //           '4', '10'),
                      //       suggestions('assets/homescreen/tacos.png', 'text',
                      //           '4', '30'),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       suggestions('assets/homescreen/mojito.png', 'text',
                      //           '4', '10'),
                      //       suggestions('assets/homescreen/tacos.png', 'text',
                      //           '4', '30'),
                      //     ],
                      //   ),
                      // ),Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       suggestions('assets/homescreen/mojito.png', 'text',
                      //           '4', '10'),
                      //       suggestions('assets/homescreen/tacos.png', 'text',
                      //           '4', '30'),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                height: double.infinity,
                width: double.infinity,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: const Color.fromRGBO(253, 93, 105, 1),
                    //   ),
                    //   height: 50,
                    //   width: 250,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Icon(
                    //         MdiIcons.home,
                    //         color: Colors.white,
                    //       ),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              
                 //if(bottom)
              bottombar('result'),
              if (showSearch_bar)
                Extendedsearch(this,context),
            ]),
          ),
        ),
      ),
    );
  }
}
