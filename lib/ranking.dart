import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'components.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  RankingState createState() => RankingState();
}

class RankingState extends State<Ranking> {
  List name = [];
  List time = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // ページが表示されたらデータを取得する
  }

  Future<void> fetchData() async {
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshot =
          await db.collection("users").orderBy("time").limit(500).get();
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
        child: isLoading
            ? CircularProgressIndicator(
                color: ColorLibrary.themePrimary,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 23.0,
                      bottom: 8.0,
                      left: 30,
                    ),
                    child: Row(
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
                        const SizedBox(width: 10),
                        Container(
                          height: 45,
                          alignment: const Alignment(0, -2),
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
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Scrollbar(
                        thumbVisibility: false,
                        thickness: 5,
                        radius: const Radius.circular(10),
                        interactive: true,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView.builder(
                          itemCount: time.length,
                          itemExtent: 105.0,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 30,
                                right: 23,
                              ),
                              decoration: index == 0
                                  ? BoxDecoration(
                                      color: ColorLibrary.themePrimary,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorLibrary.themePrimary
                                              .withOpacity(0.3),
                                          offset: const Offset(0, 0),
                                          blurRadius: 8.0,
                                          spreadRadius: 1.5,
                                        ),
                                      ],
                                    )
                                  : BoxDecoration(
                                      color: ColorLibrary.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: ColorLibrary.themeSecondary,
                                        width: 1.25,
                                      ),
                                    ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    width: 45,
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: index == 0
                                        ? BoxDecoration(
                                            color: ColorLibrary.white,
                                            shape: BoxShape.circle,
                                          )
                                        : BoxDecoration(
                                            color: ColorLibrary.themeQuaternary,
                                            shape: BoxShape.circle,
                                          ),
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        color: index == 0
                                            ? ColorLibrary.themePrimary
                                            : ColorLibrary.gray,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        time[index],
                                        style: TextStyle(
                                          color: index == 0
                                              ? Colors.white
                                              : ColorLibrary.text,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          letterSpacing: 0.5,
                                          height: 1.2,
                                        ),
                                      ),
                                      Text(
                                        name[index],
                                        style: TextStyle(
                                          color: index == 0
                                              ? Colors.white
                                              : ColorLibrary.gray,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          height: 1.3,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
