import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components.dart';
import 'ranking.dart';
import 'ready.dart';
import 'rules.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 265,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color: ColorLibrary.themePrimary,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Addition',
                              style: TextStyle(fontSize: 34),
                            ),
                            TextSpan(
                              text: ' 23',
                              style: TextStyle(fontSize: 46),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const ButtonPrimary(
                    text: "プレイを開始",
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
                        icon: Icons.question_mark_rounded,
                        text: '遊び方',
                        nextPage: Rules(),
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
                  const SizedBox(height: 25),
                  TextButton.icon(
                    icon: Icon(Icons.privacy_tip_rounded),
                    onPressed: () async {
                      final Uri uri = Uri.parse('https://flame-hell-936.notion.site/Addition-23-212cc6fce0b380ea9966f89da615b514?source=copy_link');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('ページを開くことができませんでした')),
                        );
                      }
                    },
                    label: Text(
                      'プライバシーポリシー',
                      style: TextStyle(color: ColorLibrary.themePrimary),
                    ),
                    style: TextButton.styleFrom(
                      overlayColor: ColorLibrary.themePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
