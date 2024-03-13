import 'dart:math' as math;

import 'package:flutter/material.dart';

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
bool isDarkTheme = false;
bool isConfirmGiveup = true;

const Color blueColor = Color(0xff00B4ED);
const Color lightBlueButtonColor = Color(0xff3DBDD9);
const Color lightBlueButtonBorderColor = Color(0xff37A1E5);
const Color darkBlueColor = Color(0xff021337);
const Color orangeColor = Color(0xffFE4600);
