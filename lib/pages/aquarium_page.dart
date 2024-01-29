import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AquariumPage extends StatefulWidget {
  const AquariumPage({super.key});

  @override
  State<AquariumPage> createState() => _AquariumPageState();
}

class _AquariumPageState extends State<AquariumPage> {
  late RiveAnimationController _controller;

  // Artboard? _riveArtboard;
  // StateMachineController? _controller;
  // SMIInput<bool>? _hoverInput;
  // SMI

  // void play() => setState(() {
  //   _controller.isActive = !_controller.isActive
  // });

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Timeline 2', autoplay: false);

    // rootBundle.load("assets/fish.riv").then(
    //   (data) async {
    //     final file = RiveFile.import(data);

    //     final artboard = file.mainArtboard;
    //     var controller = StateMachineController.fromArtboard(artboard, "State Machine 1");

    //     setState(() {
    //       _
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          const RiveAnimation.asset(
            'assets/test-vid.riv',
            animations: ['Timeline 1', 'Timeline 2'],
            fit: BoxFit.cover,
          ),
          RiveAnimation.asset(
            'assets/fish.riv',
            // animations: const ['Timeline 1'],
            fit: BoxFit.cover,
            controllers: [_controller],
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  print("hola");
                  _controller.isActive = true;
                },
                child: const Text("Give up")),
          )
        ]),
      ),
    );
  }
}
