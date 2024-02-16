import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 34,
            interval: 20,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff00B4ED),
      appBar: AppBar(
        backgroundColor: const Color(0xff007d0fc),
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
        title: const Text(
          'Your Progress',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getProgressData(),
        builder: (BuildContext, AsyncSnapshot<List<dynamic>> snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            // print(snapshot.data![0]['totalMinutes']);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth / 2 * 0.8,
                          decoration: const BoxDecoration(
                            color: Color(0xff35A6F6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: const Column(
                            children: [
                              Text(
                                "30",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Completed Task",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: screenWidth / 2 * 0.8,
                          decoration: const BoxDecoration(
                            color: Color(0xff35A6F6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: const Column(
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Pending Task",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Focused Time Distribution",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Colors.black),
                          ),
                          const Row(
                            children: [
                              Text(
                                "Total focused time: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "50",
                                style: TextStyle(
                                  color: Color(0xff35A6F6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " mins",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          AspectRatio(
                            aspectRatio: 1,
                            child: BarChart(
                              BarChartData(
                                titlesData: titlesData,
                                barTouchData: barTouchData,
                                gridData: const FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 20,
                                ),
                                alignment: BarChartAlignment.spaceAround,
                                borderData: FlBorderData(show: false),
                                barGroups: [
                                  for (var index = 0; index < snapshot.data!.length; index++)
                                    // var item = snapshot.data![index];
                                    BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          width: 20,
                                          toY: double.parse(snapshot.data![index]['totalMinutes'].toString()),
                                        ),
                                      ],
                                      showingTooltipIndicators: [0],
                                    )
                                  // for (var (item, index) in snapshot.data.length)
                                  //   BarChartGroupData(
                                  //     x: index,
                                  //     barRods: [
                                  //       BarChartRodData(
                                  //         width: 20,
                                  //         toY: 60,
                                  //       ),
                                  //     ],
                                  //     showingTooltipIndicators: [0],
                                  //   ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
