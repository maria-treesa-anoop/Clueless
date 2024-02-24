import 'package:clueless_app/firebase_options.dart';
import 'package:clueless_app/screens/gallery_pg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/gallery_pg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Wardrobe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  void addData() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .add({
          'name': _nameController.text,
          'category': _categoryController.text,
          'color': _colorController.text,
        })
        .then((_) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wardrobe Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: _colorController,
              decoration: InputDecoration(labelText: 'Color'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                addData();
              },
              child: Text('Add Item'),
            ),
            ElevatedButton(
              onPressed: (){
                addData();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryPage()));
              },
              child: Text('Go to Gallery'),
            ),
          ],
        ),
      ),
  //     
    );
  }
}



class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Wardrobe Items'),
      ),
      body: Center(
        child: Text('Display Page'),
      ),
    );
  }
}

class OrganizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organize Wardrobe'),
      ),
      body: Center(
        child: Text('Organization Page'),
      ),
    );
  }
}

