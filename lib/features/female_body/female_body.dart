import 'package:flutter/material.dart';
import 'package:visualyou/features/body/body.dart';

const _femaleMuscleLayers = <MuscleLayerConfig>[
  // Shoulder stays beneath head, abs, chest, arms, and bikini.
  MuscleLayerConfig(
    group: MuscleGroup.shouldersBack,
    assetPath: 'assets/images/body/female shoulder.png',
    semanticLabel: 'Female shoulder and back muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // The face has a different source canvas, so edit these values separately.
  MuscleLayerConfig(
    assetPath: 'assets/images/body/female face (1).png',
    semanticLabel: 'Female head',
    top: -5,
    left: 40,
    right: 40,
    width: 220,
    height: 150,
    imageFit: BoxFit.contain,
  ),

  // Legs stay beneath underwear.
  MuscleLayerConfig(
    group: MuscleGroup.legs,
    assetPath: 'assets/images/body/female legs.png',
    semanticLabel: 'Female leg muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // Abs stay above shoulder and below chest, arms, and bikini.
  MuscleLayerConfig(
    group: MuscleGroup.abs,
    assetPath: 'assets/images/body/female abs cleaned.png',
    semanticLabel: 'Female abdominal muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.chest,
    assetPath: 'assets/images/body/female chest.png',
    semanticLabel: 'Female chest muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.arms,
    assetPath: 'assets/images/body/female arms.png',
    semanticLabel: 'Female arm muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // Underwear is above abs and legs.
  MuscleLayerConfig(
    assetPath: 'assets/images/body/female underwear(1).png',
    semanticLabel: 'Female underwear',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // Bikini is last, so it appears above chest, shoulder, and abs.
  MuscleLayerConfig(
    assetPath: 'assets/images/body/female bikini.png',
    semanticLabel: 'Female bikini',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
];

class FemaleBodyFrame extends StatelessWidget {
  const FemaleBodyFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyFrame(
      bodyAssetPath: 'assets/images/body/femalebody.png',
      bodySemanticLabel: 'Female body and organs illustration',
      bodyOverlayAssetPath: 'assets/images/body/nose job.png',
      bodyOverlaySemanticLabel: 'Female nose overlay',
      bodyOverlayTop: -110,
      bodyOverlayLeft: -55,
      bodyOverlayRight: 0,
      bodyOverlayWidth: 30,
      bodyOverlayHeight: 300,
      bodyOverlayRotationDegrees: 0,
      showMaleViewControls: true,
      muscleLayers: _femaleMuscleLayers,
    );
  }
}
