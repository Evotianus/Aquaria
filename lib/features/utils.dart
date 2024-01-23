import 'package:flutter/material.dart';
import 'dart:math' as math;

const fullAngleInRadians = math.pi * 2;

double normalize(double value, double max) => (value % max + max) % max;

double normalizeAngle(double angle) => normalize(angle, fullAngleInRadians);

Offset toPolar(Offset center, double radians, double radius) =>
    center + Offset.fromDirection(radians, radius);

double toAngle(Offset position, Offset center) => (position - center).direction;

double toRadian(double value) => (value * math.pi) / 180;
