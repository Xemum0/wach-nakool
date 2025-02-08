
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/colors_fonts.dart';
import 'package:mobile_project/data/icons.dart';
import 'package:mobile_project/screens/dish.dart';
import 'package:mobile_project/supabase/reciepes.dart';

import '../../supabase/user.dart';

Widget Get_Main_Dish(data,context,object){
  return GestureDetector(
                              onTap: () {
        Map<String,dynamic> dataS= {'id':data['id'],};
        
        Get.to(()=> (const PopularDishe()),arguments:dataS);
                  //         Get.to(()=> ( const Category_Page()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500),arguments:data[index]['text']);
                  // setState(() {
                    
                  // });
      },
                        child: Container(
                        //  color: Colors.blue,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Stack(children: [
                                FutureBuilder(
                                  future:Reciepe_Helper.Get_Dish_Media(data['media']),
                                  builder: (context,snapshot){
if (snapshot.hasData && snapshot.data!=null){
  return Center(
    child: Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(30)
),
    width: MediaQuery.sizeOf(context).width*0.5,
    height: MediaQuery.sizeOf(context).height*0.2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(snapshot.data['images'][0],fit: BoxFit.fill,)),
                                    ),
  );

}
else {
  return Center();
}

                                  },
                                
                                ),
                                FutureBuilder(
                                  future: UserHelper.getfavourites(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      
                                      if(snapshot.data!['favourites']!.contains(data['id'])){
                                      return Center(
                                  child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width*0.5,
                                  
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              print(snapshot.data!['favourites'].indexOf(data['id']));
                                              print(snapshot.data!['ids']);
                                             await UserHelper.remove_favourite(snapshot.data!['ids'][snapshot.data!['favourites'].indexOf(data['id'])]);
                                              object.setState(() {});
                                            },
                                            icon:Favourite_Button_Selected)
                                      ],
                                    ),
                                  ),
                                );}
                                else{





                                  return Center(
                                  child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width*0.5,
                                  
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: ()async {
                                                           await  UserHelper.add_favourite(data['id']);  
                                                           object.setState(() {});
                                            },
                                            icon:Favourite_Button)
                                      ],
                                    ),
                                  ),
                                );
                                
                                
                                }
                                    }
                                    else{
                                      return Center();
                                    }}
                                    
                                    )

                                
                              ]),
                              Center(
                                child: Container(
                                width: MediaQuery.sizeOf(context).width*0.8,
                                
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: mycolor),
                                          bottom: BorderSide(color: mycolor),
                                          left: BorderSide(color: mycolor),
                                          right: BorderSide(color: mycolor)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width*0.5,
                                              child: Center(
                                                child: Text(data['title'].toString(),
                                                    style: TextStyle(fontFamily:myfont,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),softWrap: true,),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width*0.5,
                                              child: Center(
                                                child: Text(
                                                  textAlign: TextAlign.end,
                                                  data['subtitle']==null?"":data['subtitle'].toString(),
                                                    style: TextStyle(
                                                      
                                                      fontFamily:myfont,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),softWrap: true,),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Time_Red,
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                                  child: Text(
                                                    data['time'].toString(),
                                                    style: TextStyle(fontFamily:myfont,
                                                        color: const Color.fromRGBO(
                                                            253, 93, 105, 1)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                                  child: Text(
                                                    data['rating'].toString(),
                                                    style: TextStyle(fontFamily:myfont,
                                                        color: const Color.fromRGBO(
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
                                ),
                              )
                            ],
                          ),
                        ),
                      );
}




