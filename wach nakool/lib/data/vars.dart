import 'package:flutter/material.dart';

import 'icons.dart';
const String baseUrl = 'https://api-s-tawny.vercel.app';
bool showSearch_bar = false;
bool bottom = true;
double get_custom_height (context)  {
  return MediaQuery.sizeOf(context).height*0.35+MediaQuery.sizeOf(context).height*0.07*ingridients.length;
}

bool entering_ingredients = false;
late Future<List<Map<String,dynamic>>> reciepes_suggestions;
late Future<List<Map<String,dynamic>>> ingridients_suggestions;
String search_bar_text = '';
List Favourite=[Favourite_Button,Favourite_Button_Selected];
List search_suggestions = [
  'كسكس',
  'تيراميسو أرز',
  'سندويش دجاج',
  'الطوابع',
  'مقروض',
  'شربة',
  'مسفوف',
  'رفيس',
  'لوبيا'
];
List<Map<String, dynamic>> ingridients = [];





bool contains_map(Map<String,dynamic> map){
        for(int i=0;i<ingridients.length;i++){
          if(ingridients[i]['ingridient']==map['ingridient']){

            return true;

          }
          
        }
        return false;
}