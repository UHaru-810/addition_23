import 'package:flutter/material.dart';

// 配色設定
class ColorLibrary {
  static Color themePrimary = const Color(0xff3388FF);
  static Color themeSecondary = const Color(0xffE1E9F4);
  static Color themeTertiary = const Color(0xffB5C8E3);
  static Color themeQuaternary = const Color(0xffF1F4F8);
  static Color themeQuinary = const Color(0xff1F5AAD);
  static Color greenPrimary = const Color(0xffD4F7E8);
  static Color greenSecondary = const Color(0xff9CE2C6);
  static Color text = const Color(0xff333333);
  static Color gray = const Color(0xff737373);
  static Color white = const Color(0xffFFFFFF);
}

// ボタン (Primary)
class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
      {super.key,
      required this.text,
      required this.nextPage,
      required this.transVertical});

  final String text;
  final Widget nextPage;
  final bool transVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 265,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: ColorLibrary.themePrimary.withValues(alpha: 0.3),
            offset: const Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          if (transVertical == true) {
            Navigator.of(context).push(
              // 画面遷移アニメーション
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return nextPage;
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final Offset begin = Offset(0.0, 1.0); // 下から上
                  // final Offset begin = Offset(0.0, -1.0); // 上から下
                  final Offset end = Offset.zero;
                  final Animatable<Offset> tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: Curves.easeInOut));
                  final Animation<Offset> offsetAnimation =
                      animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 400),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => nextPage)
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ColorLibrary.themePrimary),
          overlayColor: WidgetStateProperty.all(ColorLibrary.themeQuinary),
        ).merge(
          TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            splashFactory: InkSparkle.splashFactory, // エフェクト設定
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              size: 30,
              color: ColorLibrary.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Align(
              alignment: const Alignment(0, -0.2),
              child: Text(
                text,
                style: TextStyle(
                  color: ColorLibrary.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ボタン (Secondary)
class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary(
      {super.key,
      required this.icon,
      required this.text,
      required this.nextPage});

  final String text;
  final IconData icon;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => nextPage)
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(ColorLibrary.white),
              overlayColor:
                  WidgetStateProperty.all(ColorLibrary.themeSecondary),
            ).merge(
              TextButton.styleFrom(
                side: BorderSide(
                  color: ColorLibrary.themeSecondary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                splashFactory: InkRipple.splashFactory,
              ),
            ),
            child: Icon(
              icon,
              size: 28,
              color: ColorLibrary.gray,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: ColorLibrary.gray,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
