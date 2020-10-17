import 'package:spanngurt/constants.dart';
import 'package:spanngurt/norms/calculation_result.dart';
import 'dart:math';

import 'package:spanngurt/util.dart';

class Vdi_2700_2_2014_DownwardsArgs {
  double loadingWeight;
  double coefficientOfFriction;
  double verticalAngle;
  double accelerationFactorX;
  double kFactor;
  double tensionForce;

  Vdi_2700_2_2014_DownwardsArgs(
      this.loadingWeight,
      this.coefficientOfFriction,
      this.verticalAngle,
      this.accelerationFactorX,
      this.kFactor,
      this.tensionForce);
}

CalculationResult calculate(Vdi_2700_2_2014_DownwardsArgs args) {
  final double gravityForce = args.loadingWeight * gravityAcceleration;
  final double frictionInfluence =
      args.coefficientOfFriction * accelerationFactorZ;
  final double verticalAngleRadians = degreesToRadians(args.verticalAngle);
  final double frictionAngleFactor =
      args.coefficientOfFriction * sin(verticalAngleRadians);

  final numLashings = (gravityForce *
          (args.accelerationFactorX - frictionInfluence) /
          (args.kFactor * args.tensionForce * frictionAngleFactor))
      .ceil();

  return CalculationResult(numLashings, args.tensionForce);
}
