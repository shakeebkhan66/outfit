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

bool checkIfLikeExists({List<dynamic>? list,String? email, String? ip}){
  if(list == null || list == []){
    return false;
  }else {
    List<Likes> likes = list.map((item) {
        if (item is Map<String, dynamic>) {
          return Likes.fromJson(item);
        } else {
          return const Likes(email: "", ip: "");
        }
      }).toList();
      print("email");
      print(list);
      print(likes);
      if(likes.contains(const Likes(email: "")) || likes.contains(const Likes(ip: "")) ||
         likes.contains(const Likes(email: null)) || likes.contains(const Likes(ip: null))||
         likes.contains(const Likes(email: "null")) || likes.contains(const Likes(ip: "null"))
      ){
        return false;
      }else {
        if(likes.contains(Likes(email: email)) || likes.contains(Likes(ip: ip))){
          return true;
        }else{
          return false;
        }
      }
  }
  
}