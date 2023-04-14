import 'package:flutter/material.dart';
import 'package:outfit/src/data/model/products_model.dart';

class CustomText extends StatelessWidget {
  final List<dynamic> list;
  const CustomText({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    List<Likes> likes = list.map((item) {
  if (item is Map<String, dynamic>) {
    return Likes.fromJson(item);
  } else {
    return const Likes(email: '', ip: '');
  }
}).toList();
    return Text(likes.length.toString());
  }
}

class CheckLikeExists extends StatelessWidget {
  final String email;
  final List<dynamic> list;
  const CheckLikeExists({super.key,required this.email, required this.list});

  @override
  Widget build(BuildContext context) {
    List<Likes> likes = list.map((item) {
      if (item is Map<String, dynamic>) {
        return Likes.fromJson(item);
      } else {
        return const Likes(email: '', ip: '');
      }
    }).toList();
    return Text(likes.length.toString());
  }
}

int likesCount(List<dynamic> count){
  List<Likes> likes = count.map((item) {
      if (item is Map<String, dynamic>) {
        return Likes.fromJson(item);
      } else {
        return const Likes(email: '', ip: '');
      }
    }).toList();
    return likes.length;
}

bool checkIfLikeExists({List<dynamic>? list,String? email, String? ip}){
  if(list == null || list == []){
    return false;
  }else {
      if(ip!=null && list.toString().contains(ip)){
        return true;
      }else if(email!=null && list.toString().contains(email)){
        return true;
      }else{
        return false;
      }
  }
  
}