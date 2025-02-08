import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/screens/home/home_skeleton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile_project/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
// const supabaseUrl = 'https://leerygjkvxnmesgnaiit.supabase.co';
// const supabaseKey = String.fromEnvironment(
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');

Future<void> main() async {
  // await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Future to fetch token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,  // Hide debug banner
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          // Check the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If the token is available, navigate to Home, else Welcome
          if (snapshot.hasData && snapshot.data != null) {
            return const Home();
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}








































// TypeAheadField(
//   controller: _controller,
//    builder: (context, controller, focusNode) {
//     return TextField(
//       controller: controller,
//       focusNode: focusNode,
//       decoration: InputDecoration(
//                                 filled: true, // Enable filling the background
//                                 fillColor: const Color.fromRGBO(255, 198, 201, 1),
//                                 hintText: '...بحث',
//                                 hintStyle: TextStyle(fontFamily:myfont,color: Colors.red),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                   borderSide: BorderSide.none, // No border
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                   borderSide:
//                                       BorderSide.none, // No border when focused
//                                 ),
//                                 alignLabelWithHint:
//                                     true, // Align hint text with label
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                     vertical:
//                                         10), // Adjust vertical padding to center
//                                 // Reduce the height of the field, making it more compact
//                               ),

//     );

//   },

  

//   itemBuilder:(context, result) {
//     if(entering_ingredients){
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           title: Text(result['name'].toString()),
//         )
//       );
//     }
//     else{
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           title: Text(result['title'].toString()),
//           subtitle: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//             Row(
//                                               children: [
//                                                 Time_Red,
//                                                 Padding(
//                                                   padding: const EdgeInsets.fromLTRB(
//                                                       5, 0, 0, 0),
//                                                   child: Text(
//                                                     result['time'].toString(),
//                                                     style: TextStyle(fontFamily:myfont,
//                                                         color: const Color.fromRGBO(
//                                                             253, 93, 105, 1)),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.fromLTRB(
//                                                       0, 0, 5, 0),
//                                                   child: Text(
//                                                     result['rating'].toString(),
//                                                     style: TextStyle(fontFamily:myfont,
//                                                         color: const Color.fromRGBO(
//                                                             253, 93, 105, 1)),
//                                                   ),
//                                                 ),
//                                                 Star_Red
//                                               ],
//                                             )
//             ],
//           ),
          
//         )
//       );
//     }
//   },
//    onSelected:(value) {
//      if(entering_ingredients){
//  ingridients.add({'ingridient':value.toString(),'quantity':50});
//                                     height+=80;
//                                        object.setState(() {
                      
//                     });
//      }
//      else{
//       Get.to(PopularDishe(),arguments: {'id':value['id']},transition: Transition.rightToLeft);
//      }
//    },  
//    suggestionsCallback:(search) {
//     if(entering_ingredients && search.length>=3){
//       return Ingridients_Helper.Search_Ingridients(search);
//     }
//     else{
//       if(search.length>=3){
//         return Reciepe_Helper.Get_Reciepes_By_Name(search,true);
//       }
//       else{
//         return [];
//       }

//     }
//   },),