import 'package:flame/components.dart';
import '../my_game.dart';

class Background extends SpriteComponent with HasGameReference<MyGame> {
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('dengue_background.png');
    position = Vector2(0, 0);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }
}
