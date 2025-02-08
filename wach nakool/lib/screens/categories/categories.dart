import 'package:flutter/material.dart';
import 'package:mobile_project/screens/categories/categories_functions.dart';
import 'package:mobile_project/supabase/category.dart';
import '../../data/colors_fonts.dart';
import '../../data/functions.dart';
import '../../data/vars.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
    late var categories=Categories_Helper.GetData();

@override
  void initState() {
    super.initState();
    categories=Categories_Helper.GetData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      Stack(
        children: [
          FutureBuilder(
            future: categories,
            builder:(context,snapshot) {
              if(snapshot.hasData){
              if (snapshot.data.length==0){
                return const Center(child: Text('No categories yet'));
              }
             return SafeArea(child: GestureDetector(
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
                    
                    GetBigContainer(snapshot.data[0],this,context),
                    
                    
                    for(int i=1;i<snapshot.data.length;i+=2)
                    Row(
                    
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Getcontainer(snapshot.data[i],this,context),
              if(i<snapshot.data.length)
              Getcontainer(snapshot.data[i+1],this,context),
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
                    );}
                    else
                    {return Center(child:CircularProgressIndicator.adaptive());}}
          ),
        //if(bottom)
              bottombar('categories'),
        if (showSearch_bar)
                Extendedsearch(this,context),]
      ),
    );
    
  }
  
  
}