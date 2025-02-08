import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/comments.dart';

import 'package:mobile_project/supabase/reciepes.dart';
import 'package:video_player/video_player.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import 'package:get/get.dart';
import '../data/icons.dart';
import '../data/colors_fonts.dart';

var images=[];
var imageURL;
class PopularDishe extends StatefulWidget {
  const PopularDishe({super.key});

  @override
  State<PopularDishe> createState() => PopularDisheS();
}

class PopularDisheS extends State<PopularDishe>
    with SingleTickerProviderStateMixin {


final Map<dynamic,dynamic> reciepe=Get.arguments as Map;
  String bullet = "\u2022 ";

List nutriments=[const Color.fromARGB(255, 255, 89, 77),const Color.fromARGB(255, 174, 122, 20),const Color.fromARGB(255, 103, 170, 105)];
List colors=[mycolor3,mycolor2];

  var nutrition=['بروتين','دهون','كارب'];

late FlickManager flickManager;
  Widget Get_dish_vid(data) //need to add vid parameter
  {
    return Container(
      decoration: BoxDecoration(
          color: mycolor, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height:MediaQuery.sizeOf(context).height * 0.3 ,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [

FutureBuilder(future:Reciepe_Helper.Get_Dish_Media(data['media']) , builder: (context,snapshot){

  if(snapshot.hasData){
    if(snapshot.data['video']!=null){
        flickManager = FlickManager(
          autoPlay: false,
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(snapshot.data['video']),
    ));}
   
   if(snapshot.data['images']!=null)
 for (var i = 0; i < snapshot.data['images'].length; i++) {
  if (i == 0){
    imageURL = snapshot.data['images'][i];
  }
  images.add (Center(
    child: SizedBox(
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black),
      width: MediaQuery.sizeOf(context).width*0.8,
      height:MediaQuery.sizeOf(context).height*0.45 ,
      child: ClipRRect(
        borderRadius:BorderRadius.circular(30),
        child: Image.network(snapshot.data['images'][i],fit: BoxFit.fill,))),
  ));}
// var _controller=VideoPlayerController.networkUrl(

//      Uri.parse(snapshot.data['video'].toString())
//     );

return Padding(
  padding: const EdgeInsets.fromLTRB(0,10,0,0),
  child: Center(
          child: Container(
            
            child: CarouselSlider(
              
              options: CarouselOptions(
              onPageChanged: (index, reason) {
                if(index!=0 && snapshot.data['video']!=null) {
                  flickManager.flickControlManager?.pause();
                } else
              if( snapshot.data['video']!=null)
              flickManager.flickControlManager?.play();
              },
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                viewportFraction: 0.8,
              ),
              items: [
                if(snapshot.data['video']!=null)
                Container(
                        width: MediaQuery.sizeOf(context).width*0.8,
                  height:MediaQuery.sizeOf(context).height*0.45 ,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlickVideoPlayer(
                      
            flickManager: flickManager,
            
                    ),
                  ),
                ),
                    //       Center(
                    //   child: _controller.value.isInitialized
                    //       ? Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             // Display the video player
                    //             AspectRatio(
                    //               aspectRatio: _controller.value.aspectRatio,
                    //               child: VideoPlayer(_controller),
                    //             ),
                    //             // Play/Pause button
                    //             IconButton(
                    //               icon: Icon(
                    //                 _controller.value.isPlaying
                    //                     ? Icons.pause
                    //                     : Icons.play_arrow,
                    //               ),
                    //               onPressed: () {
                    //                 setState(() {
                    //                   if (_controller.value.isPlaying) {
                    //                     _controller.pause();
                    //                   } else {
                    //                     _controller.play();
                    //                   }
                    //                 });
                    //               },
                    //             ),
                    //           ],
                    //         )
                    //       : CircularProgressIndicator(),
                    // ),
            for (var i = 0; i < images.length; i++)
            images[i],
              
              ],
            ),
          ),),
);

// return FutureBuilder(
//   future:_controller.initialize(),

// builder: (context,snapshot){
// if (snapshot.hasData){
// return 



// }
// else 
// return Center();

// },





























  


                
  }
else {
    return Padding(
  padding: const EdgeInsets.all(20.0),
  child: Center(child: CircularProgressIndicator(),),
);
  }
  
}),






















            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                  color: mycolor,
                  border: Border(
                      bottom: BorderSide(color: mycolor),
                      left: BorderSide(color: mycolor),
                      right: BorderSide(color: mycolor)),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Text(data['title'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: myfont,
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Star_White,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            data['rating'].toString(),
                            style: TextStyle(
                                fontFamily: myfont, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                                  Get.to(Comments(
                                  recipeId: data['id'].toString(),
                                  recipeName: data['title'].toString(),
                                  recipeImage: imageURL,
                                ));
                          },
                          child: FutureBuilder(
                            future: Reciepe_Helper.Get_num_reviews(reciepe['id']),
                            builder:(context,snapshot) {
                              if (snapshot.hasData) {
                             return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Reviews,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    snapshot.data.toString(), // stars,
                                    style: TextStyle(
                                        fontFamily: myfont, color: Colors.white),
                                  ),
                                ),
                              ],
                            );}
                            else {
                                return SizedBox();
                              }}
                          ),
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
    );
  }

  Get_details(time, details) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Black_Clock,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          time.toString(),
                          style: TextStyle(
                              fontFamily: myfont, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'تفاصيل',
                    style: TextStyle(
                        color: mycolor,
                        fontFamily: myfont,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: Text(
                details.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.black, fontFamily: myfont, fontSize: 19),
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
Get_Nutritional_value(nutritionalVal){


 return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'القيمة الغذائية في 100 غرام  :',
                    style: TextStyle(
                        color: mycolor,
                        fontFamily: myfont,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                
                ],
              ),
            ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
for (int i=0;i<nutritionalVal.length;i++)
Padding(
  padding: const EdgeInsets.fromLTRB(30,0,0,0),
  child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: 100,
                  child: Row(
                    children: [
  
  Container(
    width: 20,
    height: 100,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: const Color.fromARGB(255, 214, 210, 210)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: nutriments[i]),
          width: 20,
          height:  double.parse(nutritionalVal[i]),
        )
      ],
    ),
  ),
                                          //add the image,
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
        height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
      Text('${nutritionalVal[i]}g',style: const TextStyle(fontSize: 18),),
      Text(nutrition[i],style: const TextStyle(fontSize: 18),),
      
        ],
      ),
    ),
  )
  
                      
                    ],
                  ),
  ),
)

                    ],
                  )
          ],
        ),
      ),
    );


}
  Get_ingridients(List<dynamic> Ingridients, List<dynamic> Quantity) {
//     List ingridients_quantity=[];
//     for(int i=0;i<Ingridients_Quantity.length;i++){
//      var ingridient=Ingridients_Quantity[i].split('_')[0];
//      var quantity=Ingridients_Quantity[i].split('_')[1];
// var dict={
//   'ingridient':ingridient,
//   'quantity':quantity,
// };
// ingridients_quantity.add(dict);
//     }
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'المكونات',
                    style: TextStyle(
                        color: mycolor,
                        fontFamily: myfont,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Column(
                  children: [
                    for (int i = 0; i < Ingridients.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                            child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: Text(
                                  softWrap: true,
                                  Ingridients[i].toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                )),
                         
                          ),
                           Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              softWrap: true,
                              "${Quantity[i]} ",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              softWrap: true,
                              bullet,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Get_steps(steps) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'خطوات سهلة:',
                    style: TextStyle(
                        color: mycolor,
                        fontFamily: myfont,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  children: [
                    for (int i = 0; i < steps.length; i++)
                      Padding(

                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          decoration: BoxDecoration(
                              color: colors[i%2],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: MediaQuery.sizeOf(context).width *
                                    0.8,
                                child: Column(
                                  children: [
                                                        Row(mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                  
                                      SizedBox(
                                          width: MediaQuery.sizeOf(context).width *
                                    0.7,
                                        child: Text(
                                          softWrap: true,
                                          steps[i].toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                                        
                                                        
                                       Text(
                                         softWrap: true,
                                         bullet,
                                         style: const TextStyle(
                                             fontSize: 20,
                                             fontWeight: FontWeight.bold),
                                         textAlign: TextAlign.end,
                                       ),
                                                  
                                                  
                                                          ],
                                                        )
                                                  
                                  ],
                                )),
                          ),
                        ),
                      ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
@override
void dispose(){
  flickManager.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        flickManager.dispose();
                        Get.back();
                      },
                      icon:Go_Back_Arrow
                    ),
                  ],
                )),
            Text('معلومات عن الوصفة',
                style: TextStyle(
                    color: mycolor, fontSize: 25, fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {
// if(isFavourite==Favourite[0]){
// isFavourite=Favourite[1];}
// else{
// isFavourite=Favourite[0];
//                                }
//                                setState(() {
                                 
//                                });             
  },
                icon:Time_Red)
          ],
        )),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            bottom = true;

            setState(() {});
          },
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Stack(children: [
              ListView(
                children: [
                  FutureBuilder(
                    future: Reciepe_Helper.Get_Dish(reciepe['id']),
                    builder:(context,snapshot){
                    if (snapshot.hasData)
                    {
                      return Column(
                      children: [
                        Get_dish_vid(snapshot.data),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Get_details(snapshot.data?['time'].toString(),
                             snapshot.data?['details']),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Get_ingridients(snapshot.data?['ingridients'],snapshot.data?['quantity'])),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Get_steps(snapshot.data?['steps'])),
                                                  Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Get_Nutritional_value(snapshot.data?['nutritional_val'])),
                      ],
                    );}
                    else
                    {return Center(child: CircularProgressIndicator());}}
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              //if(bottom)
              bottombar('dish'),
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


/*

[{LOBIA,3DS} => {ID1,QUANITY} ]
*/