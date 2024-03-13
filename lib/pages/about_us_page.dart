import 'package:aquaria/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:aquaria/features/utils.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
        backgroundColor: isDarkTheme ? darkBlueColor : blueColor,
        appBar: AppBar(
          backgroundColor: const Color(0xff007d0fc),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
              );
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'About Us',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ClipRRect(
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        width: 370,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Aquaria is an app that adapts to solve productivity problems among students. This application is expected to be able to help students find their way of studying so that they can consistently maintain their learning performance and find their own productivity hours. \n\n Aquaria also adopts a unique learning method with the hope of increasing student motivation, namely by combining this form of productivity tools application with the gamification method. Based on several studies, this method can increase students' learning motivation so that it will help in achieving the goal of creating this application, namely to increase learning motivation so that students can achieve productivity.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Developer:",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff0fe4600),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/evo.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Evotianus",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Ketua Kelompok",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "The Legendary Weeb who has reached the peak of wisdom in the world of weeb. He has the ability to sleep for 25 hours, which increases his life expectancy. The others also call him 'Sepuh Weeboo'. He love Hatsune Miku.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/cath.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Catherine Olivia Winanda",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Anggota Kelompok",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Just an ordinary person who studies diligently and loves cleanliness. A short girl who likes coding.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/didi.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Fredy Sunjaya",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Anggota Kelompok",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "The Runner that never give up on do the best for his life. Good people who sharing his love and care with other. He a chinese.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/peter.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Peter Pratama Mulyadi",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Anggota Kelompok",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Best world assets that always help other peoples and do his best for future world, he love do works charity and do caring with his own way. He fight the villian with his genius talent and brain for other sake. His favourrite food is Indomie and Milk for its drink.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/tasia.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Stephanie Anastasia Makmur",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Anggota Kelompok",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "A good mother who love her child and the best mother figure for other moms. She love cooking and always do his best for cooking indomie for her best son and world assets child. Oh dont forget she an Asian Mother too.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Special Thanks To:",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff0fe4600),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0308bcb),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 450,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      ClipRRect(
                        child: Image(
                          image: const AssetImage('assets/dosen.png'),
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        width: 370,
                        height: 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Ibu Azani Cempaka Sari, S.Kom., M.T.I",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Dosen Pembimbing",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Just Dosen",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
            ],
          ),
        ));
  }
}
