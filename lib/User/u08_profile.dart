import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Theam/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widget/profile_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchProfileImageUrl();
  }

  Future<void> fetchProfileImageUrl() async {
    final docSnapshot = await usersCollection.doc(user?.uid).get();
    final userData = docSnapshot.data() as Map<String, dynamic>?;

    setState(() {
      profileImageUrl = userData?['profileImageUrl'];
    });
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      await usersCollection.doc(user?.uid).update({field: value});
    } catch (e) {
      print("Error updating $field: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemeData.backgroundBlack,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppThemeData.primaryColor),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 10),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl!)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () async {
                            var img = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              uploadImage(imageFile);
                            }
                          },
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: usersCollection.doc(user?.uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic>? userData =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        return Column(
                          children: [
                            ProfileField(
                              label: "Name",
                              value: userData?['name'],
                              onEdit: (newValue) {
                                updateProfileField('name', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Email Address",
                              value: userData?['email'],
                              // Do not provide an onEdit callback for the email field
                            ),
                            ProfileField(
                              label: "Age",
                              value: userData?['age'],
                              onEdit: (newValue) {
                                updateProfileField('age', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Place",
                              value: userData?['place'],
                              onEdit: (newValue) {
                                updateProfileField('place', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Gender",
                              value: userData?['gender'],
                              onEdit: (newValue) {
                                updateProfileField('gender', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Blood Group",
                              value: userData?['blood'],
                              onEdit: (newValue) {
                                updateProfileField('blood', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Size",
                              value: userData?['size'],
                              onEdit: (newValue) {
                                updateProfileField('size', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Phone",
                              value: userData?['phone'],
                              onEdit: (newValue) {
                                updateProfileField('phone', newValue);
                              },
                            ),
                            // Add other ProfileField widgets similarly for other fields
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage(File imageFile) async {
    if (imageFile != null) {
      var storageInstance = FirebaseStorage.instance;

      try {
        var ref = await storageInstance
            .ref()
            .child("profile${imageFile.path}")
            .putFile(imageFile);

        var imageUrl = await ref.ref.getDownloadURL();
        usersCollection.doc(user?.uid).update({'profileImageUrl': imageUrl});
        setState(() {
          profileImageUrl = imageUrl;
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }
}
