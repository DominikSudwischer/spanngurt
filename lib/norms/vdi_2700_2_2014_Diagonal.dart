import 'package:spanngurt/constants.dart';
import 'package:spanngurt/norms/calculation_result.dart';
import 'dart:math';

import 'package:spanngurt/util.dart';

class Vdi_2700_2_2014_DiagonalArgs {
  double loadingWeight;
  double coefficientOfFriction;
  double verticalAngle;
  double longitudinalLashAngle;
  double accelerationFactorX;
  double accelerationFactorY;

  Vdi_2700_2_2014_DiagonalArgs(
      this.loadingWeight,
      this.coefficientOfFriction,
      this.verticalAngle,
      this.longitudinalLashAngle,
      this.accelerationFactorX,
      this.accelerationFactorY);
}

CalculationResult calculate(Vdi_2700_2_2014_DiagonalArgs args) {
  final double gravityForce = args.loadingWeight * gravityAcceleration;
  final double frictionInfluence =
      args.coefficientOfFriction * accelerationFactorZ;
  final double verticalAngleRadians = degreesToRadians(args.verticalAngle);
  final double cosVerticalAngleRadians = cos(verticalAngleRadians);
  final double longitudinalLashAngleRadians =
      degreesToRadians(args.longitudinalLashAngle);
  final double frictionAngleFactor =
      args.coefficientOfFriction * sin(verticalAngleRadians);

  final double forceAlongDrivingDirection = gravityForce *
      (args.accelerationFactorX - frictionInfluence) /
      (2 *
          (cosVerticalAngleRadians * cos(longitudinalLashAngleRadians) +
              frictionAngleFactor));

  final double forceTransverseDrivingDirection = gravityForce *
      (args.accelerationFactorY - frictionInfluence) /
      (2 *
          (cosVerticalAngleRadians * sin(longitudinalLashAngleRadians) +
              frictionAngleFactor));

  final double lashingCapacity =
      max(forceAlongDrivingDirection, forceTransverseDrivingDirection);

  return CalculationResult(requiredTensionFlangesDiagonal, lashingCapacity);
}
