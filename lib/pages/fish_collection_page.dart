import 'dart:async';

import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/features/utils.dart';
import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:aquaria/services/http_service.dart';
import 'package:aquaria/widgets/fishcollection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

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
  DateTime? catchdate;

  double value = 0;

  @override
  Widget build(BuildContext context) {
    List<dynamic> fishList = [
      {},
      {
        'id': 1,
        'name': "????",
        'description': "????",
        'image': "stingray_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 2,
        'name': "????",
        'description': "????",
        'image': "pufferfish_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 3,
        'name': "????",
        'description': "????",
        'image': "clownfish_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 4,
        'name': "????",
        'description': "????",
        'image': "salmon_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 5,
        'name': "????",
        'description': "????",
        'image': "swordfish_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 6,
        'name': "????",
        'description': "????",
        'image': "maskedbutterfly_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 7,
        'name': "????",
        'description': "????",
        'image': "threadfinbutterflyfish_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 8,
        'name': "????",
        'description': "????",
        'image': "goldfish_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 9,
        'name': "????",
        'description': "????",
        'image': "shark_black",
        'catchDate': "1910-10-10",
      },
      {
        'id': 10,
        'name': "????",
        'description': "????",
        'image': "redsnapperfish_black",
        'catchDate': "1910-10-10",
      },
    ];

    return Scaffold(
        backgroundColor: isDarkTheme ? darkBlueColor : blueColor,
        appBar: AppBar(
          backgroundColor: const Color(0xff07D0FC),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Fish Collection',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: fishcollection(),
          builder: (BuildContext context, AsyncSnapshot<List<Fish>?> snapshot) {
            List<Fish>? dataa = snapshot.data;
            print("data: ${dataa}");
            if (dataa != null) {
              for (Fish item in dataa!) {
                print("id ${item.id}");
                if (item.id == 1) {
                  fishList[1]['name'] = item.name;
                  fishList[1]['description'] = item.description;
                  fishList[1]['image'] = item.image;
                  fishList[1]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 2) {
                  fishList[2]['name'] = item.name;
                  fishList[2]['description'] = item.description;
                  fishList[2]['image'] = item.image;
                  fishList[2]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 3) {
                  fishList[3]['name'] = item.name;
                  fishList[3]['description'] = item.description;
                  fishList[3]['image'] = item.image;
                  fishList[3]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 4) {
                  fishList[4]['name'] = item.name;
                  fishList[4]['description'] = item.description;
                  fishList[4]['image'] = item.image;
                  fishList[4]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 5) {
                  fishList[5]['name'] = item.name;
                  fishList[5]['description'] = item.description;
                  fishList[5]['image'] = item.image;
                  fishList[5]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 6) {
                  fishList[6]['name'] = item.name;
                  fishList[6]['description'] = item.description;
                  fishList[6]['image'] = item.image;
                  fishList[6]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 7) {
                  fishList[7]['name'] = item.name;
                  fishList[7]['description'] = item.description;
                  fishList[7]['image'] = item.image;
                  fishList[7]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 8) {
                  fishList[8]['name'] = item.name;
                  fishList[8]['description'] = item.description;
                  fishList[8]['image'] = item.image;
                  fishList[8]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 9) {
                  fishList[9]['name'] = item.name;
                  fishList[9]['description'] = item.description;
                  fishList[9]['image'] = item.image;
                  fishList[9]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                } else if (item.id == 10) {
                  fishList[10]['name'] = item.name;
                  fishList[10]['description'] = item.description;
                  fishList[10]['image'] = item.image;
                  fishList[10]['catchDate'] = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt.toString()));
                }
              }
            }

            // print(snapshot.data);

            if (fishList != null) {
              return PageView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  // if (fishList[index] == null) {
                  //   return FishCollectionWidget(
                  //       id: -1, name: "????", description: "????", image: fishblank[index].image!, catchdate: DateTime.parse("00-00-0000"));
                  // }
                  return FishCollectionWidget(
                    id: fishList[index + 1]['id'],
                    name: fishList[index + 1]['name']!,
                    description: fishList[index + 1]['description']!,
                    image: fishList[index + 1]['image']!,
                    catchdate: DateTime.parse(fishList[index + 1]['catchDate'].toString()),
                  );
                },
              );
            } else {
              // print('fishlist: $fishList');
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
