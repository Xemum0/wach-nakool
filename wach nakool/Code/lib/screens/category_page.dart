import 'package:flutter/material.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import 'package:get/get.dart';
import '../data/colors_fonts.dart';


class Category_Page extends StatefulWidget {
  const Category_Page({super.key,data});

  @override
  State<Category_Page> createState() => Category_PageS();
}

class Category_PageS extends State<Category_Page> {
    List isFavourite=[];
@override
  void initState() {
super.initState();
for(int i=0;i<search_result.length;i++){
  isFavourite.add(Favourite[0]);
}
  }
  
  final String category= Get.arguments as String;
 List<Map<String,String>> data=[{
'image':'assets/homescreen/pizza.png',
'text':'عشاء',
  },
  {
'image':'assets/homescreen/pizza.png',
'text':'افطار',
  },
    {
'image':'assets/homescreen/pizza.png',
'text':'أكل سريع',
  },
    {
'image':'assets/homescreen/pizza.png',
'text':'أكل نباتي',
  },
    {
'image':'assets/homescreen/pizza.png',
'text':'مقبلات',
  },
      {
'image':'assets/homescreen/pizza.png',
'text':'مشروبات',
  },
  ];


 Widget Getcontainer(index){
      return GestureDetector(
        onTap: () {
          
                  //Get.to(()=> (Category_Page()),transition: Transition.downToUp,duration: Duration(milliseconds: 500),arguments:data[index]['text']);
        },
        child: Column(
          
          children: [
            Container(
              
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black
                  ),
            width:  MediaQuery.of(context).size.width*0.35,
            height: MediaQuery.of(context).size.height*0.15,
                  child: ClipRRect(
        
                child: Image.asset(data[index]['image']!),
              ),
            ),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data[index]['text']!,style: TextStyle(fontFamily:myfont,fontSize: 18,fontWeight: FontWeight.w500),)
              ],
            ),
          ],
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      Stack(
        children: [
          SafeArea(child: GestureDetector(
          onTap: () {
            bottom=true;
              showSearch_bar = false;
          
              setState(() {});
            },
            child: SizedBox(
              //margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
              child:SingleChildScrollView(
                
        
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
        
                  children: [
                    if (!showSearch_bar) get_custom_search_bar(this,Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
            child: Text(
              category,
              style: TextStyle(fontFamily:myfont,
                  color: mycolor, fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
        ),true),
        
        // Column(
        //   children: [
        //     Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: [
        //   Text('المأكولات البحرية',style: TextStyle(fontFamily:myfont,fontSize: 20,fontWeight: FontWeight.w700),)
        // ],
        //     ),
        //     Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: [
        //   Container(
        //     decoration: BoxDecoration(
        //       color: Colors.black,
        //       borderRadius: BorderRadius.circular(20)
        //     ),
        //     height: 150,
        //     child: ClipRRect(
        // child: Image.asset('assets/homescreen/pizza.png'),
        //     ),
        //   )
        // ],
        //     ),
        //   ],
        // ),
        
        
for (int i=0;i<search_result.length;i+=2)
get_row(isFavourite,i,search_result,context,this),Container(
                    height: 80,
                  )
        
                  ],
                ),
              ),
            ),
        )
        ),
              bottombar('categorypage'),
        if (showSearch_bar)
                Extendedsearch(this,context),]
      ),
    );
    
  }
}