import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/functions.dart';
import '../data/icons.dart';
import '../data/colors_fonts.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
     var Data=[
        {
            'day':'الأربعاء',
            'data':[{
'time':'اليوم',
'header':'الأطباق الأسبوعية الجديدة',
'text':'أكتشف أحدث الأطباق الان',
'type':'new',
}
,
{
'time':'قبل 2 دقيقة',
'header':'لقد أطلت الغياب هذه المرة',
'text':'أكتشف أحدث الأطباق الان',
'type':'reminder',
},



{
'time':'قبل 2 دقيقة',
'header':'لقد أطلت الغياب هذه المرة',
'text':'أكتشف أحدث الأطباق الان',
'type':'reminder',
}]},


        {
            'day':'الاثنين',
            'data':[{
'time':'اليوم',
'header':'الأطباق الأسبوعية الجديدة',
'text':'أكتشف أحدث الأطباق الان',
'type':'new',
}
,
{
'time':'قبل 2 دقيقة',
'header':'لقد أطلت الغياب هذه المرة',
'text':'أكتشف أحدث الأطباق الان',
'type':'reminder',
},



{
'time':'قبل 2 دقيقة',
'header':'لقد أطلت الغياب هذه المرة',
'text':'أكتشف أحدث الأطباق الان',
'type':'reminder',
}]
        }



];

    Widget getcontainer(type,text,header,time){
return Center(
child: Container(
    width: double.infinity,
    padding:const EdgeInsets.fromLTRB(20, 0, 20, 0) ,
    child: Column(
        children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,20,20),
                      child: Text(time,style: TextStyle(fontFamily:myfont,fontSize: 18,color: Colors.black,),),
                    )
                ],
            ),
            Padding(
              padding:  const EdgeInsets.fromLTRB(0,0,0,20),
              child: Container(
                  //width: double.infinity,
                  height: 120,
                  decoration: 
                  BoxDecoration(color: mycolor2,borderRadius: BorderRadius.circular(20)),
              child: 
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      if(type=='new')
                      Padding(
                            padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Notification_Star,
                          ),
                        ),
                      ),
                      if(type=='reminder')
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                                                    height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)
                            ),
                          child: Center(child: Notification_Bell)),
                      ),
                      Column(
                          children: [Padding(
                            padding: const EdgeInsets.fromLTRB(0,20,20,0),
                            child: Text(header,style: TextStyle(fontFamily:myfont,fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                          ),
                       Padding(
                            padding: const EdgeInsets.fromLTRB(0,10,20,0),
                            child: Text(text,style: TextStyle(fontFamily:myfont,fontSize: 20,color: Colors.black,fontWeight: FontWeight.w800),),
                          ),   ],
                      )
              
                  ],
              ),),
            )
        ],
    ),
),
);

    }

    Widget get_day_notif(nday){
        var myday;

                for(var day in Data){
                if(day['day']==nday)
                {myday=day['data'];
                break;}}
        return Column(
            children: [
                Padding(
                  padding:const EdgeInsets.fromLTRB(0,0,30,0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,10),
                        child: Text(nday,style: TextStyle(fontFamily:myfont,fontSize: 22,fontWeight: FontWeight.bold,),),
                      ),
                    ],
                  ),
                ),

                for(var notif in myday)
                getcontainer(notif['type'], notif['text'], notif['header'],notif ['time']),
                
            ],
        );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(leading: IconButton(onPressed: (){Get.back();}, icon:Go_Back_Arrow),
title: Text("تنبيهات",style: TextStyle(fontFamily:myfont,fontSize: 24,color: mycolor,fontWeight: FontWeight.bold),),centerTitle: true,
primary: true,),
body: SafeArea(
  child: Stack(
    children: [SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
            children: [
              for(var days in Data)
                get_day_notif(days['day'])
            ],
        ),
    ),
    bottombar('Community')]
  ),
),

    );
  }
}