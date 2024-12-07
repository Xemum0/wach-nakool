import 'package:flutter/material.dart';
import 'package:mobile_project/screens/comments.dart';
import 'package:mobile_project/screens/review.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import 'package:get/get.dart';
import '../data/icons.dart';
import '../data/colors_fonts.dart';


class PopularDishe extends StatefulWidget {
  const PopularDishe({super.key});

  @override
  State<PopularDishe> createState() => PopularDisheS();
}

class PopularDisheS extends State<PopularDishe>
    with SingleTickerProviderStateMixin {
var isFavourite=Favourite[0];

final Map<dynamic,dynamic> data=Get.arguments as Map;
  String bullet = "\u2022 ";
  List ingridients = [
    '1 عجينة بيتزا جاهزة (من المتجر أو محضرة في المنزل)',
    '1/2 كوب صلصة بيتزا',
    '1 1/2 كوب جبنة موزاريلا مبشورة',
    '1/2 كوب لحم مفروم (لحم بقر أو دجاج)',
    '1/4 كوب فلفل رومي ملون مقطع',
    '1/4 كوب طماطم مقطعة',
    '1/4 كوب بصل أحمر مقطع',
    '1/4 كوب مشروم مقطع (اختياري)',
    'أوراق ريحان طازجة للتزيين (اختياري)',
    'زيت زيتون للدهن'
  ];
List nutriments=[const Color.fromARGB(255, 255, 89, 77),const Color.fromARGB(255, 174, 122, 20),const Color.fromARGB(255, 103, 170, 105)];
List colors=[mycolor3,mycolor2];
  List<List> steps = [
          [
        '   قم بتسخين الفرن إلى درجة حرارة 200 مئوية (400 فهرنهايت).',
        'إذا كانت العجينة جاهزة من المتجر، ضعها على صينية خبز مبطنة بورق الزبدة. إذا كنت تستخدم عجينة محضرة في المنزل، افردها على سطح مستوٍ باستخدام النشابة حتى تصبح بحجم الصينية التي ستخبز فيها.'
      ]
    ,
    
      [
        'باستخدام ملعقة، قم بتوزيع صلصة البيتزا بالتساوي على العجينة. اترك حوالي 1 سم من الحواف بدون صلصة حتى لا تلتصق أثناء الخبز.',
      ]
    ,
    
      [
        'رش الجبنة المبشورة (الموزاريلا) على الصلصة بشكل متساوٍ. تأكد من تغطية العجينة بالكامل بالجبنة.',
        'ضع اللحم المفروم (المطهو مسبقًا إذا كان اللحم نيئًا) فوق الجبنة.'
      ]
    ,
    
      [
        'أضف الفلفل الرومي الملون المقطع والطماطم المقطعة على الوجه.',
        'ضع البصل الأحمر والمشروم المقطع (إن كنت تستخدمه) فوق المكونات الأخرى. هذه الخضروات تضيف نكهة رائعة للبيتزا.'
      ]
    ,
    
      [
        ' استخدم فرشاة صغيرة لدهن حواف العجينة بزيت الزيتون. هذا سيساعد في الحصول على حواف ذهبية ولذيذة بعد الخبز.',
        'ضع البيتزا في الفرن المسخن مسبقًا واخبزها لمدة 15 إلى 20 دقيقة أو حتى تصبح العجينة ذهبية اللون والجبنة تذوب بشكل جيد.'
      ]
    ,
    
      [
        'ضع البيتزا في الفرن المسخن مسبقًا واخبزها لمدة 15 إلى 20 دقيقة أو حتى تصبح العجينة ذهبية اللون والجبنة تذوب بشكل جيد.',
        'بعد إخراج البيتزا من الفرن، أضف أوراق الريحان الطازجة للتزيين إذا رغبت في ذلك.',
        'اترك البيتزا لتبرد قليلاً ثم قطعها واستمتع!'
      ]
    ,
  ];
  var nutrition=['بروتين','دهون','كارب'];
 var nutriotionalvalue=[
  12,
  25,
  50
 ];

  Widget Get_dish_vid(title, time, likes, vid) //need to add vid parameter
  {
    return Container(
      decoration: BoxDecoration(
          color: mycolor, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                //color: Colors.black,
                //height: MediaQuery.sizeOf(context).height*0.25,
                width: MediaQuery.sizeOf(context).width * 0.8,
                //video here
                child: ClipRRect(
                  child: Image.asset(
                    'assets/homescreen/pizzevid.png',
                    fit: BoxFit.cover,
                  ),
                )),
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
                    child: Text(title,
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
                            time,
                            style: TextStyle(
                                fontFamily: myfont, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                                  Get.to(const Comments());
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Reviews,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Text(
                                  likes, // stars,
                                  style: TextStyle(
                                      fontFamily: myfont, color: Colors.white),
                                ),
                              ),
                            ],
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
                          time + ' mins',
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
                details,
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
Get_Nutritional_value(){


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
for (int i=0;i<nutriotionalvalue.length;i++)
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
          height: nutriotionalvalue[i].toDouble(),
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
      Text('${nutriotionalvalue[i]}g',style: const TextStyle(fontSize: 18),),
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
  Get_ingridients() {
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
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  children: [
                    for (int i = 0; i < ingridients.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.7,
                                child: Text(
                                  softWrap: true,
                                  ingridients[i],
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

  Get_steps() {
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
                          child: Column(
                            children: [
                              for (int j = 0;j < steps[i].length;j++)
                              
                                      Padding(
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
                                                      steps[i][j].toString(),
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
                                      )
                            ],
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
                        Get.back();
                      },
                      icon:Go_Back_Arrow
                    ),
                  ],
                )),
            Text('الطبخات الشائعة',
                style: TextStyle(
                    color: mycolor, fontSize: 25, fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {
if(isFavourite==Favourite[0]){
isFavourite=Favourite[1];}
else{
isFavourite=Favourite[0];
                               }
                               setState(() {
                                 
                               });               },
                icon: isFavourite)
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
                  Column(
                    children: [
                      Get_dish_vid(data['title'], data['time'], data['stars'], ''),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Get_details('30',
                            'هذه نظرة عامة سريعة على المكونات التي ستحتاجها لتحضير هذه الوصفة للبيتزا باللحم والخضر. توجد مقادير دقيقة وتعليمات الوصفة الكاملة في بطاقة الوصفة القابلة للطباعة أدناه.'),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Get_ingridients()),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Get_steps()),
                                                Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Get_Nutritional_value()),
                    ],
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