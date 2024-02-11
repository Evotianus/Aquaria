import 'package:aquaria/pages/home_page.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xff007d0fc),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
            );
          },
          child: const Icon(Icons.close),
        ),
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            // child: BarChart(
            //   BarChartData(
            //     borderData: FlBorderData(
            //       border: const Border(
            //         top: BorderSide.none,
            //         right: BorderSide.none,
            //         left: BorderSide(width: 1),
            //         bottom: BorderSide(width: 1),
            //       ),
            //     ),
            //     groupsSpace: 10,
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}
