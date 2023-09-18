import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'components.dart';
import 'num_generator.dart';
import 'result.dart';

class Play extends StatefulWidget {
  const Play({super.key, required this.progress, required this.stopWatchTimer});

  Play.first({
    super.key,
    required this.progress,
  }) : stopWatchTimer = StopWatchTimer(presetMillisecond: 0);

  final int progress;
  final StopWatchTimer? stopWatchTimer;

  @override
  State<Play> createState() => PlayState();
}

class PlayState extends State<Play> {
  List<int> valueOnCards = numGenerator();
  List<Color> backgroundColor =
      List.filled(6, ColorLibrary.white, growable: true);
  List<Color> overlayColor =
      List.filled(6, ColorLibrary.themeSecondary, growable: true);
  List<Color> borderColor =
      List.filled(6, ColorLibrary.themeSecondary, growable: true);

  int sum = 0;
  String displayTimeMinute = "";
  String displayTimeSecond = "";
  String displayTimeMilliSecond = "";
  bool isButtonEnabled = true;

  @override
  void initState() {
    widget.stopWatchTimer!.onStartTimer();
    super.initState();
  }

  @override
  void dispose() {
    widget.stopWatchTimer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double buttonSize = deviceHeight < 700 || deviceWidth > 500
        ? ((deviceHeight * 0.37 - deviceHeight * 0.055) / 2)
        : ((deviceHeight * 0.33 - deviceHeight * 0.059) / 2);

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
            value: 0.1 * (widget.progress - 1).toDouble(),
            backgroundColor: ColorLibrary.themeSecondary,
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorLibrary.themeTertiary),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: ColorLibrary.themeQuaternary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  title: const Text(
                    "本当にやめますか？",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    "ここまでの記録は破棄されます",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    bottom: 7,
                  ),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorLibrary.white),
                        overlayColor: MaterialStateProperty.all(
                            ColorLibrary.themeSecondary),
                      ).merge(
                        TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 25),
                          side: BorderSide(
                            color: ColorLibrary.themeSecondary,
                            width: 1.25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          splashFactory: InkRipple.splashFactory,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "続ける",
                        style: TextStyle(
                          color: ColorLibrary.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            ColorLibrary.themePrimary),
                        overlayColor: MaterialStateProperty.all(
                            ColorLibrary.themeQuinary),
                      ).merge(
                        TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          splashFactory: InkRipple.splashFactory,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: Text(
                        "やめる",
                        style: TextStyle(
                          color: ColorLibrary.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.center,
                  actionsPadding: const EdgeInsets.only(
                    top: 15,
                    bottom: 25,
                  ),
                );
              },
            );
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "足して23を作ろう！",
                style: TextStyle(
                  color: ColorLibrary.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              StreamBuilder<int>(
                stream: widget.stopWatchTimer!.rawTime,
                initialData: widget.stopWatchTimer!.rawTime.value,
                builder: (context, snapshot) {
                  displayTimeMinute = StopWatchTimer.getDisplayTimeMinute(
                    snapshot.data!,
                  );
                  displayTimeSecond = StopWatchTimer.getDisplayTimeSecond(
                    snapshot.data!,
                  );
                  displayTimeMilliSecond =
                      StopWatchTimer.getDisplayTimeMillisecond(
                    snapshot.data!,
                  );
                  return Text(
                    '$displayTimeMinute:$displayTimeSecond.$displayTimeMilliSecond',
                    style: TextStyle(
                        color: ColorLibrary.themePrimary,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: deviceHeight < 700 ? deviceHeight * 0.07 : 50,
                        height: 1.5),
                  );
                },
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: ColorLibrary.text,
                    height: 2,
                  ),
                  children: [
                    TextSpan(
                      text: '${widget.progress.toString()} / 10',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const TextSpan(
                      text: '  問目',
                      style: TextStyle(
                        fontFamily: 'NotoSansJP',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              deviceHeight < 1000
                  ? const Spacer()
                  : const SizedBox(
                      height: 60,
                    ),
              SizedBox(
                width: deviceHeight < 700 || deviceWidth > 500
                    ? deviceHeight < 950
                        ? deviceHeight * 0.37
                        : 351.5
                    : deviceHeight * 0.33,
                height: deviceHeight < 950
                    ? buttonSize * 3 + deviceHeight * 0.04 * 2
                    : 524.875,
                child: GridView.builder(
                  itemCount: valueOnCards.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: isButtonEnabled
                          ? () {
                              HapticFeedback.selectionClick();
                              Future.delayed(const Duration(milliseconds: 245),
                                  () {
                                isButtonEnabled
                                    ? setState(() {
                                        if (backgroundColor[index] ==
                                            ColorLibrary.white) {
                                          backgroundColor[index] =
                                              ColorLibrary.themeSecondary;
                                          overlayColor[index] =
                                              ColorLibrary.white;
                                          sum += valueOnCards[index];
                                        } else {
                                          backgroundColor[index] =
                                              ColorLibrary.white;
                                          overlayColor[index] =
                                              ColorLibrary.themeSecondary;
                                          borderColor[index] =
                                              ColorLibrary.themeSecondary;
                                          sum -= valueOnCards[index];
                                        }
                                        if (sum == 23) {
                                          isButtonEnabled = false;
                                          for (int i = 0; i < 6; i++) {
                                            if (backgroundColor[i] ==
                                                ColorLibrary.themeSecondary) {
                                              backgroundColor[i] =
                                                  ColorLibrary.greenPrimary;
                                              borderColor[i] =
                                                  ColorLibrary.greenSecondary;
                                            }
                                          }
                                          HapticFeedback.mediumImpact();
                                          widget.progress == 10
                                              ? widget.stopWatchTimer!
                                                  .onStopTimer()
                                              : {};
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  if (widget.progress < 10) {
                                                    return Play(
                                                      progress:
                                                          widget.progress + 1,
                                                      stopWatchTimer:
                                                          widget.stopWatchTimer,
                                                    );
                                                  } else {
                                                    return Result(
                                                      minutes:
                                                          displayTimeMinute,
                                                      seconds:
                                                          displayTimeSecond,
                                                      milliSeconds:
                                                          displayTimeMilliSecond,
                                                    );
                                                  }
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  const Offset begin =
                                                      Offset(1.0, 0.0); // 右から左
                                                  // final Offset begin = Offset(-1.0, 0.0); // 左から右
                                                  const Offset end =
                                                      Offset.zero;
                                                  final Animatable<Offset>
                                                      tween = Tween(
                                                              begin: begin,
                                                              end: end)
                                                          .chain(CurveTween(
                                                              curve: Curves
                                                                  .easeInOut));
                                                  final Animation<Offset>
                                                      offsetAnimation =
                                                      animation.drive(tween);
                                                  return SlideTransition(
                                                    position: offsetAnimation,
                                                    child: child,
                                                  );
                                                },
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 200),
                                              ),
                                            );
                                          });
                                        }
                                      })
                                    : () {};
                                // print(sum);
                              });
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(backgroundColor[index]),
                        overlayColor:
                            MaterialStateProperty.all(overlayColor[index]),
                      ).merge(
                        TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: borderColor[index],
                            width: 1.5,
                          ),
                          splashFactory: InkRipple.splashFactory,
                        ),
                      ),
                      child: Text(
                        valueOnCards[index].toString(),
                        style: TextStyle(
                          color: ColorLibrary.text,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: deviceHeight > 700
                              ? deviceHeight > 900
                                  ? 40
                                  : buttonSize * 0.3
                              : 33,
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        deviceHeight < 950 ? deviceHeight * 0.04 : 38,
                    crossAxisSpacing: deviceHeight < 700 || deviceWidth > 500
                        ? deviceHeight < 950
                            ? deviceHeight * 0.055
                            : 52.25
                        : deviceHeight * 0.059,
                    childAspectRatio: 1,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
