import 'package:flutter/material.dart';

class GalleryAssets extends StatefulWidget {
  const GalleryAssets({Key? key}) : super(key: key);

  @override
  State<GalleryAssets> createState() => _GalleryAssetsState();
}

class _GalleryAssetsState extends State<GalleryAssets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('lib/assets/image/150.png'),
            ),
            Image.asset("lib/assets/image/150.png"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Back"),
        icon: const Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
      ),
    );
  }
}
