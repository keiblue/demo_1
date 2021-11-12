import 'package:bloc/bloc.dart';
import 'package:demo_1/app/app_bloc_observer.dart';
import 'package:demo_1/bloc/user_list_bloc.dart';
import 'package:demo_1/pages/gallery.dart';
import 'package:demo_1/pages/photo.dart';
import 'package:demo_1/pages/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/get.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UserListBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paginaActual = 0;

  void _goToGetPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const GetPage()));
  }

  void _goToPostPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PostPage()));
  }

  void _goToGalleryPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GalleryAssets()));
  }

  void _goTocameraPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ImagePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo 01"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: OutlinedButton(
                    onPressed: _goToGetPage,
                    child: const Text("Get ()"),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: _goToPostPage,
                    child: const Text("Post ()"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 100,
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextButton(
                      onPressed: _goToGalleryPage,
                      child: const Text("Galeria")),
                ),
                Expanded(
                  flex: 5,
                  child: OutlinedButton(
                      onPressed: _goTocameraPage, child: const Text("Camera")),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility), label: "get"),
        ],
      ),
    );
  }
}
