import 'package:aquaria/pages/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class FishCollectionWidget extends StatelessWidget {
  int id;
  String name;
  String description;
  String image;
  DateTime catchdate;

  FishCollectionWidget({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.catchdate,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    // return const Placeholder();
    String tempdate;
    tempdate = DateFormat('dd/MM/yyyy').format(catchdate);
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/fish-coll.svg',
              height: screenHeight * 0.82,
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/fish-tank.svg',
                        height: screenHeight * 0.15,
                      ),
                      SvgPicture.asset(
                        "assets/fish/$image.svg",
                        height: screenHeight * 0.1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 390,
                    width: screenWidth * 0.63,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(
                        0xff308BCC,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "First Catch Date : ${(catchdate.year == 1910 ? "00/00/0000" : tempdate)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Color(0xff0FE4600), borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.only(left: 25, right: 25, top: 4, bottom: 4),
                    child: Text(
                      "$id/10",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: const Color(0xff0F0F8FA),
                      shadows: <Shadow>[Shadow(offset: Offset(0.0, 4.0), blurRadius: 4.0, color: Color.fromRGBO(0, 0, 0, 0.25))],
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
