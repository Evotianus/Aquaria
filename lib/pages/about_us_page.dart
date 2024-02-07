import 'package:aquaria/pages/home_page.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget
{
  const AboutUsPage({super.key});

  @override
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
                builder: (BuildContext context) => const HomePage()
              ),
            );
          },
          child: const Icon(Icons.close),
        ),
        title: const Text('About Us'),
        centerTitle: true,
      ),

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

          ],
        ),
      )
    );
  }
}