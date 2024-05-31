// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class Carousel extends StatelessWidget {
//   const Carousel({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(height: 200.0),
//       items: [
//         "assets/Images/img_1.png",
//         "assets/Images/logo.jpg",
//         "assets/Images/img_2.png",
//         "assets/Images/img_3.png",
//       ].map((String imageUrl) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 color: Colors.amber,
//                 image: DecorationImage(
//                   image: AssetImage(imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }
//


import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('carousel_images').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading images'));
        }

        final imageDocs = snapshot.data?.docs ?? [];

        if (imageDocs.isEmpty) {
          return Center(child: Text('No images found'));
        }

        final imageUrls = imageDocs.map((doc) => doc['url'] as String).toList();

        return CarouselSlider(
          options: CarouselOptions(height: 200.0),
          items: imageUrls.map((String imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
