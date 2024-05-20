import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Theam/theme.dart';
import '../widget/profile_field.dart';

class ProfilePageModel extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('User');

  String? _profileImageUrl;
  Map<String, dynamic>? _userData; // Store user data locally

  String? get profileImageUrl => _profileImageUrl;

  ProfilePageModel() {
    fetchUserData(); // Fetch user data initially
  }

  Future<void> fetchUserData() async {
    final docSnapshot = await usersCollection.doc(user?.uid).get();
    _userData = docSnapshot.data() as Map<String, dynamic>?;

    _profileImageUrl = _userData?['profileImageUrl'];
    notifyListeners();
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      await usersCollection.doc(user?.uid).update({field: value});
      // Update local user data
      _userData?[field] = value;
      notifyListeners(); // Notify UI of changes
    } catch (e) {
      print('Error updating profile field: $e');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    if (imageFile != null) {
      var storageInstance = FirebaseStorage.instance;

      try {
        var ref = await storageInstance
            .ref()
            .child("profile${user?.uid}/${imageFile.path.split('/').last}")
            .putFile(imageFile);

        var imageUrl = await ref.ref.getDownloadURL();
        await usersCollection
            .doc(user?.uid)
            .update({'profileImageUrl': imageUrl});
        _profileImageUrl = imageUrl;
        notifyListeners();
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfilePageModel(),
      child: _ProfilePageContent(),
    );
  }
}

class _ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<_ProfilePageContent> {
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfilePageModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemeData.backgroundBlack,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppThemeData.primaryColor,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 10),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                          backgroundImage: model.profileImageUrl != null
                              ? NetworkImage(model.profileImageUrl!)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () async {
                            var img = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              model.uploadImage(imageFile);
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
                    future: model.usersCollection.doc(model.user?.uid).get(),
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
                                model.updateProfileField('name', newValue);
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
                                model.updateProfileField('age', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Place",
                              value: userData?['place'],
                              onEdit: (newValue) {
                                model.updateProfileField('place', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Gender",
                              value: userData?['gender'],
                              onEdit: (newValue) {
                                model.updateProfileField('gender', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Blood Group",
                              value: userData?['blood'],
                              onEdit: (newValue) {
                                model.updateProfileField('blood', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Size",
                              value: userData?['size'],
                              onEdit: (newValue) {
                                model.updateProfileField('size', newValue);
                              },
                            ),
                            ProfileField(
                              label: "Phone",
                              value: userData?['phone'],
                              onEdit: (newValue) {
                                model.updateProfileField('phone', newValue);
                              },
                            ),
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
}
