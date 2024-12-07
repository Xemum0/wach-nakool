import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/screens/login.dart';

class Transitions extends StatefulWidget {
  const Transitions({super.key});
    static const pageRoute = "/transitions";

  @override
  State<Transitions> createState() => _TransitionsState();
}

class _TransitionsState extends State<Transitions> {
   CarouselSliderController controller=CarouselSliderController();

 List<Map<String, String>> Data=[
{
'image':'assets/welcomescreen/image1.png',
'title':'أدخل المكونات التي لديك ',
'text':'أدخل المكونات المتوفرة لديك في المنزل لنبحث لك عن وصفات تناسب ما لديك بسهولة',
'button':'الصفحة الموالية',
}
,
{
'image':'assets/welcomescreen/image2.png',
'title':'نقدم لك الوصفات',
'text':'نقترح لك وصفات متنوعة وسهلة التحضير بناءً على المكونات التي أدخلتها.',
'button':'الصفحة الموالية',
},



{
'image':'assets/welcomescreen/image3.png',
'title':'بتكاليف في المتناول ',
'text':'نقدم لك وصفات لذيذة وبأسعار معقولة تناسب ميزانيتك',
'button':'الصفحة الموالية',
},


{
'image':'assets/welcomescreen/image3.png',
'title':'نقترح بقية المكونات',
'text':'إذا كانت بعض المكونات ناقصة، نقترح لك ما تحتاجه وتضيفه مباشرة إلى قائمة التسوق',
'button':'ابدا الان',
}


];
int Currentindex=0;
  @override
  Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(Currentindex<3)
                  GestureDetector(
                    onTap: () {
    Get.off(()=> ( const Login()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500));   
                      Currentindex=3;
                      setState(() {
                        
                      });
                    },
                    child: const Text(
                      'تخطي',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            body:  SafeArea(
              child: SizedBox(
                height: double.infinity,
                child: CarouselSlider(
                 
                 carouselController: controller,
                 
                 options: CarouselOptions(onPageChanged: (index, reason) {
                   Currentindex=index;
                   setState(() {
                     
                   });
                 },enableInfiniteScroll: false,enlargeCenterPage: true,enlargeFactor: 0.5,
                 height: screenHeight,
                 
                //scrollPhysics: const NeverScrollableScrollPhysics(),
                
                    ),
                 items:Data.map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                      
                                      
                                      
                                      
                                    return SizedBox(
                                      height: double.infinity,
                                      child: ListView(
                                        children: [Center(
                                                               
                                                                 child: Column(
                                                                   
                                                                   children: [
                                                               Container(
                                                                 
                                                                 height: 300,
                                                                 width: 300,
                                                                 margin:const  EdgeInsets.fromLTRB(0, 40, 0, 0),
                                                                 child: Image.asset(item['image']!),
                                                               ),
                                                               
                                                               SizedBox(
                                                                 width: 200,
                                                                 child: Padding(
                                                               padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                               child: Text(
                                                               
                                                                 item['title']!,softWrap: true,maxLines: 2,
                                                                 style: const TextStyle(
                                                                     color: Colors.black,
                                                                     fontFamily: 'Mulish',
                                                                     fontWeight: FontWeight.w700,
                                                                     fontSize: 30),
                                                                 textAlign: TextAlign.center,
                                                               )),
                                                               ),
                                        
                                        
                                                                       Padding(
                                                             padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                             child: Text(
                                                             
                                                               item['text']!,softWrap: true,maxLines: 2,
                                                               style: const TextStyle(
                                                                   color: Colors.grey,
                                                                   fontFamily: 'Mulish',
                                                                   fontWeight: FontWeight.w400,
                                                                   fontSize: 18),
                                                               textAlign: TextAlign.center,
                                                             )),
                                                               
                                                                  
                                                                  
                                                                  
                                                              Padding(
                                                                padding: const EdgeInsets.fromLTRB(0,90,0,30),
                                                                child: Row(
                                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                                 children: [
                                                                   for(int i=0;i<4;i++)
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                  
                                                                    height: 13,
                                                                    width: 13,
                                                                    decoration: BoxDecoration(
                                                                      color: Currentindex==i?Colors.red:const Color.fromARGB(255, 203, 203, 203),
                                                                      shape: BoxShape.circle
                                                                    ),
                                                                  ),
                                                                ),
                                                                
                                                                
                                                                     
                                                                   
                                                                 ],
                                                                ),
                                                              ),
                                                              
                                                              
                                                              Container(
                                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                               height: 60,
                                                               width: 280,
                                                                child: ElevatedButton(
                                                        onPressed: () {
                                                                                                                                if(Currentindex==3
                                                                 ){
                                                              Get.off(()=> ( const Login()),transition: Transition.downToUp,duration: const Duration(milliseconds: 500));
                                                                 }
                                                                 if(Currentindex<3){
                                                                 Currentindex++;
                                                                 controller.nextPage();
                                                                 
                                                                 }
              
                                                                 setState(() {
                                                                   
                                                                 });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                                 backgroundColor:  const Color.fromRGBO(233, 77, 98, 1),
                                                        ),
                                                                     child: Center(
                                                                       child:  Text(
                                                                       
                                                                        item['button']!,
                                                                         style: const TextStyle(
                                         color: Colors.white,
                                         fontFamily: 'Mulish',
                                         fontWeight: FontWeight.w700,
                                         fontSize: 28),
                                                                         textAlign: TextAlign.center,
                                                                       ),
                                                                     ),
                                                                   ),
                                                              )     ],
                                                                 ),
                                                               ),]
                                      ),
                                    );
                                  },
                                );
                   }).toList(),
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                                      ),
              ),
            )
                    );
  }
}