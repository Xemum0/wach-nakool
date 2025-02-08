import 'package:flutter/material.dart';
import 'package:mobile_project/supabase/reciepes.dart';
import '../../data/functions.dart';
import '../../data/vars.dart';
import 'package:get/get.dart';
import '../../data/colors_fonts.dart';

class Category_Page extends StatefulWidget {
  const Category_Page({super.key, data});

  @override
  State<Category_Page> createState() => Category_PageS();
}

class Category_PageS extends State<Category_Page> {
  Map category = Get.arguments as Map;
  late Future<List<Map<String, dynamic>>> category_dishes;
  @override
  void initState() {
    super.initState();
    category_dishes = Reciepe_Helper.Get_Category_Reciepes(category['id']);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
            child: GestureDetector(
          onTap: () {
            bottom = true;
            showSearch_bar = false;

            setState(() {});
          },
          child: SizedBox(
            //margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!showSearch_bar)
                    get_custom_search_bar(
                        this,
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                            child: Text(
                              category['category'].toString(),
                              style: TextStyle(
                                  fontFamily: myfont,
                                  color: mycolor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        true),
                  FutureBuilder(
                    future: category_dishes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(" No Reciepes Found"),
                          );
                        }
                        List<Map<String, dynamic>>? sortedData =
                            SortAscendingDishes(snapshot.data!);
          
                        return Column(children: [
                          for (int i = 0; i < sortedData.length; i += 2)
                            get_row(i, sortedData, context, this),
                        ]);
                      } else {
                        return Center();
                      }
                    },
                  ),
                  Container(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        )),
        bottombar('categorypage'),
        if (showSearch_bar) Extendedsearch(this, context),
      ]),
    );
  }
}
