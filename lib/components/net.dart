import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

import '../my_game.dart';
import 'mosquito.dart';

class Net extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  Net() : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('net.png');

    position += game.player.size / 2;

    add(CircleHitbox());

    final ScaleEffect pulsatingEffect = ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(
        duration: 0.6,
        alternate: true,
        infinite: true,
        curve: Curves.easeInOut,
      ),
    );
    add(pulsatingEffect);

    final OpacityEffect fadeOutEffect = OpacityEffect.fadeOut(
      EffectController(
        duration: 2.0,
        startDelay: 3.0,
      ),
      onComplete: () {
        removeFromParent();
        game.player.activeNet = null;
      },
    );
    add(fadeOutEffect);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Mosquito) {
      other.takeDamage();
    }
  }
}
