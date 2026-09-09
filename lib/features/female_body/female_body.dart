import 'package:flutter/material.dart';
import 'package:visualyou/features/body/body.dart';

const _femaleMuscleLayers = <MuscleLayerConfig>[
  // Shoulder stays beneath head, abs, chest, arms, and bikini.
  MuscleLayerConfig(
    group: MuscleGroup.shoulders,
    assetPath: 'assets/images/body/female shoulder.png',
    semanticLabel: 'Female shoulder and back muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // Front-visible back/neck muscles sit above shoulders and below the head.
  MuscleLayerConfig(
    group: MuscleGroup.back,
    assetPath: 'assets/images/body/femaleback.png',
    semanticLabel: 'Female front-visible back and neck muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),

  // Female head placement. It uses the same canvas as the other muscle layers,
  // so keep these values identical to preserve their original alignment.
  MuscleLayerConfig(
    assetPath: 'assets/images/body/female head.png',
    semanticLabel: 'Female head',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
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
    assetPath: 'assets/images/body/femaleunderwearg2.png',
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

const _femaleBackMuscleLayers = <MuscleLayerConfig>[
  // Head is beneath the back/neck layer, matching the male back stack.
  MuscleLayerConfig(
    assetPath: 'assets/images/body/fbhead.png',
    semanticLabel: 'Back of female head',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.back,
    assetPath: 'assets/images/body/fback.png',
    semanticLabel: 'Female back muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.shoulders,
    assetPath: 'assets/images/body/fbshoulder.png',
    semanticLabel: 'Female back shoulder muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.legs,
    assetPath: 'assets/images/body/fblegs.png',
    semanticLabel: 'Female back leg muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    group: MuscleGroup.arms,
    assetPath: 'assets/images/body/fbarms.png',
    semanticLabel: 'Female back arm muscles',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    assetPath: 'assets/images/body/fbunderwear.png',
    semanticLabel: 'Female back underwear',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
  MuscleLayerConfig(
    assetPath: 'assets/images/body/fbbra.png',
    semanticLabel: 'Female back bra',
    top: 0,
    left: 0,
    right: 0,
    width: 300,
    height: 540,
    imageFit: BoxFit.contain,
  ),
];

class FemaleBodyFrame extends StatelessWidget {
  const FemaleBodyFrame({
    this.backViewLocked = false,
    this.onUpgradeBack,
    super.key,
  });

  final bool backViewLocked;
  final VoidCallback? onUpgradeBack;

  @override
  Widget build(BuildContext context) {
    return BodyFrame(
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
      backMuscleLayers: _femaleBackMuscleLayers,
      backViewLocked: backViewLocked,
      onUpgradeBack: onUpgradeBack,
    );
  }
}
