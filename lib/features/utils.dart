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

bool isConfirmDelete = true;
bool isEnableNotification = false;
bool isAnimationSound = false;
bool isCompletionSound = false;
bool isDarkTheme = true;

const Color blueColor = const Color(0xff00B4ED);
const Color lightBlueButtonColor = const Color(0xff3DBDD9);
const Color lightBlueButtonBorderColor = const Color(0xff37A1E5);
const Color darkBlueColor = Color(0xff021337);
const Color orangeColor = const Color(0xffFE4600);
