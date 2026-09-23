import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../my_game.dart';
import 'mosquito.dart';

class Spray extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  Spray({required super.position, super.angle = 0.0})
      : super(anchor: Anchor.center, priority: -1);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('spray.png');

    size *= 0.15;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(sin(angle), -cos(angle)) * 500 * dt;

    // remove the spray from the game if it goes above the top
    if (position.y < -size.y / 2) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Mosquito) {
      removeFromParent();
      other.takeDamage();
    }
  }
}
