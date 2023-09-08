import 'package:flutter/material.dart';

import 'components.dart';
import 'play.dart';

class Ready extends StatelessWidget {
  const Ready({super.key});
  static String name = "";

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(
            Icons.close_rounded,
            color: ColorLibrary.gray,
            size: 25,
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
            children: [
              TextField(
                style: TextStyle(
                  color: ColorLibrary.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorLibrary.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorLibrary.themeSecondary,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorLibrary.themePrimary,
                      width: 2,
                    ),
                  ),
                  label: const Text(' 名前を入力 '),
                  labelStyle: TextStyle(
                    color: ColorLibrary.gray,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  suffix: const Text('さん'),
                  suffixStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: ColorLibrary.gray,
                    height: 0.1,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
                ),
                cursorColor: ColorLibrary.themePrimary,
                onChanged: (text) {
                  name = text;
                },
              ),
              const SizedBox(height: 60),
              Text(
                '用意はいいですか？',
                style: TextStyle(
                  fontSize: 25,
                  color: ColorLibrary.themePrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: ColorLibrary.text,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  children: const [
                    TextSpan(
                      text: '最速記録は、〇〇さんの ',
                    ),
                    TextSpan(
                      text: '23.00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: ' 秒です。',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              ButtonPrimary(
                text: 'スタート！',
                nextPage: Play.first(
                  progress: 1,
                ),
                transVertical: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
