import 'package:flutter/material.dart';
import 'package:aquaria/classes/task.dart';
import 'dart:math' as math;

const fullAngleInRadians = math.pi * 2;

double normalize(double value, double max) => (value % max + max) % max;

double normalizeAngle(double angle) => normalize(angle, fullAngleInRadians);

Offset toPolar(Offset center, double radians, double radius) => center + Offset.fromDirection(radians, radius);

double toAngle(Offset position, Offset center) => (position - center).direction;

double toRadian(double value) => (value * math.pi) / 180;

Color timerColor = Colors.white;
Color todoColor = Colors.black.withOpacity(0.3);
Color dateColor = Colors.white;
Color timeColor = Colors.black.withOpacity(0.3);

final Color blueColor = const Color(0xff00B4ED);
final Color orangeColor = const Color(0xffFE4600);

bool isConfirmDelete = true;
bool isEnableNotification = false;
bool isAnimationSound = false;
bool isCompletionSound = false;
bool isDarkTheme = false;