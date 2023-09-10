import 'dart:math';

List<int> numGenerator() {
  Set<int> valueSet = Set.identity();
  List<int> valueList = List.empty(growable: true);
  int sum, tmp;
  int min = -10;
  int max = 30;
  int numOfSelect = randomIntWithRange(2, 6);

  do {
    sum = 0;
    valueSet.clear();

    do {
      tmp = randomIntWithRange(min, max);
      valueSet.add(tmp);
    } while (valueSet.length != 5);

    for (int i = 0; i < numOfSelect; i++) {
      sum += valueSet.elementAt(i);
    }

    valueSet.add(23 - sum);
  } while (valueSet.length != 6 ||
      valueSet.contains(0) ||
      valueSet.contains(23) ||
      23 - sum < min ||
      23 - sum > max);

  valueList = valueSet.toList();
  // valueList.shuffle();

  return valueList;
}

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
