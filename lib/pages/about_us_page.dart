import 'package:aquaria/pages/home_page.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> b2f8be590a52d85950e0068bec96f11d41a0c50c

class AboutUsPage extends StatelessWidget
{
  const AboutUsPage({super.key});

  @override
<<<<<<< HEAD
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(
        backgroundColor: const Color(0xff007D0FC),
        leading: GestureDetector(
          onTap: ()
          {
            Navigator.of(context).pushReplacement
            (
              MaterialPageRoute
              (
=======
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xff00B4ED),
      appBar: AppBar(
        backgroundColor: const Color(0xff007D0FC),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
>>>>>>> b2f8be590a52d85950e0068bec96f11d41a0c50c
                builder: (BuildContext context) => const HomePage()
              ),
            );
          },
          child: const Icon(Icons.close),
        ),
        title: const Text('About Us'),
        centerTitle: true,
      ),

<<<<<<< HEAD
      body: SingleChildScrollView
      (  
        child: Column
        (
          children:
          [
            Padding
            (
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Container
              (
                decoration: BoxDecoration(color: Color(0xffEEEEEE), borderRadius: BorderRadius.circular(15)),
                width: 450, height: 500,

                child: Center(child: Text("About Us", style: TextStyle(fontSize: 25, height: 5),))
              ),
            ),

            Padding
            (
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container
              (
                decoration: BoxDecoration(color: Color(0xffEEEEEE), borderRadius: BorderRadius.circular(15)),
                width: 450, height: 500,
              ),
            ),

            Padding
            (
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container
              (
                decoration: BoxDecoration(color: Color(0xffEEEEEE), borderRadius: BorderRadius.circular(15)),
                width: 450, height: 500,
              ),
            ),

            Padding
            (
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container
              (
                decoration: BoxDecoration(color: Color(0xffEEEEEE), borderRadius: BorderRadius.circular(15)),
                width: 450, height: 500,
              ),
            ),

=======
      body: SingleChildScrollView(  
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff0308BCB),
                  borderRadius: BorderRadius.circular(40),
                ),
                width: 450,
                height: 410,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      child: const Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Developer:",
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color(0xff0FE4600),
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/evo.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Evotianus",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Ketua Kelompok",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/cath.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Catherine Olivia Winanda",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Anggota Kelompok",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/didi.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Fredy Sunjaya",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Anggota Kelompok",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/peter.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Peter Pratama Mulyadi",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Anggota Kelompok",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/tasia.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Stephanie Anastasia Makmur",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Anggota Kelompok",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Special Thanks To:",
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color(0xff0FE4600),
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
                  color: Color(0xff0308BCB),
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
                        image: AssetImage('assets/dosen.png'),
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      width: 370,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Ibu Azani Cempaka Sari, S.Kom., M.T.I",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Dosen Pembimbing",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit, sunt culpa. Fuga accusantium consequuntur cumque magnam quam excepturi quia explicabo itaque, dolorum porro aliquam odit obcaecati temporibus totam. Officia asperiores sit esse corporis magni atque dignissimos numquam provident obcaecati mollitia. Illum exercitationem itaque perferendis nihil, facilis nostrum cupiditate culpa doloremque.",
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
>>>>>>> b2f8be590a52d85950e0068bec96f11d41a0c50c
          ],
        ),
      )
    );
  }
}