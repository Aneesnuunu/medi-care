import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_care/User/u06.1_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../Model/u08_profile_page_model.dart';
import '../widget/appbar.dart';
import '../widget/profile_field.dart';
import 'u06.1_navigationbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      appBar: CustomAppBar(
        title: "Profile",
        onBackButtonPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainHome()),
          );
        },
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
                  const SizedBox(height: 40),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: model.profileImageUrl != null
                              ? NetworkImage(model.profileImageUrl!)
                              : null,
                          child: model.isLoading
                              ? CircularProgressIndicator()
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: model.isLoading
                              ? null
                              : () async {
                            var img = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              model.setLoading(true);
                              await model.uploadImage(imageFile);
                              model.setLoading(false);
                            }
                          },
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
