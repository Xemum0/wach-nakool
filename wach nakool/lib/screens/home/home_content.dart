import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/data/colors_fonts.dart';
import 'package:mobile_project/data/functions.dart';
import 'package:mobile_project/supabase/category.dart';
import 'package:mobile_project/supabase/reciepes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../supabase/user.dart';
import 'home_functions.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
    late Future<List<Map<dynamic,dynamic>>> nav_bar_filters;
  late int  selected;
  late var categories;
  // late var favourites;
  @override 
  void initState() {
    super.initState();
    
    selected = 0;
    nav_bar_filters = Categories_Helper.GetCategoriesNames(); 
  }








  @override
  Widget build(BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: nav_bar_filters,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if(snapshot.data!.isEmpty){
                                return Center();
                              }
                              for (int i = 0;
                                  i < snapshot.data!.length;
                                  i++) {
                                if (snapshot.data![i]['selected'] == null) {
                                  if (i == 0) {
                                    snapshot.data![i]['selected'] = true;
                                  } else {
                                    snapshot.data![i]['selected'] = false;
                                  }
                                }
                               
                              } categories=List.from(snapshot.data!.toList());
                              return Column(
                                children: [
                                 
                                 
                                 
                                  SizedBox(
                                                                  width: double.infinity,
                                                                  height: 25,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < snapshot.data!.length;
                                                  i++) {
                                                snapshot.data![i]
                                                    ['selected'] = false;
                                              }
                                              snapshot.data![index]
                                                  ['selected'] = true;
                                              selected = index;
                                              setState(() {});
                                            },
                                            child: get_category_filters(index,
                                                snapshot.data, this));
                                      },
                                    ),
                                  ),
                        
                        
                        
                        
                        
                        FutureBuilder(
                                        future: Reciepe_Helper
                                            .Get_Category_Reciepes(categories[selected]['id']) ,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if(snapshot.data!.isEmpty){
                                              return Center(
                                                child: Text(" No Reciepes Found"),
                                              );
                                            }
                                         List<Map<dynamic,dynamic>> ?sortedData= SortAscendingDishes(
                                                snapshot.data!);
                                            return Column(children: [
                                                                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'الطبخات الشائعة',
                                    style: TextStyle(fontFamily:myfont,
                                      fontSize: 18,
                                      color: mycolor,
                                    ),
                                  )
                                ],
                              ),
                                              SizedBox(

                                                height: MediaQuery.sizeOf(context).height*0.3,
                                                child: Center(
                                                  child: CarouselSlider(
                                                    
                                                      items: [
                                                        for (int i = 0;
                                                            i < 3;
                                                            i++)
                                                            if(i<snapshot.data!.length)
                                                          Get_Main_Dish(
                                                             sortedData[i],
                                                              context,this)
                                                      ],
                                                      options: CarouselOptions(
                                                          initialPage: 0,
                                                          autoPlay: true)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .all(10),
                                                    child: Text(
                                                      'وصفات مقترحة',
                                                      style: TextStyle(
                                                        fontFamily: myfont,
                                                        fontSize: 18,
                                                        color: const Color
                                                            .fromRGBO(253,
                                                            93, 105, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int i = 3;
                                                  i < sortedData.length;
                                                  i += 2)
                                               get_row(
                                                    i,
                                                    sortedData,
                                                    context,
                                                    this)
                                            ]);
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                ],
                              );
                            } else {
                              return Center();
                            }
                          },
                        ),
                      );
  }
}