import 'package:aquaria/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage ({super.key});

  @override
  State<CollectionPage> createState() => CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> with TickerProviderStateMixin {

  double value = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
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

      body: 
      PageView(
        children:[
        Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            child: Positioned.fill(
              top: 0,
              left: 0,
              child: Align(
                alignment: Alignment.center,
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
                        children: <Widget> [
                          SvgPicture.asset(
                            'assets/fish-tank.svg',
                            height: screenHeight * 0.13,
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
                              padding: const EdgeInsets.all(23.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Nemo is a false clownfish or a clown anemonefish. True anemonefish/orange clownfish look very similar but live in different habitats. Their most distinctive traits are their orange bodies, three white bands with a black outline and black tips around the fins. They are small animals.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "First Catch Date :",
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
                              "1 / 10",
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
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Nemo Fish",
                            style: TextStyle(
                              color: const Color(0xff0F0F8FA),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.25)
                                )
                              ],
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
            ),
          ),
        ],
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            child: Positioned.fill(
              top: 0,
              left: 0,
              child: Align(
                alignment: Alignment.center,
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
                        children: <Widget> [
                          SvgPicture.asset(
                            'assets/fish-tank.svg',
                            height: screenHeight * 0.13,
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
                              padding: const EdgeInsets.all(23.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Nemo is a false clownfish or a clown anemonefish. True anemonefish/orange clownfish look very similar but live in different habitats. Their most distinctive traits are their orange bodies, three white bands with a black outline and black tips around the fins. They are small animals.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "First Catch Date :",
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
                              "2 / 10",
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
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Nemo Fish",
                            style: TextStyle(
                              color: const Color(0xff0F0F8FA),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.25)
                                )
                              ],
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
            ),
          ),
        ],
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            child: Positioned.fill(
              top: 0,
              left: 0,
              child: Align(
                alignment: Alignment.center,
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
                        children: <Widget> [
                          SvgPicture.asset(
                            'assets/fish-tank.svg',
                            height: screenHeight * 0.13,
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
                              padding: const EdgeInsets.all(23.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Nemo is a false clownfish or a clown anemonefish. True anemonefish/orange clownfish look very similar but live in different habitats. Their most distinctive traits are their orange bodies, three white bands with a black outline and black tips around the fins. They are small animals.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "First Catch Date :",
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
                              "3 / 10",
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
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Nemo Fish",
                            style: TextStyle(
                              color: const Color(0xff0F0F8FA),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.25)
                                )
                              ],
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
            ),
          ),
        ],
      ),
      ],
      )
    );
  }
}