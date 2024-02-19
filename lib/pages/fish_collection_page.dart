import 'dart:async';

import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:aquaria/services/http_service.dart';
import 'package:aquaria/widgets/fishcollection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> with TickerProviderStateMixin {
  String? fishId;
  String? fishName;
  String? fishDesc;
  String? image;

  double value = 0;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // double screenWidth = screenSize.width;
    // double screenHeight = screenSize.height;
    // return const Placeholder();
    return Scaffold(
      backgroundColor: const Color(0xff00B4ED),
      appBar: AppBar(
        backgroundColor: const Color(0xff007D0FC),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
          child: const Icon(Icons.close),
        ),
        title: const Text('Fish Collection'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fishcollection(),
        builder: (BuildContext context, AsyncSnapshot<List<Fish>?> snapshot) {
          List<Fish>? fishList = snapshot.data;
          print(snapshot.data);
          if (fishList != null) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                runSpacing: 4,
                children: fishList.map((Fish fish) {
                  return FishCollectionWidget(id: fish.id!, name: fish.name!, description: fish.description!, image: fish.image!);
                  // catchdate: fish.catchdate!);
                }).toList(),
              ),
            ));
          } else {
            print('fishlist: $fishList');
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
