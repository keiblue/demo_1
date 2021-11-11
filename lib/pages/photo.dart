import 'dart:io';

import 'package:demo_1/pages/photo_view_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<File> imagenes = [];
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: imagenes.length,
          itemBuilder: (BuildContext context, int index) {
            File imageFile = File(imagenes[index].path);
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoViewScreen(
                                imageFiles: imageFile,
                              )));
                },
                child: Image.file(imageFile));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _optionsDialogBox,
              child: const Icon(Icons.add),
              heroTag: null,
            ),
            const SizedBox(
              height: 10,
              width: 5,
            ),
            FloatingActionButton.extended(
              label: const Text("Back"),
              icon: const Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)},
              heroTag: null,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                      child: const Text("Tomar foto"),
                      onTap: () {
                        Navigator.pop(context);
                        _loadImageCamera();
                      }),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                      child: const Text("Elegir desde galeria"),
                      onTap: () {
                        Navigator.pop(context);
                        _loadImage();
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future _loadImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      imagenes.add(File(image.path));
    });
  }

  _loadImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      imagenes.add(File(image.path));
    });
  }
}
