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
  const CheckLikeExists({super.key, required this.email, required this.list});

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

int likesCount(dynamic count) {
  if (count is List<Map>) {
    return count.length;
  }
  if (count is List<dynamic>) {
    List<Likes> likes = count.map((item) {
      if (item is Map<String, dynamic>) {
        return Likes.fromJson(item);
      } else {
        return const Likes(email: '', ip: '');
      }
    }).toList();
    return likes.length;
  } else {
    List<dynamic> list = count.values.toList();
    List<Likes> likes = list.map((item) {
      if (item is Map<String, dynamic>) {
        return Likes.fromJson(item);
      } else {
        return const Likes(email: '', ip: '');
      }
    }).toList();
    return likes.length;
  }
}

bool checkIfLikeExists({String? list, String? email}) {
  if (list == null) {
    return false;
  } else {
    if (email != null && email != "" && list.toString().contains(email)) {
      return true;
    } else {
      return false;
    }
  }
}
