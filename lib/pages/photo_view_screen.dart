import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({Key? key, required this.imageFiles}) : super(key: key);

  final File imageFiles;

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FileImage(widget.imageFiles),
    );
  }
}
