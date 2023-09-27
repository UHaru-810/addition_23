import 'dart:math';

List<int> numGenerator() {
  Set<int> valueSet = Set.identity();
  List<int> valueList = List.empty(growable: true);
  int sum, tmp;
  int min = -5;
  int max = 30;
  // min, maxを変更することで、カードに表示される数の最小・最大を変更
  int numOfSelect = randomIntWithRange(2, 6);

  do {
    sum = 0;
    valueSet.clear(); // 条件をみたさなかったときに、一度削除

    do {
      tmp = randomIntWithRange(min, max);
      valueSet.add(tmp);
    } while (valueSet.length != 5);
    // セットの要素が6になるまで乱数を発生

    for (int i = 0; i < numOfSelect; i++) {
      sum += valueSet.elementAt(i);
    }

    valueSet.add(23 - sum);
  } while (valueSet.length != 6 ||
      valueSet.contains(0) ||
      valueSet.contains(23) ||
      23 - sum < min ||
      23 - sum > max);
  // セットの要素数が6でない・0が含まれる・23が含まれる・23-sumの値がmin, maxの範囲内かをしらべる

  valueList = valueSet.toList();
  // 以後の管理がしやすいようにListに変換
  valueList.shuffle();

  return valueList;
}

// 乱数生成
int randomIntWithRange(int min, int max) {
  int value = Random().nextInt(max - min);
  return value + min;
}

/*
main() {
  for (int i = 0; i < 30; i++) {
    var list = numGenerator();
    print(list);
  }
}
*/
