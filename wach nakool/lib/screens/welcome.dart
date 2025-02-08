import 'package:flutter/material.dart';
import 'transitions.dart';
import 'package:get/get.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
return  
      //   routes: {

      //   Transitions.pageRoute:(ctx)=>Transitions(),
      // },
       Scaffold(
       
      

    body: SizedBox(
      height: double.infinity,
      child: ListView(
        children: [Center(
        
          child: Column(
            
            children: [
        Container(
          
          height: 500,
          width: 400,
          margin:const  EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Image.asset('assets/welcomescreen/logo.png'),
        ),
        
        Padding(
                        padding: const EdgeInsets.fromLTRB(15, 12, 15, 20),
                        child: SizedBox(
                          
                          width: 400,
                          height: 60,
                          child: DecoratedBox(
                            
                            decoration: BoxDecoration(
                          
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: ElevatedButton(
                                                        onPressed: () {
                            Get.off(()=> ( const Transitions()),transition: Transition.downToUp,duration: const Duration(seconds: 1));
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  const Color.fromRGBO(233, 77, 98, 1),
                                                        ),
                              child: const Center(
                                child: Text(
                                
                                  "اكتشف التطبيق",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )),
        
            ],
          ),
        ),]
      ),
    )
    );
  }
}