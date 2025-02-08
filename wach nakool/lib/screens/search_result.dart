import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/supabase/category.dart';
import 'package:mobile_project/supabase/reciepes.dart';
import '../data/functions.dart';
import '../data/vars.dart';
import '../data/colors_fonts.dart';


class Search_result extends StatefulWidget {
  const Search_result({super.key});

  @override
  State<Search_result> createState() => _Search_resultState();
}

class _Search_resultState extends State<Search_result> {
   List<int> ids=[];
   List<int> ids2=[];
      late Future<List<Map<dynamic,dynamic>>> nav_bar_filters;
        late var categories;
  final params = Get.arguments as Map;
  late Future<List<Map<String,dynamic>>> search_result;
  late Future<List<Map<String,dynamic>>> ExactMatchIngredients;
  late Future<List<Map<String,dynamic>>> ExactMatchAndQuantity;
  late Future<List<Map<String,dynamic>>> SubsetMatch;
    late int  selected;
@override
  void initState() {
super.initState();
nav_bar_filters=Categories_Helper.GetCategoriesNames();

selected=0;
if (params['type']=='byname'){
  search_result=Reciepe_Helper.Get_Reciepes_By_Name(params['title'],false);
}
else{
  if(params['type']=='byingridients'){
    ExactMatchIngredients=Reciepe_Helper.Get_Reciepes_By_Exact_ingredients(params['ingridients']);
    ExactMatchAndQuantity=Reciepe_Helper.Get_Reciepes_By_Exact_ingredients_and_quantity(params['ingridients']);
    SubsetMatch=Reciepe_Helper.Get_Reciepes_By_Subset_ingredients(params['ingridients']);
  }
  //search_result=Reciepe_Helper.Get_Reciepes_By_ingredients(params['ingridients']);
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            bottom=true;
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
          child: 
              Text(
                'نتائج البحث',
                style: TextStyle(
                    color: mycolor, fontSize: 18, fontWeight: FontWeight.bold),
              ),

            
          
        ),true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  FutureBuilder(
                          future: nav_bar_filters,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                                                    
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
                                                        Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: mycolor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),




















if(params['type']=='byname')
FutureBuilder(
                                        future:search_result,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {

                                            var categoryReciepes=snapshot.data!.where((element) => element['category']==categories[selected]['id']).toList();
                                                                                    if(categoryReciepes.isEmpty){
                                              return Center(
                                          
                                              );
                                            }
                                         List<Map<String,dynamic>> ?sortedData= SortAscendingDishes(
                                                categoryReciepes);
                                                
                                            return Column(children: [

                                              for (int i = 0;
                                                  i < categoryReciepes.length;
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



















                if(params['type']=='byingridients')
                FutureBuilder(
                                        future:ExactMatchAndQuantity,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {

                                         List<Map<String,dynamic>> ?sortedData= SortAscendingDishes(
                                                snapshot.data!);
                                                var filteredData=sortedData.where((element) => element['category']==categories[selected]['id']).toList();
                                            
                                                                                        if(filteredData.isEmpty){
                                              return Center(
                                              );
                                            }
                                            for(int i=0;i<filteredData.length;i++){
                                              if(ids.contains(filteredData[i]['id'])==false){

                                              ids.add(filteredData[i]['id']);}
                                            }
                                            return Column(children: [
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text("النتائج المطابقة للمكونات والكمية ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: mycolor),),
  
  ]
),
                                              for (int i = 0;
                                                  i < filteredData.length;
                                                  i += 2)
                                               get_row(
                                                    i,
                                                    filteredData,
                                                    context,
                                                    this)
                                            ]);
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),






















                                      if(params['type']=='byingridients')
                                                      FutureBuilder(
                                        future:ExactMatchIngredients,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if(snapshot.data!.isEmpty){
                                              return Center(

                                              );
                                            }
                                         List<Map<String,dynamic>> ?sortedData= SortAscendingDishes(
                                                snapshot.data!);
                                                                                                var filteredData=sortedData.where((element) => element['category']==categories[selected]['id']).toList();
                                            

                                            for(int i=0;i<filteredData.length;i++){
                                              if(ids.contains(filteredData[i]['id'])==true){
                                                filteredData.removeAt(i);
                                              }
                                            }
                                                    if(filteredData.isEmpty){
                                              return Center(
                                              );
                                            }
                                            for(int i=0;i<filteredData.length;i++){
                                              ids2.add(filteredData[i]['id']);
                                            }
                                            return Column(children: [
                                              
                                              Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text("النتائج المطابقة للمكونات ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: mycolor),),

  ]
),

                                              for (int i = 0;
                                                  i < filteredData.length;
                                                  i += 2)
                                               get_row(
                                                    i,
                                                    filteredData,
                                                    context,
                                                    this)
                                            ]);
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                        if(params['type']=='byingridients')
                                                        FutureBuilder(
                                        future:SubsetMatch,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {


                                         List<Map<String,dynamic>> ?sortedData= SortAscendingDishes(
                                                snapshot.data!);
                                                var filteredData=sortedData.where((element) => element['category']==categories[selected]['id']).toList();
                                           

                                            for(int i=0;i<filteredData.length;i++){
                                              if(ids.contains(filteredData[i]['id'])==true || ids2.contains(filteredData[i]['id'])==true){
                                                filteredData.removeAt(i);
                                              }
                                            }
                                                                                                                                   if(filteredData.isEmpty){
                                              return Center(
                                              );
                                            }
                                            return Column(children: [
                                              Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text("النتائج القريبة للمكونات والكمية ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: mycolor),),
  
  ]
),

                                              for (int i = 0;
                                                  i < filteredData.length;
                                                  i += 2)
                                               get_row(
                                                    i,
                                                    filteredData,
                                                    context,
                                                    this)
                                            ]);
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),

                                  
                                  ]);
                                  
                                  }
                                  else {
                              return Center(child: CircularProgressIndicator());
                            }
                                  
                                  }),
                      ),





























                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                height: double.infinity,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: const Color.fromRGBO(253, 93, 105, 1),
                    //   ),
                    //   height: 50,
                    //   width: 250,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Icon(
                    //         MdiIcons.home,
                    //         color: Colors.white,
                    //       ),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //       Icon(MdiIcons.message, color: Colors.white),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              
                 //if(bottom)
              bottombar('result'),
              if (showSearch_bar)
                Extendedsearch(this,context),
            ]),
          ),
        ),
      ),
    );
  }
}
