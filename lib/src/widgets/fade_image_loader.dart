import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ImageLoader extends StatefulWidget {
  final String imageUrl;

  const ImageLoader({super.key, required this.imageUrl});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    fetchImageBytes();
  }

  Future<void> fetchImageBytes() async {
    final response = await http.get(Uri.parse(widget.imageUrl));
    if (response.statusCode == 200) {
      print("this is response comming from data");
      setState(() {
        imageBytes = response.bodyBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imageBytes == null ? Container() : Image.memory(imageBytes!),
    );
  }
}
