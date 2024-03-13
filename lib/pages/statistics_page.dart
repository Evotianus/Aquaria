import 'package:aquaria/features/utils.dart';
import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/home_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int touchedIndex = -1;

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

  Widget getYearlyTitles(double value, TitleMeta meta) {
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
      space: 5,
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

  FlTitlesData get titlesDataYearly => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            getTitlesWidget: getYearlyTitles,
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
                fontSize: 13,
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
          'Your Progress',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getProgressData(),
        builder: (BuildContext context, AsyncSnapshot<List<List<dynamic>?>> snapshot) {
          // print(snapshot.data![2][0]);
          // return const SizedBox();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.data.toString()),
            );
          }
          if (snapshot.data != null) {
            List<dynamic>? catchList = snapshot.data![0];
            List<dynamic>? urgencyList = snapshot.data![4];

            // print("CL: $catchList");
            // print("Name: ${catchList?[0]['name']}");
            // print("Name: ${catchList?[0]['name'].runtimeType}");

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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data![5]![0]['completed_task_count'].toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
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
                          child: Column(
                            children: [
                              Text(
                                snapshot.data![5]![1]['pending_task_count'].toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
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
                            "Weekly's Focus Time Distribution",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Colors.black),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total focused time: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                snapshot.data![6]![0]['total_weekly_time'] ?? "0",
                                // "abs",
                                style: const TextStyle(
                                  color: Color(0xff35A6F6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
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
                                  for (var index = 0; index < snapshot.data![1]!.length; index++)
                                    // var item = snapshot.data![index];
                                    BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          width: 20,
                                          toY: double.parse(snapshot.data![1]![index]['totalMinutes'].toString()),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 15),
                            child: const Text(
                              "Task Distribution",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            child: Divider(color: Colors.black),
                          ),
                          AspectRatio(
                            aspectRatio: 1.3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                            // touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            //   setState(() {
                                            //     if (!event.isInterestedForInteractions ||
                                            //         pieTouchResponse == null ||
                                            //         pieTouchResponse.touchedSection == null) {
                                            //       touchedIndex = -1;
                                            //       return;
                                            //     }
                                            //     touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                            //   });
                                            // },
                                            ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 60,
                                        sections: showingSections(snapshot.data?[4]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: ,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(urgencyList![0]['color'])),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "Critical",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text("${double.parse(urgencyList[0]['chart'].toString()).round()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(urgencyList[1]['color'])),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "High",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text("${double.parse(urgencyList[1]['chart'].toString()).round()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(urgencyList[2]['color'])),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "Medium",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text("${double.parse(urgencyList[2]['chart'].toString()).round()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(urgencyList[3]['color'])),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "Low",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text("${double.parse(urgencyList[3]['chart'].toString()).round()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(urgencyList[4]['color'])),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "No Category",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text("${double.parse(urgencyList[4]['chart'].toString()).round()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
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
                            "March's Focus Time Distribution",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Colors.black),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total focused time: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                snapshot.data![6]![1]['total_monthly_time'] ?? "0",
                                style: const TextStyle(
                                  color: Color(0xff35A6F6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
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
                                titlesData: const FlTitlesData(show: false),
                                barTouchData: barTouchData,
                                gridData: const FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 20,
                                ),
                                alignment: BarChartAlignment.spaceAround,
                                borderData: FlBorderData(show: false),
                                barGroups: [
                                  for (var index = 0; index < snapshot.data![2]!.length; index++)
                                    // var item = snapshot.data![index];
                                    BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          width: 5,
                                          toY: double.parse(snapshot.data![2]![index]['daily_total_minutes'].toString()),
                                        ),
                                      ],
                                      showingTooltipIndicators: [0],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("1/1"),
                              Text("1/9"),
                              Text("1/16"),
                              Text("1/24"),
                              Text("1/31"),
                            ],
                          )
                        ],
                      ),
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
                            "2024's Focus Time Distribution",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Colors.black),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total focused time: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                snapshot.data![6]![2]['total_yearly_time'] ?? "0",
                                style: const TextStyle(
                                  color: Color(0xff35A6F6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
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
                                titlesData: const FlTitlesData(show: false),
                                barTouchData: barTouchData,
                                gridData: const FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 20,
                                ),
                                alignment: BarChartAlignment.spaceAround,
                                borderData: FlBorderData(show: false),
                                barGroups: [
                                  for (var index = 0; index < snapshot.data![3]!.length; index++)
                                    // var item = snapshot.data![index];
                                    BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          width: 10,
                                          toY: double.parse(snapshot.data![3]![index]['monthly_total_minutes'].toString()),
                                        ),
                                      ],
                                      showingTooltipIndicators: [0],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Jan", style: TextStyle(fontSize: 13)),
                              Text("Feb", style: TextStyle(fontSize: 13)),
                              Text("Mar", style: TextStyle(fontSize: 13)),
                              Text("Apr", style: TextStyle(fontSize: 13)),
                              Text("May", style: TextStyle(fontSize: 13)),
                              Text("Jun", style: TextStyle(fontSize: 13)),
                              Text("Jul", style: TextStyle(fontSize: 13)),
                              Text("Aug", style: TextStyle(fontSize: 13)),
                              Text("Sep", style: TextStyle(fontSize: 13)),
                              Text("Oct", style: TextStyle(fontSize: 13)),
                              Text("Nov", style: TextStyle(fontSize: 13)),
                              Text("Des", style: TextStyle(fontSize: 13)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      // width: screenWidth - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Most recent catch",
                            style: TextStyle(fontSize: 20),
                          ),
                          Column(
                            children: [
                              for (var item in catchList!)
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("${(catchList.indexOf(item) + 1).toString()}."),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SvgPicture.asset(
                                        'assets/fish/${item['image']}.svg',
                                        width: screenWidth * 0.2,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // catchList[0]['name'],
                                            item['name'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    item['minutes'].toString(),
                                                    style: const TextStyle(fontSize: 16),
                                                  ),
                                                  const Text(
                                                    " mins",
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                DateFormat('d MMM yyyy').format(DateTime.parse(item['created_at'])).toString(),
                                                style: const TextStyle(fontSize: 16, color: Color(0xff808080)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
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

  List<PieChartSectionData> showingSections(data) {
    print("Data: $data");
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 16.0;
      final radius = isTouched ? 70.0 : 60.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(int.parse(data[0]['color'])),
            value: (data[0]['chart'] == 0 ? 0 : data[0]['chart']),
            title: '${double.parse(data[0]['chart'].toString()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(int.parse(data[1]['color'])),
            value: (data[1]['chart'] == 0 ? 0 : data[1]['chart']),
            title: '${double.parse(data[1]['chart'].toString()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(int.parse(data[2]['color'])),
            value: (data[2]['chart'] == 0 ? 0 : data[2]['chart']),
            title: '${double.parse(data[2]['chart'].toString()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Color(int.parse(data[3]['color'])),
            value: (data[3]['chart'] == 0 ? 0 : data[3]['chart']),
            title: '${double.parse(data[3]['chart'].toString()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Color(int.parse(data[4]['color'])),
            value: (data[4]['chart'] == 0 ? 0 : data[4]['chart']),
            title: '${double.parse(data[4]['chart'].toString()).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
