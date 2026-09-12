
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';
import 'overlays/game_over_overlay.dart';
import 'overlays/title_overlay.dart';

void main() {
  final MyGame game = MyGame();

  runApp(GameWidget(
    game: game,
    overlayBuilderMap: {
      'GameOver': (context, MyGame game) => GameOverOverlay(game: game),
      'Title': (context, MyGame game) => TitleOverlay(game: game),
    },
    initialActiveOverlays: const ['Title'],
  ));
}
