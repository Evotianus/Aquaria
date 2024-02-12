import 'dart:async';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:aquaria/features/utils.dart';
import 'package:aquaria/classes/task.dart';
import 'package:aquaria/functions/functions.dart';
import 'package:aquaria/pages/about_us_page.dart';
import 'package:aquaria/pages/aquarium_page.dart';
import 'package:aquaria/pages/fish_collection_page.dart';
import 'package:aquaria/pages/login_page.dart';
import 'package:aquaria/pages/settings_page.dart';
import 'package:aquaria/widgets/bubble_button.dart';
import 'package:aquaria/widgets/main_button.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rive/rive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

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

  Task? currentTask;

  final _pageController = PageController();
  final _pageDateTimeController = PageController();

  late final AnimationController _alignmentController;
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _alignmentControllerDateTime;
  late final Animation<Offset> _offsetAnimationDateTime;

  Color timerColor = Colors.white;
  Color todoColor = Colors.black.withOpacity(0.3);
  Color dateColor = Colors.white;
  Color timeColor = Colors.black.withOpacity(0.3);

  List<String> checkImage = ["unchecked", "checked"];

  final PanelController _panelController = PanelController();
  final TextEditingController _titleTaskController = TextEditingController();
  final OverlayPortalController _categoryController = OverlayPortalController();
  final OverlayPortalController _dateController = OverlayPortalController();
  final OverlayPortalController _timeController = OverlayPortalController();

  Duration timerDuration = const Duration(minutes: 5);
  int minutes = 0;
  int seconds = 0;
  bool isStopped = false;

  double opacityLevel = 1;
  double isFinished = 0;

  bool isAbsorb = false;

  final Color blueColor = const Color(0xff00B4ED);
  final Color orangeColor = const Color(0xffFE4600);
  int deadlineCount = -1;
  int deadlineCount2 = -1;

  Artboard? _fishingArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

  late RiveAnimationController _controller;
  int? durationTime = 5;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedTime = DateTime.now();
  late String taskName;
  String categoryTask = 'No Category';
  DateTime taskDateTime = DateTime.now();
  bool isNoDate = true;
  bool isNoTime = true;

  bool _isFocusAddEditTask = false;
  bool isVisibleAddEdit = false;
  bool isEditTask = false;
  bool isTodo = false;

  var deadlineColor = List<List>.generate(5, (i) => [Colors.white.withOpacity(0.3), const Color(0xffFE4600).withOpacity(0.75), null], growable: true);
  var deadlineColor2 =
      List<List>.generate(5, (i) => [Colors.white.withOpacity(0.3), const Color(0xffFE4600).withOpacity(0.75), null], growable: true);
  late Future<List<Task>?> _futureTask;

  @override
  void initState() {
    super.initState();

    _futureTask = showAllTask();

    _alignmentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(_alignmentController);

    _alignmentControllerDateTime = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimationDateTime = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(_alignmentControllerDateTime);

    rootBundle.load('assets/test-vid.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController = StateMachineController.fromArtboard(artboard, "State Machine 2");
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

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  triggerNotification(id, title, body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  void _checkDeadlineButton(int deadlineCount) {
    setState(() {
      if (this.deadlineCount != -1) {
        deadlineColor[this.deadlineCount][0] = Colors.white.withOpacity(0.3);
        deadlineColor[this.deadlineCount][1] = const Color(0xffFE4600).withOpacity(0.75);
        deadlineColor[this.deadlineCount][2] = null;
      }

      // print(this.deadlineCount);
      // print(this.deadlineCount);
      this.deadlineCount = deadlineCount;

      deadlineColor[this.deadlineCount][0] = const Color(0xffFF7E4C);
      deadlineColor[this.deadlineCount][1] = Colors.white;
      deadlineColor[this.deadlineCount][2] = const Color(0xffFE4600);

      // print(deadlineColor);
    });
  }

  void _checkDeadlineButton2(int deadlineCount) {
    setState(() {
      if (this.deadlineCount2 != -1) {
        deadlineColor2[this.deadlineCount2][0] = Colors.white.withOpacity(0.3);
        deadlineColor2[this.deadlineCount2][1] = const Color(0xffFE4600).withOpacity(0.75);
        deadlineColor2[this.deadlineCount2][2] = null;
      }

      // print(this.deadlineCount);
      this.deadlineCount2 = deadlineCount;
      // print(this.deadlineCount);

      deadlineColor2[this.deadlineCount2][0] = const Color(0xffFF7E4C);
      deadlineColor2[this.deadlineCount2][1] = Colors.white;
      deadlineColor2[this.deadlineCount2][2] = const Color(0xffFE4600);

      // print(deadlineColor2);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    Size canvasSize = Size(screenSize.width, screenSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    Offset knobPos = toPolar(center - Offset(strokeWidth, strokeWidth), currentAngle + startAngle, radius);
    Timer? timer;
    int minutes = timerDuration.inMinutes.remainder(125);
    int seconds = timerDuration.inSeconds.remainder(60);

    double screenDimValue = 0.5;
    List<String> categories = <String>['Critical', 'High', 'Medium', 'Low', 'Very Low'];

    return Scaffold(
      backgroundColor: blueColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentNode = FocusScope.of(context);
          if (!currentNode.hasPrimaryFocus) {
            currentNode.unfocus();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isVisibleAddEdit ? 0.5 : 0),
                BlendMode.darken,
              ),
              child: AbsorbPointer(
                absorbing: isVisibleAddEdit ? true : false,
                child: Stack(
                  children: [
                    PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        Stack(
                          children: [
                            _fishingArtboard == null ? const SizedBox() : Rive(artboard: _fishingArtboard!),
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
                                      style: const TextStyle(fontSize: 64, color: Colors.white),
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
                                        RenderBox getBox = context.findRenderObject() as RenderBox;
                                        _currentDragOffset = getBox.globalToLocal(details.globalPosition) + const Offset(0, -200);
                                      },
                                      onPanUpdate: (details) {
                                        // print(details.globalPosition);
                                        var previousOffset = _currentDragOffset;
                                        _currentDragOffset += details.delta;
                                        var angle = currentAngle + toAngle(_currentDragOffset, center) - toAngle(previousOffset, center);
                                        currentAngle = normalizeAngle(angle);
                                        oldValue = (currentAngle / (math.pi * 2)) * 100;

                                        var oldRange = (100 - 0);
                                        var newRange = (120 - 0);
                                        var newValue = (((oldValue - 0) * newRange) / oldRange) + 0;

                                        value = 5.0 * ((newValue / 5.0).ceil());

                                        setState(() {
                                          timerDuration = Duration(minutes: value.ceil().toInt());
                                          // paddleAngle = (currentAngle / (math.pi * 2)) * 100;
                                          paddleAngle = (currentAngle * math.pi / 3 - 0.2) + 3.1;
                                          if (currentAngle >= 0.0006651366295775674 && 3.3 >= currentAngle) {
                                            paddleAngle = (currentAngle * math.pi / 3 - 0.2) + 3.3;
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
                                          print(timerDuration.inMinutes);

                                          durationTime = timerDuration.inMinutes;
                                          if (durationTime == 0) {
                                            durationTime = 5;
                                          }

                                          setState(() {
                                            opacityLevel = 0;
                                          });

                                          isStopped = false;
                                          isAbsorb = true;

                                          trigger?.fire();

                                          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                                            if (mounted) {
                                              // print(value.toInt().ceil());
                                              setState(() {
                                                seconds = timerDuration.inSeconds - 1;
                                                if (seconds < 0) {
                                                  timer.cancel();

                                                  isFinished = 1;

                                                  triggerNotification(1, 'Strike!', 'Your timer has ended, you caught a fish!');

                                                  print("test: ${value.toInt().ceil() == 0 ? 5 : value.toInt().ceil()}");

                                                  int totalMinutes = value.toInt().ceil() == 0 ? 5 : value.toInt().ceil();

                                                  timerFinished(totalMinutes);
                                                } else {
                                                  timerDuration = Duration(seconds: seconds);
                                                }

                                                if (timerDuration.inSeconds == 8) {
                                                  stateMachineController!.isActive = false;
                                                }
                                                if (timerDuration.inSeconds == 6) {
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
                                                image: AssetImage("assets/cast-button.png"),
                                              ),
                                              Text(
                                                "Cast!",
                                                style: TextStyle(fontSize: 16, color: Colors.white),
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
                                              timerDuration = Duration(minutes: (value).ceil().toInt());
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
                                              builder: (BuildContext context) => const HomePage(),
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
                                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                        timerDuration -= const Duration(seconds: 15);
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
                          padding: const EdgeInsets.fromLTRB(25, 160, 25, 50),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                // const SizedBox(
                                //   height: 160,
                                // ),
                                FutureBuilder(
                                  future: _futureTask,
                                  builder: (BuildContext context, AsyncSnapshot<List<Task>?> snapshot) {
                                    List<Task>? taskList = snapshot.data;
                                    if (taskList != null) {
                                      return Wrap(
                                        direction: Axis.vertical,
                                        spacing: 10,
                                        children: taskList.map((Task task) {
                                          return Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await checkTask(currentTask);
                                                  setState(() {
                                                    if (task.isFinished! == 0) {
                                                      task.isFinished = 1;
                                                    } else {
                                                      task.isFinished = 0;
                                                    }
                                                  });
                                                },
                                                child: Image(
                                                  image: AssetImage("assets/${checkImage[task.isFinished!]}-bubble.png"),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      taskName = task.title!;
                                                      categoryTask = task.urgency!;
                                                      taskDateTime = task.due!;
                                                      _titleTaskController.text = taskName;
                                                      isVisibleAddEdit = true;
                                                      isEditTask = true;
                                                      currentTask = task;
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  child: Opacity(
                                                    opacity: (task.isFinished! == 0 ? 1 : 0.7),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          task.title!,
                                                          style: TextStyle(
                                                            overflow: TextOverflow.ellipsis,
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            decoration: (task.isFinished! == 0 ? TextDecoration.none : TextDecoration.lineThrough),
                                                            decorationThickness: 2,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
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
                                                              child: Text(task.urgency!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.access_time_outlined,
                                                                  color: Colors.white,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  DateFormat('MMM dd, HH:mm').format(task.due!),
                                                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
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
                                        _offsetAnimation.value.dx * 37, // Adjust the width of the red bar
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

                                        _panelController.close();

                                        setState(() {
                                          _alignmentController.animateTo(-1.0);

                                          timerColor = Colors.white;
                                          todoColor = Colors.black.withOpacity(0.3);
                                          isTodo = false;
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
                                          isTodo = true;
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
                    Visibility(
                      visible: isTodo,
                      child: Positioned(
                        right: 25,
                        bottom: 70,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(0),
                            ),
                            onPressed: () {
                              setState(() {
                                isVisibleAddEdit = true;
                                isNoDate = true;
                                isNoTime = true;

                                // taskName = '';
                              });
                            },
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
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                                      builder: (BuildContext context) => const CollectionPage(),
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
                                      builder: (BuildContext context) => const AquariumPage(),
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
                                      builder: (BuildContext context) => const AboutUsPage(),
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
                                      builder: (BuildContext context) => const SettingsPage(),
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
                                      style: TextStyle(fontSize: 16, color: Color(0xffFE2E00)),
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
                                child: Container(
                                  height: screenHeight,
                                  width: screenWidth,
                                  color: const Color(0xff000000),
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
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/fish-tank.svg',
                                          width: screenWidth * 0.3,
                                        ),
                                        SvgPicture.asset(
                                          'assets/fish/stingray.svg',
                                          width: screenWidth * 0.20,
                                          alignment: Alignment.center,
                                        ),
                                      ],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${value.toInt().ceil() == 0 ? 5 : value.toInt().ceil()}",
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
                                            MainButton(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                                  );
                                                });
                                              },
                                              label: "Confirm",
                                            ),
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
                        Focus(
                          onFocusChange: (focus) {
                            _isFocusAddEditTask = focus;
                            _categoryController.hide();
                          },
                          child: BubbleButton(
                            color: Colors.white.withOpacity(0.3),
                            textColor: orangeColor.withOpacity(0.75),
                            label: 'Input new task here...',
                            length: MediaQuery.of(context).size.width - 40,
                            controller: _titleTaskController,
                            type: 'TextField',
                          ),
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
                                      color: const Color(0xff85E8FE),
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 3),
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
                                      separatorBuilder: (BuildContext context, int index) => const Divider(
                                        color: Color(0xff808080),
                                        thickness: 2,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                categoryTask = categories[index];
                                                _categoryController.hide();
                                                _isFocusAddEditTask = false;

                                                print(categoryTask);
                                              });
                                            },
                                            child: Text(
                                              categories[index],
                                              style: TextStyle(
                                                color: orangeColor.withOpacity(0.75),
                                                fontSize: 16,
                                              ),
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
                                  if (!_isFocusAddEditTask) {
                                    _categoryController.show();
                                    _isFocusAddEditTask = true;
                                  }
                                },
                                child: BubbleButton(
                                  color: Colors.white.withOpacity(0.3),
                                  textColor: orangeColor.withOpacity(0.75),
                                  label: categoryTask,
                                  length: MediaQuery.of(context).size.width / 2.8,
                                  type: "Button",
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            OverlayPortal(
                              controller: _dateController,
                              overlayChildBuilder: (BuildContext context) {
                                return Positioned(
                                  top: 60,
                                  left: 26,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    width: 360,
                                    height: 765,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff85E8FE),
                                      borderRadius: BorderRadiusDirectional.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 360,
                                                    height: 545,
                                                    child: PageView(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      controller: _pageDateTimeController,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            TableCalendar(
                                                              firstDay: DateTime.utc(1930, 1, 1),
                                                              lastDay: DateTime.utc(2119, 12, 31),
                                                              focusedDay: _focusedDay,
                                                              calendarFormat: _calendarFormat,
                                                              selectedDayPredicate: (day) {
                                                                // Use `selectedDayPredicate` to determine which day is currently selected.
                                                                // If this returns true, then `day` will be marked as selected.

                                                                // Using `isSameDay` is recommended to disregard
                                                                // the time-part of compared DateTime objects.
                                                                return isSameDay(_selectedDay, day);
                                                              },
                                                              onDaySelected: (selectedDay, focusedDay) {
                                                                if (!isSameDay(_selectedDay, selectedDay)) {
                                                                  // Call `setState()` when updating the selected day
                                                                  setState(() {
                                                                    isNoDate = false;
                                                                    _selectedDay = selectedDay;
                                                                    _focusedDay = focusedDay;
                                                                  });
                                                                }
                                                              },
                                                              onFormatChanged: (format) {
                                                                if (_calendarFormat != format) {
                                                                  // Call `setState()` when updating calendar format
                                                                  setState(() {
                                                                    _calendarFormat = format;
                                                                  });
                                                                }
                                                              },
                                                              // onPageChanged: (focusedDay) {
                                                              //   // No need to call `setState()` here
                                                              //   _focusedDay = focusedDay;
                                                              // },
                                                              headerStyle: HeaderStyle(
                                                                titleCentered: true,
                                                                formatButtonVisible: false,
                                                                leftChevronIcon: Icon(
                                                                  Icons.arrow_left_outlined,
                                                                  size: 60,
                                                                  color: orangeColor,
                                                                ),
                                                                rightChevronIcon: Icon(
                                                                  Icons.arrow_right_outlined,
                                                                  size: 60,
                                                                  color: orangeColor,
                                                                ),
                                                                titleTextStyle: TextStyle(
                                                                  color: orangeColor,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              calendarStyle: CalendarStyle(
                                                                defaultTextStyle: const TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                                weekendTextStyle: const TextStyle(
                                                                  color: Color(0xffFF1F1F),
                                                                  fontSize: 18,
                                                                ),
                                                                selectedTextStyle: const TextStyle(
                                                                  color: Color(0xffFFFFFF),
                                                                  fontSize: 18,
                                                                ),
                                                                outsideTextStyle: TextStyle(
                                                                  color: Colors.black.withOpacity(0.3),
                                                                  fontSize: 18,
                                                                ),
                                                                isTodayHighlighted: true,
                                                              ),
                                                              weekendDays: const [DateTime.sunday],
                                                              daysOfWeekStyle: const DaysOfWeekStyle(
                                                                weekdayStyle: TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                                weekendStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(0xffFF1F1F),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Wrap(
                                                              alignment: WrapAlignment.center,
                                                              spacing: 3.0,
                                                              runSpacing: 10.0,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton(0);
                                                                    isNoDate = true;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor[0][0],
                                                                    secondaryColor: deadlineColor[0][2],
                                                                    label: 'No Date',
                                                                    length: 110,
                                                                    textColor: deadlineColor[0][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton(1);
                                                                    isNoDate = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor[1][0],
                                                                    secondaryColor: deadlineColor[1][2],
                                                                    label: 'Today',
                                                                    length: 90,
                                                                    textColor: deadlineColor[1][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton(2);
                                                                    isNoDate = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor[2][0],
                                                                    secondaryColor: deadlineColor[2][2],
                                                                    label: 'Tomorrow',
                                                                    length: 120,
                                                                    textColor: deadlineColor[2][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton(3);
                                                                    isNoDate = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor[3][0],
                                                                    secondaryColor: deadlineColor[3][2],
                                                                    label: '3 Days Later',
                                                                    length: 140,
                                                                    textColor: deadlineColor[3][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton(4);
                                                                    isNoDate = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor[4][0],
                                                                    secondaryColor: deadlineColor[4][2],
                                                                    label: 'This Sunday',
                                                                    length: 140,
                                                                    textColor: deadlineColor[4][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 50,
                                                            ),
                                                            TimePickerSpinner(
                                                              time: _focusedTime,
                                                              alignment: Alignment.center,
                                                              itemWidth: 80,
                                                              itemHeight: 110,
                                                              is24HourMode: true,
                                                              isForce2Digits: true,
                                                              normalTextStyle: TextStyle(
                                                                fontSize: 42,
                                                                color: orangeColor.withOpacity(0.5),
                                                              ),
                                                              highlightedTextStyle: TextStyle(
                                                                fontSize: 42,
                                                                color: orangeColor,
                                                              ),
                                                              onTimeChange: (time) {
                                                                _focusedTime = time;
                                                                isNoTime = false;
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            Wrap(
                                                              alignment: WrapAlignment.center,
                                                              spacing: 3.0,
                                                              runSpacing: 10.0,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton2(0);
                                                                    isNoTime = true;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor2[0][0],
                                                                    secondaryColor: deadlineColor2[0][2],
                                                                    label: 'No Time',
                                                                    length: 110,
                                                                    textColor: deadlineColor2[0][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton2(1);
                                                                    isNoTime = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor2[1][0],
                                                                    secondaryColor: deadlineColor2[1][2],
                                                                    label: '00:00',
                                                                    length: 90,
                                                                    textColor: deadlineColor2[1][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton2(2);
                                                                    isNoTime = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor2[2][0],
                                                                    secondaryColor: deadlineColor2[2][2],
                                                                    label: '06:00',
                                                                    length: 90,
                                                                    textColor: deadlineColor2[2][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton2(3);
                                                                    isNoTime = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor2[3][0],
                                                                    secondaryColor: deadlineColor2[3][2],
                                                                    label: '12:00',
                                                                    length: 90,
                                                                    textColor: deadlineColor2[3][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _checkDeadlineButton2(4);
                                                                    isNoTime = false;
                                                                  },
                                                                  child: BubbleButton(
                                                                    color: deadlineColor2[4][0],
                                                                    secondaryColor: deadlineColor2[4][2],
                                                                    label: '18:00',
                                                                    length: 90,
                                                                    textColor: deadlineColor2[4][1],
                                                                    padding: const EdgeInsets.fromLTRB(22, 8, 10, 8),
                                                                    type: 'Button',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 10.0,
                                                              vertical: 20.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons.notifications_outlined,
                                                                      color: orangeColor,
                                                                      size: 30,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      'Reminder',
                                                                      style: TextStyle(
                                                                        color: orangeColor.withOpacity(0.75),
                                                                        fontSize: 16,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                    color: orangeColor.withOpacity(0.75),
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                _dateController.hide();
                                                                _isFocusAddEditTask = false;
                                                                _alignmentControllerDateTime.animateTo(-1.0);
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: const Color(0xff2F86C5).withOpacity(0.5),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 25,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _dateController.hide();
                                                                _isFocusAddEditTask = false;
                                                                _alignmentControllerDateTime.animateTo(-1.0);

                                                                String? tempParsedDate;
                                                                String? tempParsedTime;

                                                                setState(() {
                                                                  if (!isNoDate) {
                                                                    tempParsedDate = DateFormat('yyyy-MM-dd').format(_focusedDay);
                                                                  }
                                                                  if (!isNoTime) {
                                                                    tempParsedTime = DateFormat('HH:mm:ss').format(_focusedTime);
                                                                  }

                                                                  if (!isNoDate && !isNoTime) {
                                                                    taskDateTime = DateTime.parse('$tempParsedDate $tempParsedTime');
                                                                  } else if (isNoTime) {
                                                                    taskDateTime = DateTime.parse(tempParsedDate!);
                                                                  }
                                                                });
                                                                print(taskDateTime);
                                                              },
                                                              child: BubbleButton(
                                                                color: const Color(0xffFF7E4C),
                                                                secondaryColor: orangeColor,
                                                                label: 'Done',
                                                                length: 90,
                                                                textColor: Colors.white,
                                                                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                                              ),
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
                                        Positioned.fill(
                                          top: 35,
                                          child: Column(
                                            children: [
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
                                                      animation: _offsetAnimationDateTime,
                                                      builder: (context, child) {
                                                        return Transform.translate(
                                                          offset: Offset(
                                                            _offsetAnimationDateTime.value.dx * 37, // Adjust the width of the red bar
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
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            _pageDateTimeController.previousPage(
                                                                duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

                                                            setState(() {
                                                              _alignmentControllerDateTime.animateTo(-1.0);

                                                              dateColor = Colors.white;
                                                              timeColor = Colors.black.withOpacity(0.3);
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.all(8.0),
                                                            decoration: const BoxDecoration(
                                                                // color: Colors.redAccent,
                                                                ),
                                                            child: Text(
                                                              "Date",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: dateColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _pageDateTimeController.animateTo(
                                                              MediaQuery.of(context).size.width,
                                                              duration: const Duration(milliseconds: 300),
                                                              curve: Curves.easeIn,
                                                            );

                                                            setState(() {
                                                              _alignmentControllerDateTime.animateTo(1.0);
                                                              dateColor = Colors.black.withOpacity(0.3);
                                                              timeColor = Colors.white;
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.all(8.0),
                                                            decoration: const BoxDecoration(
                                                                // color: Colors.redAccent,
                                                                ),
                                                            child: Text(
                                                              "Time",
                                                              style: TextStyle(
                                                                // backgroundColor: Colors.redAccent,
                                                                fontSize: 14,
                                                                color: timeColor,
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
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  if (!_isFocusAddEditTask) {
                                    _dateController.show();
                                    _isFocusAddEditTask = true;

                                    _alignmentControllerDateTime.animateTo(-1.0);
                                    dateColor = Colors.white;
                                    timeColor = Colors.black.withOpacity(0.3);
                                  }
                                },
                                child: BubbleButton(
                                  color: Colors.white.withOpacity(0.3),
                                  textColor: orangeColor.withOpacity(0.75),
                                  label: isNoDate ? 'No Date' : DateFormat('MMM dd, HH:mm').format(taskDateTime),
                                  length: MediaQuery.of(context).size.width / 2.4,
                                  type: "Button",
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () async {
                                taskName = _titleTaskController.text;
                                if (isEditTask) {
                                  final response = await updateTask(currentTask, taskName, categoryTask, taskDateTime);

                                  if (response > 0) {
                                    setState(() {
                                      _futureTask = showAllTask();
                                      isVisibleAddEdit = false;
                                      // isEditTask = false;
                                    });
                                  }
                                } else {
                                  final response = await addTask(taskName, categoryTask, taskDateTime);
                                  if (response == 200) {
                                    setState(() {
                                      _futureTask = showAllTask();
                                      isVisibleAddEdit = false;
                                      // isEditTask = false;
                                    });
                                  }

                                  // _titleTaskController.text = '';
                                }
                              },
                              child: const Image(image: AssetImage('assets/submit-button.png')),
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
