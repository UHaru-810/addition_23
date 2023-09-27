import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'play.dart';

class Ready extends StatefulWidget {
  const Ready({super.key});

  static String name = "";

  @override
  State<Ready> createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {
  List name = [];
  List time = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // ページが表示されたらデータを取得する
  }

  // データ取得
  Future<void> fetchData() async {
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshot =
          await db.collection("prod_easy").orderBy("time").limit(1).get();
      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        setState(() {
          name.add(data["name"].toString());
          time.add(data["time"].toString());
        });
      }
    } catch (e) {
      const Text("データが取得できませんでした");
    }
    setState(() {
      isLoading = false;
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 285,
              child: TextField(
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
                  Ready.name = text;
                },
              ),
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
            isLoading
                ? CircularProgressIndicator(
                    color: ColorLibrary.themePrimary,
                  ) // ローディング
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: ColorLibrary.text,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      children: name.isEmpty != true
                          ? [
                              name[0] != 'Anonymous'
                                  ? TextSpan(
                                      text: '最速は、${name[0]}さんの ',
                                    )
                                  : const TextSpan(
                                      text: '最速記録は、 ',
                                    ),
                              TextSpan(
                                text: time[0],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              const TextSpan(
                                text: ' です。',
                              ),
                            ]
                          : [
                              const TextSpan(
                                text: '最速記録を目指して頑張りましょう！',
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
    );
  }
}
