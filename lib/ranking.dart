import 'package:flutter/material.dart';

import 'components.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

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
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
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
                        Icons.emoji_events_rounded,
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
                      'ランキング',
                      style: TextStyle(
                        color: ColorLibrary.themePrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
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
