import 'package:flutter/material.dart';

import 'components.dart';
import 'home.dart';
import 'ranking.dart';
import 'ready.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.milliSeconds,
  });

  final int minutes, seconds, milliSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 265,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 55,
              ),
              Text(
                'お疲れ様でした。',
                style: TextStyle(
                  color: ColorLibrary.themePrimary,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${Ready.name == "" ? 'あなた' : '${Ready.name} さん'}のタイム',
                style: TextStyle(
                    color: ColorLibrary.text,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 2),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliSeconds.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: ColorLibrary.themePrimary,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 53,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '23位の記録です。\n1位まで、あと23.23秒です。',
                style: TextStyle(
                    color: ColorLibrary.text,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    height: 2),
              ),
              const SizedBox(
                height: 50,
              ),
              const ButtonPrimary(
                text: "もう一度プレイ",
                nextPage: Ready(),
                transVertical: true,
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonSecondary(
                    icon: Icons.home_rounded,
                    text: 'ホーム',
                    nextPage: Home(),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ButtonSecondary(
                    icon: Icons.emoji_events_rounded,
                    text: 'ランク',
                    nextPage: Ranking(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Addition23',
                    style: TextStyle(
                      color: ColorLibrary.themePrimary,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
