import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components.dart';
import 'home.dart';
import 'ranking.dart';
import 'ready.dart';

class Result extends StatefulWidget {
  const Result({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.milliSeconds,
  });

  final String minutes, seconds, milliSeconds;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List name = [];
  List time = [];
  bool isLoading = true;
  int rank = 1;
  double tmpNum = 0, playerNum = 0, dif = 0;

  @override
  void initState() {
    playerNum = (double.parse(widget.minutes)) * 60 +
        double.parse(widget.seconds) +
        (double.parse(widget.milliSeconds)) * 0.01;
    super.initState();
    setData();
    fetchData(); //  // ページが表示されたらデータを取得する
  }

  Future<void> fetchData() async {
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshot = await db.collection("users").orderBy("time").get();
      int index = 1;

      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        setState(() {
          name.add(data["name"]);
          time.add(data["time"]);
        });
        tmpNum = (double.parse((data["time"][0]) + (data["time"][1]))) * 60 +
            (double.parse((data["time"][3]) + (data["time"][4]))) +
            (double.parse((data["time"][6]) + (data["time"][7]))) * 0.01;
        tmpNum <= playerNum ? rank = index : {};
        index++;
      }
      dif = playerNum -
          ((double.parse(((time[0])[0]) + ((time[0])[1]))) * 60 +
              (double.parse(((time[0])[3]) + ((time[0])[4]))) +
              (double.parse(((time[0])[6]) + ((time[0])[7]))) * 0.01);
    } catch (e) {
      const Text("データが取得できませんでした");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> setData() async {
    try {
      var db = FirebaseFirestore.instance;
      final data = {
        "name": Ready.name != '' ? Ready.name : 'Anonymous',
        "time":
            "${widget.minutes.padLeft(2, '0')}:${widget.seconds.padLeft(2, '0')}.${widget.milliSeconds.padLeft(2, '0')}"
      };
      await db.collection("users").add(data);
    } catch (e) {
      const Text("データを保存できませんでした");
    }
  }

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
                '${widget.minutes.padLeft(2, '0')}:${widget.seconds.padLeft(2, '0')}.${widget.milliSeconds.padLeft(2, '0')}',
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
                rank == 1
                    ? '$rank位の記録です。\nおめでとうございます！'
                    : '$rank位の記録です。\n1位まで、あと ${dif.toStringAsFixed(2)}秒 です。',
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
                    'Addition 23',
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
