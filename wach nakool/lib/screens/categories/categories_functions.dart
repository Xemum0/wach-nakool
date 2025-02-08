import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/colors_fonts.dart';
import 'package:mobile_project/screens/categories/category_page.dart';


Widget GetBigContainer(data,object,context) {
    return
GestureDetector(
                      onTap: () {
              
                      Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:{'id':data['id']
                      ,'category':data['category']});
                      object.setState(() {
                        
                      });
                      },
              child: Column(
                children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['category'],style: TextStyle(fontFamily:myfont,fontSize: 20,fontWeight: FontWeight.w700),)
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
                    borderRadius: BorderRadius.circular(20),
              child: Image.network(data['image'],fit: BoxFit.cover,),
                  ),
                )
              ],
                  ),
                ],
              ),
                      );
       
    
  }









Widget Getcontainer(data,object,context){

      return GestureDetector(
          onTap: () {
            
                    Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:{'id':data['id']
                      ,'category':data['category']});
                    object.setState(() {
                      
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
          
                  child: Image.network(data['image']),
                ),
              ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data['category']!,style: TextStyle(fontFamily:myfont,fontSize: 18,fontWeight: FontWeight.w500),)
                ],
              ),
            ],
          ),
        );
    }