import 'package:flutter/material.dart';

import '../my_game.dart';

class TitleOverlay extends StatefulWidget {
  final MyGame game;

  const TitleOverlay({super.key, required this.game});

  @override
  State<TitleOverlay> createState() => _TitleOverlayState();
}

class _TitleOverlayState extends State<TitleOverlay> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        setState(() {
          _opacity = 1.0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String playerColor =
        widget.game.playerColors[widget.game.playerColorIndex];

    return AnimatedOpacity(
      onEnd: () {
        if (_opacity == 0.0) {
          widget.game.overlays.remove('Title');
        }
      },
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              SizedBox(
                width: 270,
                child: Image.asset('assets/images/title.jpeg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'DENGUE DEFENDER',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(-1, -1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Fight Dengue in Bangladesh!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.game.audioManager.playSound('click');
                      setState(() {
                        widget.game.playerColorIndex--;
                        if (widget.game.playerColorIndex < 0) {
                          widget.game.playerColorIndex =
                              widget.game.playerColors.length - 1;
                        }
                      });
                    },
                    child: Transform.flip(
                      flipX: true,
                      child: SizedBox(
                        width: 30,
                        child: Image.asset('assets/images/arrow_button.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: SizedBox(
                      width: 100,
                      child: Image.asset(
                        'assets/images/player_${playerColor}_off.png',
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.game.audioManager.playSound('click');
                      setState(() {
                        widget.game.playerColorIndex++;
                        if (widget.game.playerColorIndex ==
                            widget.game.playerColors.length) {
                          widget.game.playerColorIndex = 0;
                        }
                      });
                    },
                    child: SizedBox(
                      width: 30,
                      child: Image.asset('assets/images/arrow_button.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  widget.game.audioManager.playSound('start');
                  widget.game.startGame();
                  setState(() {
                    _opacity = 0.0;
                  });
                },
                child: SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/start_button.png'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.game.audioManager.toggleMusic();
                      });
                    },
                    icon: Icon(
                      widget.game.audioManager.musicEnabled
                          ? Icons.music_note_rounded
                          : Icons.music_off_rounded,
                      color: widget.game.audioManager.musicEnabled
                          ? Colors.white
                          : Colors.grey,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.game.audioManager.toggleSounds();
                      });
                    },
                    icon: Icon(
                      widget.game.audioManager.soundsEnabled
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      color: widget.game.audioManager.soundsEnabled
                          ? Colors.white
                          : Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '🦟 Help eliminate Aedes mosquitoes\n🏠 Clean standing water around your home\n🛏️ Use mosquito nets while sleeping\n🧴 Apply mosquito repellent regularly',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
