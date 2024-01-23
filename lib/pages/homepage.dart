import 'dart:async';
import 'dart:math' as math;

import 'package:aquaria/features/utils.dart';
import 'package:aquaria/pages/aquarium_page.dart';
import 'package:aquaria/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rive/rive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

  // get timerColor => Colors.white;
  // get todoColor => Colors.black.withOpacity(0.3);
  Color timerColor = Colors.white;
  Color todoColor = Colors.black.withOpacity(0.3);

  List<String> checkImage = ["unchecked", "checked"];
  List<int> isChecked = [0, 0];

  final PanelController _panelController = PanelController();

  Duration timerDuration = const Duration(minutes: 5);
  int minutes = 0;
  int seconds = 0;
  bool isStopped = false;

  double opacityLevel = 1;

  bool isAbsorb = false;

  Artboard? _fishingArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

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

    return Scaffold(
      backgroundColor: const Color(0xff00B4ED),
      body: Stack(
        alignment: Alignment.center,
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
                                    image: AssetImage("assets/paddle.png"),
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
                              RenderBox getBox =
                                  context.findRenderObject() as RenderBox;
                              _currentDragOffset =
                                  getBox.globalToLocal(details.globalPosition) +
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
                              oldValue = (currentAngle / (math.pi * 2)) * 100;

                              var oldRange = (100 - 0);
                              var newRange = (120 - 0);
                              var newValue =
                                  (((oldValue - 0) * newRange) / oldRange) + 0;

                              value = 5.0 * ((newValue / 5.0).ceil());

                              setState(() {
                                timerDuration =
                                    Duration(minutes: value.ceil().toInt());
                                // paddleAngle = (currentAngle / (math.pi * 2)) * 100;
                                paddleAngle =
                                    (currentAngle * math.pi / 3 - 0.2) + 3.1;
                                if (currentAngle >= 0.0006651366295775674 &&
                                    3.3 >= currentAngle) {
                                  paddleAngle =
                                      (currentAngle * math.pi / 3 - 0.2) + 3.3;
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
                                  image: AssetImage("assets/center.png"),
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
                                    const Duration(seconds: 1), (timer) {
                                  if (mounted) {
                                    setState(() {
                                      seconds = timerDuration.inSeconds - 1;
                                      if (seconds < 0) {
                                        timer.cancel();
                                      } else if (isStopped) {
                                        timer.cancel();
                                      } else {
                                        timerDuration =
                                            Duration(seconds: seconds);
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
                                      image:
                                          AssetImage("assets/cast-button.png"),
                                    ),
                                    Text(
                                      "Cast!",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
                                    timerDuration = const Duration(minutes: 5);
                                  } else {
                                    timerDuration = Duration(
                                        minutes: (value).ceil().toInt());
                                  }

                                  opacityLevel = 1;
                                  isStopped = true;

                                  isAbsorb = false;

                                  stateMachineController!.isActive = false;
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
                                    borderRadius: const BorderRadius.all(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
            top: 100,
            child: Container(
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
                      decoration: const BoxDecoration(
                        color: Color(0xffFE4600),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);

                          _panelController.close();

                          setState(() {
                            _alignmentController.animateTo(-1.0);

                            timerColor = Colors.white;
                            todoColor = Colors.black.withOpacity(0.3);
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
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );

                          _panelController.close();

                          setState(() {
                            _alignmentController.animateTo(1.0);
                            timerColor = Colors.black.withOpacity(0.3);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 7,
                      width: 55,
                      decoration: const BoxDecoration(
                        color: Color(0xff00B4ED),
                        borderRadius: BorderRadius.all(
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
                            Icons.folder_shared_outlined,
                            color: Color(0xffFD872D),
                            size: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Your Files",
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
                                const AquariumPage(),
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
                            builder: (BuildContext context) => LoginPage(),
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
          )
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
