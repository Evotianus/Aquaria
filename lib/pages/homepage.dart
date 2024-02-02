import 'dart:async';
import 'dart:math' as math;

import 'package:aquaria/features/utils.dart';
import 'package:aquaria/pages/settings_page.dart';
import 'package:aquaria/pages/aquarium_page.dart';
import 'package:aquaria/pages/login_page.dart';
import 'package:aquaria/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rive/rive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/rendering.dart';
import 'package:aquaria/widgets/bubble_button.dart';

double radius = 135;
double strokeWidth = 40;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Offset _currentDragOffset = Offset.zero;

  double currentAngle = 0;

  double startAngle = toRadian(90);

  double totalAngle = toRadian(360);

  double oldValue = 0;
  double value = 0;

  double paddleAngle = 3.1;

  final _pageController = PageController();

  late final AnimationController _alignmentController;
  late final Animation<Offset> _offsetAnimation;

  Color timerColor = Colors.white;
  Color todoColor = Colors.black.withOpacity(0.3);

  List<String> checkImage = ["unchecked", "checked"];
  List<int> isChecked = [0, 0];

  final PanelController _panelController = PanelController();
  final TextEditingController _taskController = TextEditingController();
  final OverlayPortalController _categoryController = OverlayPortalController();

  Duration timerDuration = const Duration(minutes: 5);
  int minutes = 0;
  int seconds = 0;
  bool isStopped = false;

  double opacityLevel = 1;
  double isFinished = 0;

  bool isAbsorb = false;

  final Color blueColor = Color(0xff00B4ED);
  final Color orangeColor = Color(0xffFE4600);

  Artboard? _fishingArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    _alignmentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(_alignmentController);

    rootBundle.load('assets/test-vid.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 2");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);
          trigger = stateMachineController!.findSMI('Start Animation');

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }
          trigger = stateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _fishingArtboard = artboard);
      },
    );

    _controller = SimpleAnimation('Timeline 2', autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    Size canvasSize = Size(screenSize.width, screenSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    Offset knobPos = toPolar(center - Offset(strokeWidth, strokeWidth),
        currentAngle + startAngle, radius);
    Timer? timer;
    int minutes = timerDuration.inMinutes.remainder(125);
    int seconds = timerDuration.inSeconds.remainder(60);

    bool isVisibleAddEdit = true;
    double screenDimValue = 0.5;
    List<String> categories = <String>[
      'Critical',
      'High',
      'Medium',
      'Low',
      'Very Low'
    ];

    return Scaffold(
      backgroundColor: blueColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(isVisibleAddEdit ? 0.5 : 0),
              BlendMode.darken,
            ),
            child: IgnorePointer(
              ignoring: isVisibleAddEdit ? true : false,
              child: Stack(
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      Stack(
                        children: [
                          _fishingArtboard == null
                              ? const SizedBox()
                              : Rive(artboard: _fishingArtboard!),
                          RiveAnimation.asset(
                            'assets/fish.riv',
                            fit: BoxFit.cover,
                            controllers: [_controller],
                          ),
                          Transform.translate(
                            offset: const Offset(0, 200),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -50,
                                  child: Text(
                                    "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                    style: const TextStyle(
                                        fontSize: 64, color: Colors.white),
                                  ),
                                ),
                                Positioned.fill(
                                  top: 120,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Opacity(
                                        opacity: opacityLevel,
                                        child: const Image(
                                          image: AssetImage("assets/reel.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  left: screenWidth / 2 - 25,
                                  child: Transform.rotate(
                                    angle: paddleAngle,
                                    alignment: Alignment.bottomCenter,
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: opacityLevel,
                                          child: const Image(
                                            image:
                                                AssetImage("assets/paddle.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: knobPos.dx - 25,
                                  top: knobPos.dy + 30,
                                  child: GestureDetector(
                                    onPanStart: (details) {
                                      RenderBox getBox = context
                                          .findRenderObject() as RenderBox;
                                      _currentDragOffset = getBox.globalToLocal(
                                              details.globalPosition) +
                                          const Offset(0, -200);
                                    },
                                    onPanUpdate: (details) {
                                      // print(details.globalPosition);
                                      var previousOffset = _currentDragOffset;
                                      _currentDragOffset += details.delta;
                                      var angle = currentAngle +
                                          toAngle(_currentDragOffset, center) -
                                          toAngle(previousOffset, center);
                                      currentAngle = normalizeAngle(angle);
                                      oldValue =
                                          (currentAngle / (math.pi * 2)) * 100;

                                      var oldRange = (100 - 0);
                                      var newRange = (120 - 0);
                                      var newValue =
                                          (((oldValue - 0) * newRange) /
                                                  oldRange) +
                                              0;

                                      value = 5.0 * ((newValue / 5.0).ceil());

                                      setState(() {
                                        timerDuration = Duration(
                                            minutes: value.ceil().toInt());
                                        // paddleAngle = (currentAngle / (math.pi * 2)) * 100;
                                        paddleAngle =
                                            (currentAngle * math.pi / 3 - 0.2) +
                                                3.1;
                                        if (currentAngle >=
                                                0.0006651366295775674 &&
                                            3.3 >= currentAngle) {
                                          paddleAngle =
                                              (currentAngle * math.pi / 3 -
                                                      0.2) +
                                                  3.3;
                                        }
                                        // print(currentAngle);
                                      });
                                    },
                                    child: Opacity(
                                      opacity: opacityLevel,
                                      child: const _Knob(),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: 170,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Opacity(
                                        opacity: opacityLevel,
                                        child: const Image(
                                          image:
                                              AssetImage("assets/center.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 400,
                                  child: AbsorbPointer(
                                    absorbing: isAbsorb,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Duration timerDuration =
                                        //     Duration(minutes: value.ceil().toInt());
                                        // print(timerDuration.inMinutes);

                                        setState(() {
                                          opacityLevel = 0;
                                        });

                                        isStopped = false;
                                        isAbsorb = true;

                                        trigger?.fire();

                                        timer = Timer.periodic(
                                            const Duration(seconds: 1),
                                            (timer) {
                                          if (mounted) {
                                            setState(() {
                                              seconds =
                                                  timerDuration.inSeconds - 1;
                                              if (seconds < 0) {
                                                timer.cancel();

                                                isFinished = 1;
                                              } else if (isStopped) {
                                                timer.cancel();
                                              } else {
                                                timerDuration =
                                                    Duration(seconds: seconds);
                                              }

                                              if (timerDuration.inSeconds ==
                                                  8) {
                                                stateMachineController!
                                                    .isActive = false;
                                              }
                                              if (timerDuration.inSeconds ==
                                                  6) {
                                                _controller.isActive = true;
                                              }
                                            });
                                          }
                                        });
                                      },
                                      child: Opacity(
                                        opacity: opacityLevel,
                                        child: const Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/cast-button.png"),
                                            ),
                                            Text(
                                              "Cast!",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 450,
                                  child: AbsorbPointer(
                                    absorbing: !isAbsorb,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (value == 0) {
                                            timerDuration =
                                                const Duration(minutes: 5);
                                          } else {
                                            timerDuration = Duration(
                                                minutes:
                                                    (value).ceil().toInt());
                                          }

                                          opacityLevel = 1;
                                          isStopped = true;

                                          isAbsorb = false;

                                          stateMachineController!.isActive =
                                              false;
                                          // stateMachineController!.

                                          // trigger!.fire();
                                        });
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      },
                                      child: Opacity(
                                        opacity: (opacityLevel == 0 ? 1 : 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: const Color(0xffFF1F1F),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: Text(
                                              "Give Up",
                                              style: TextStyle(
                                                color: Color(0xffFF1F1F),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      timerDuration -=
                                          const Duration(seconds: 15);
                                    },
                                    child: const Text("Cut"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 160,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // int isChecked = 0;
                                    setState(() {
                                      if (isChecked[0] == 0) {
                                        isChecked[0] = 1;
                                      } else {
                                        isChecked[0] = 0;
                                      }
                                    });
                                  },
                                  child: Image(
                                    image: AssetImage(
                                        "assets/${checkImage[isChecked[0]]}-bubble.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Opacity(
                                    opacity: (isChecked[0] == 0 ? 1 : 0.7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Software Engineer Project",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 16,
                                            decoration: (isChecked[0] == 0
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough),
                                            decorationThickness: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 90,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffFF1F1F),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: const Text("Important",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "January 1st",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // int isChecked = 0;
                                    setState(() {
                                      if (isChecked[1] == 0) {
                                        isChecked[1] = 1;
                                      } else {
                                        isChecked[1] = 0;
                                      }
                                    });
                                  },
                                  child: Image(
                                    image: AssetImage(
                                        "assets/${checkImage[isChecked[1]]}-bubble.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Opacity(
                                    opacity: (isChecked[1] == 0 ? 1 : 0.7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Character Building Mini Article",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 16,
                                            decoration: (isChecked[1] == 0
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough),
                                            decorationThickness: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 90,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffFF1F1F),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: const Text("Important",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "January 1st",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          color: blueColor.withOpacity(0.0),
                        ),
                        Container(
                          width: 160,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _offsetAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      _offsetAnimation.value.dx *
                                          37, // Adjust the width of the red bar
                                      0,
                                    ),
                                    child: child,
                                  );
                                },
                                child: Container(
                                  width: 80,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: orangeColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);

                                      _panelController.close();

                                      setState(() {
                                        _alignmentController.animateTo(-1.0);

                                        timerColor = Colors.white;
                                        todoColor =
                                            Colors.black.withOpacity(0.3);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          // color: Colors.redAccent,
                                          ),
                                      child: Text(
                                        "Timer",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: timerColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _pageController.animateTo(
                                        MediaQuery.of(context).size.width,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );

                                      _panelController.close();

                                      setState(() {
                                        _alignmentController.animateTo(1.0);
                                        timerColor =
                                            Colors.black.withOpacity(0.3);
                                        todoColor = Colors.white;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          // color: Colors.redAccent,
                                          ),
                                      child: Text(
                                        "To-do",
                                        style: TextStyle(
                                          // backgroundColor: Colors.redAccent,
                                          fontSize: 14,
                                          color: todoColor,
                                        ),
                                      ),
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
                  Positioned(
                    right: 25,
                    bottom: 70,
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(0),
                        ),
                        onPressed: () {},
                        child: const Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/add-task-bubble.png'),
                              fit: BoxFit.fill,
                            ),
                            Icon(Icons.add, size: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: opacityLevel,
                    child: SlidingUpPanel(
                      controller: _panelController,
                      maxHeight: 310,
                      minHeight: 55,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      panel: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 7,
                              width: 55,
                              decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const AquariumPage(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    MdiIcons.fishbowlOutline,
                                    color: const Color(0xff117CFB),
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  const Text(
                                    "Fish Collections",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const AquariumPage(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.query_stats_outlined,
                                    color: Color(0xffFD872D),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Statistics",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const AquariumPage(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: Color(0xff3DC45D),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "About Us",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    MdiIcons.cogOutline,
                                    color: const Color(0xff5856D5),
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  const Text(
                                    "Settings",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: Color(0xffFE2E00),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xffFE2E00)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (isFinished == 0 ? false : true),
                    child: Positioned.fill(
                      top: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.4,
                              child: Expanded(
                                child: Container(
                                  height: screenHeight,
                                  width: screenWidth,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/fish-caught.svg',
                              width: screenWidth * 0.95,
                            ),
                            Positioned(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/fish-tank.svg',
                                    width: screenWidth * 0.3,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "*Insert Fish Name Here*",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 200,
                                    width: screenWidth * 0.65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: const Color(
                                        0xff308BCC,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(23.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "You finished your focus time!",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${value.ceil().toInt()}",
                                                style: const TextStyle(
                                                  color: Color(0xffFE2E00),
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                " Minutes",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 25),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const HomePage(),
                                                    ),
                                                  );
                                                });
                                              },
                                              child:
                                                  MainButton(label: "Confirm")),
                                        ],
                                      ),
                                    ),
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
            ),
          ),
          Positioned(
            bottom: 0,
            child: Visibility(
              visible: isVisibleAddEdit,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: [
                      BubbleButton(
                        color: blueColor,
                        textColor: orangeColor.withOpacity(0.75),
                        label: 'Input new task here...',
                        length: MediaQuery.of(context).size.width - 40,
                        controller: _taskController,
                        type: 'TextField',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          OverlayPortal(
                            controller: _categoryController,
                            overlayChildBuilder: (BuildContext context) {
                              return Positioned(
                                left: 15,
                                bottom: 115,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff70C3FE),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  height: 240,
                                  width: 175,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 22,
                                    ),
                                    itemCount: categories.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                      color: Color(0xff808080),
                                      thickness: 2,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                                            color:
                                                orangeColor.withOpacity(0.75),
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _categoryController.toggle();
                              },
                              child: BubbleButton(
                                color: blueColor,
                                textColor: orangeColor.withOpacity(0.75),
                                label: 'No Category',
                                length: MediaQuery.of(context).size.width / 2.8,
                                type: "Button",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          BubbleButton(
                            icon: Icons.date_range_outlined,
                            color: blueColor,
                            textColor: orangeColor.withOpacity(0.75),
                            label: '27/05/2024',
                            length: MediaQuery.of(context).size.width / 2.4,
                            type: "Button",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('clicked');
                            },
                            child: Image(
                                image: AssetImage('assets/submit-button.png')),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 130,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        // border: Border.all(color: Colors.white, width: 3),
      ),
    );
  }
}
