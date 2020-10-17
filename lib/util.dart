import 'dart:math';

const double degreesToRadiansFactor = 2 * pi / 360;

double degreesToRadians(double degrees) {
  // degrees * 2 * pi / 360
  return degrees * degreesToRadiansFactor;
}
