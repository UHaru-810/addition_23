import 'package:flutter/material.dart';

import 'components.dart';
import 'ready.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle headTextStyle = TextStyle(
      color: ColorLibrary.themePrimary,
      fontWeight: FontWeight.w600,
      fontSize: 17,
      height: 2,
    );

    TextStyle captionTextStyle = TextStyle(
      color: ColorLibrary.text,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 2,
    );
    // テキストスタイルを定義

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLibrary.white,
        elevation: 0,
        title: Text(
          'Addition 23',
          style: TextStyle(
            color: ColorLibrary.themePrimary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: 0,
            backgroundColor: ColorLibrary.themeSecondary,
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorLibrary.themeTertiary),
          ), // スクロールバー
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorLibrary.gray,
            size: 22,
          ),
          splashColor: ColorLibrary.themeSecondary,
          highlightColor: ColorLibrary.themeSecondary,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 285,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorLibrary.themePrimary,
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 25,
                        color: ColorLibrary.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    height: 55,
                    alignment: const Alignment(0, -0.5),
                    child: Text(
                      '遊び方',
                      style: TextStyle(
                        color: ColorLibrary.themePrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "❶ プレイを開始する",
                style: headTextStyle,
              ),
              Text(
                "名前を入力してスタートします。\n※ 名前はランク表に記載(公開)されます。",
                style: captionTextStyle,
              ),
              const SizedBox(height: 25),
              Text(
                "❷ 和を23にする",
                style: headTextStyle,
              ),
              Text(
                "数字の和が 23 になるように、画面に表示されるカードを選択します。",
                style: captionTextStyle,
              ),
              const SizedBox(height: 25),
              Text(
                "❸ 速いタイムを目指す",
                style: headTextStyle,
              ),
              Text(
                "10問を解くのにかかるタイムを競います。",
                style: captionTextStyle,
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonPrimary(
                    text: 'プレイを開始',
                    nextPage: Ready(),
                    transVertical: true,
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
