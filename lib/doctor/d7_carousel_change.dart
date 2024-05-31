import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Theam/theme.dart';
import '../widget/appbar.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isUploading = false; // Flag to indicate if upload is in progress

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      }
    });
  }

  Future<void> _deleteImage(String documentId) async {
    await _firestore.collection('carousel_images').doc(documentId).delete();
  }

  Future<void> _uploadImages() async {
    setState(() {
      _isUploading = true; // Start uploading
    });

    for (var image in _images) {
      final fileName = image.path.split('/').last;
      final ref = _storage.ref().child('carousel_images').child(fileName);
      await ref.putFile(image);
      final downloadUrl = await ref.getDownloadURL();
      await _firestore.collection('carousel_images').add({'url': downloadUrl});
    }

    setState(() {
      _isUploading = false; // Finished uploading
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Images Uploaded')));
  }

  Future<void> _showDeleteConfirmation(BuildContext context, String documentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppThemeData.backgroundBlack,
          title: const Text('Delete Image',style: TextStyle(color: Colors.white),),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this image?',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteImage(documentId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Carousel Change",
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              _images.isNotEmpty
                  ? SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(_images[index]),
                    );
                  },
                ),
              )
                  : Container(height: 200, color: Colors.grey[200]),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                onPressed: _pickImages,
                child: const Text(
                  'Select Images',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                onPressed: _uploadImages,
                child: const Text(
                  'Upload Images',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Available Images",style: TextStyle(color: Colors.white,fontSize: 20),),
              const SizedBox(height: 20,),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('carousel_images').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final imageUrl = documents[index]['url'] as String;
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Do nothing when the image is tapped
                              },
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  _showDeleteConfirmation(context, documents[index].id);
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          if (_isUploading)
            Center(
              child: Container(
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
