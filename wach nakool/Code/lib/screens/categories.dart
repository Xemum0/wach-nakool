import 'package:flutter/material.dart';
import '../data/colors_fonts.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import 'package:get/get.dart';
import 'category_page.dart';
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


  bool bottom=true;


    Widget Getcontainer(index,data){
      return GestureDetector(
        onTap: () {
          
                  Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
                  setState(() {
                    
                  });
        },
        child: Column(
          
          children: [
            Container(
              
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: Colors.black
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
                    if (!showSearch_bar) get_custom_search_bar(this,        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
          child: Text(
            'فئات',
            style: TextStyle(fontFamily:myfont,
                color: mycolor, fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),true),
        
        GestureDetector(
                  onTap: () {
          
                  Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:'المأكولات البحرية');
                  setState(() {
                    
                  });
        },
          child: Column(
            children: [
              Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('المأكولات البحرية',style: TextStyle(fontFamily:myfont,fontSize: 20,fontWeight: FontWeight.w700),)
          ],
              ),
              Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
                              width: MediaQuery.sizeOf(context).width * 0.9,
              height:                  MediaQuery.sizeOf(context).height * 0.2,
              child: ClipRRect(
          child: Image.asset('assets/homescreen/fish.png',fit: BoxFit.cover,),
              ),
            )
          ],
              ),
            ],
          ),
        ),
        
        
        for(int i=0;i<categories.length;i+=2)
        Row(
        
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Getcontainer(i,categories),
            Getcontainer(i+1,categories),
          ],
        ),
      Container(
                    height: 80,
                  )
        
                  ],
                ),
              ),
            ),
        )
        ),
        //if(bottom)
              bottombar('categories'),
        if (showSearch_bar)
                Extendedsearch(this,context),]
      ),
    );
    
  }
}