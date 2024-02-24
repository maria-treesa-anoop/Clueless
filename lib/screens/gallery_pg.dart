import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Importing the image_picker package

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<File> _images = []; // List to store selected images
  List<bool> _availability = []; // List to store availability status of images

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(); // Pick multiple images

    if (pickedImages != null) {
      setState(() {
        _images.addAll(pickedImages.map((image) => File(image.path)));
        // Initialize availability status for newly added images
        _availability.addAll(List.generate(pickedImages.length, (index) => true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of grid columns
          crossAxisSpacing: 4.0, // Spacing between columns
          mainAxisSpacing: 4.0, // Spacing between rows
        ),
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle image tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(image: _images[index]),
                        ),
                      );
                    },
                    child: Container(
                height: 100, // Adjust the height as needed
                child: Image.file(
                  _images[index],
                  fit: BoxFit.cover,
                ),
              )
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Checkbox(
                        value: _availability[index],
                        onChanged: (value) {
                          setState(() {
                            _availability[index] = value ?? false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                _availability[index] ? 'Available' : 'Unavailable',
                style: TextStyle(
                  color: _availability[index] ? Colors.green : Colors.red,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: 'Pick Images',
        child: Icon(Icons.photo_library),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final File image;

  FullScreenImagePage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image'),
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}