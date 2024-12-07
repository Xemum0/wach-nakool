import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_project/data/icons.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import '../data/colors_fonts.dart';


class PopularDishes extends StatefulWidget {
  const PopularDishes({super.key});

  @override
  State<PopularDishes> createState() => PopularDishesS();
}

class PopularDishesS extends State<PopularDishes>
    with SingleTickerProviderStateMixin {
      var isFavourite=[Favourite[0],Favourite[0],Favourite[0]];
var isFavourite_popular=Favourite[0];
  Widget suggestions(num,image, title, text, stars, time, difficulty) {
    return Row(
      children: [
        Stack(children: [
          Container(
            width: 160,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(image)),
          ),
          SizedBox(
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
if(isFavourite[num]==Favourite[0]){
isFavourite[num]=Favourite[1];}
else{
isFavourite[num]=Favourite[0];
                               }
                               setState(() {
                                 
                               });    

                    },
                    icon:isFavourite[num])
              ],
            ),
          )
        ]),
        Container(
          height: 100,
          width: 190,
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide.none,
                  bottom: BorderSide(color: mycolor),
                  top: BorderSide(color: mycolor),
                  right: BorderSide(color: mycolor)),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      textAlign: TextAlign.end,
                      title,
                      style: TextStyle(fontFamily:myfont,fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.end,
                        text,
                        style: TextStyle(fontFamily:myfont,fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Time_Red,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            time + ' mins',
                            style: TextStyle(fontFamily:myfont,fontSize: 12, color: mycolor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text(
                            difficulty,
                            style: TextStyle(fontFamily:myfont,fontSize: 12, color: mycolor),
                          ),
                        ),
                       Difficulty
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text(
                            stars,
                            style: TextStyle(fontFamily:myfont,fontSize: 12, color: mycolor),
                          ),
                        ),
                        Star_Red
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }




  Widget getoptions(text, selected) {
    if (selected) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: GestureDetector(
          child: Container(
            width: 60,
            decoration: BoxDecoration(
                color: mycolor, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontFamily:myfont,
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
          child: SizedBox(
            width: 60,
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontFamily:myfont,
                  fontSize: 16, color: mycolor, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      );
    }
  }


  Widget Get_Main_dish(img,title, desc, stars, time)//need to add img parameter
   {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                title,
                style: TextStyle(fontFamily:myfont,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Stack(children: [
          Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: mycolor),
                  left: BorderSide(color: mycolor),
                  right: BorderSide(color: mycolor)),
              borderRadius:  BorderRadius.circular(20)),
            child:Column(children: [Image.asset(img,fit: BoxFit.cover,),SizedBox(
          //padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
       
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Column(
                  children: [
                    Text(
                        desc.toString().substring(
                            0,
                            min(desc.toString().length,
                                getwordsindex(6, desc))),
                        style: TextStyle(fontFamily:myfont,
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                        '${desc.toString().substring(
                                min(getwordsindex(6, desc),
                                    desc.toString().length),
                                desc.toString().length)}.....',
                        style: TextStyle(fontFamily:myfont,
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Time_Red,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            time,
                            style: TextStyle(fontFamily:myfont,
                                color: const Color.fromRGBO(253, 93, 105, 1)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text(
                            stars,
                            style: TextStyle(fontFamily:myfont,
                                color: const Color.fromRGBO(253, 93, 105, 1)),
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
        )],) 
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      if(isFavourite_popular==Favourite[0]){
isFavourite_popular=Favourite[1];}
else{
isFavourite_popular=Favourite[0];
                               }
                               setState(() {
                                 
                               });    

                    },
                    icon: isFavourite_popular)
              ],
            ),
          )
        ]),
        
      ],
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
                      if (!showSearch_bar) get_custom_search_bar(this,        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: Text(
            'الطبخات الشائعة',
            style: TextStyle(fontFamily:myfont,
                color: mycolor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),true),

                      Container(
                          decoration: BoxDecoration(
                              color: mycolor,
                              borderRadius: BorderRadius.circular(30)),
                          width: double.infinity,
                          height: 280,
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: Get_Main_dish('assets/homescreen/pizza.png',
                              'الأكثر مشاهدة لليوم',
                              '   بيتزا منزلية بالحم والخضر' '   لحم , طماطم , طحين ...',
                              '30',
                              '5')),
              

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: suggestions(0,
                            'assets/homescreen/rice.png',
                            'كاري الدجاج',
                            'استمتع بمذاق كاري الدجاج العطري - مزيج غني من التوابل',
                            '4',
                            '10',
                            'سهلة'),
                      )

                      //testing
                      ,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: suggestions(1,
                            'assets/homescreen/burger.png',
                            'برجر دجاج',
                            'استمتع ببرجر الدجاج اللذيذ: دجاج متبل...',
                            '4',
                            '10',
                            'متوسطة'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: suggestions(2,
                            'assets/homescreen/cake.png',
                            'تيراميسو',
                            'نخلط الدقيق والملح والقرفة ......',
                            '4',
                            '10',
                            'صعبة'),
                      )
                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              //if(bottom)
              bottombar('home'),
              if (showSearch_bar) Extendedsearch(this,context),
            ]),
          ),
        ),
      ),
    );
  }
}



// class MySearchDelegate extends StatefulWidget {
//   const MySearchDelegate({super.key});

//   @override
//   State<MySearchDelegate> createState() => _MySearchDelegateState();
// }

// class _MySearchDelegateState extends State<MySearchDelegate> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }