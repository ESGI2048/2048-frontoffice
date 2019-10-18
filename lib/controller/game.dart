import 'package:shared_preferences/shared_preferences.dart';

/// Return List contains new score and new Row after swipe
List operate(List<int> row, int score,SharedPreferences sharedPref) {
  row = slide(row);
  List result = combine(row, score, sharedPref);
  int sc = result[0];
  row = result[1];
  row = slide(row);

  print('from func ${sc}');
  return [sc, row];
}

/// Return List of number from a row Grid
List<int> filter(List<int> row) {
  List<int> temp = [];
  for(int i = 0; i < row.length; i++){
    if(row[i] != 0){
      temp.add(row[i]);
    }
  }
  return temp;
}

/// Return a new Row after swipe
List<int> slide(List<int> row) {
  List<int> arr = filter(row);
  int missing = 4 - arr.length;
  List<int> zeroes = zeroArray(missing);
  arr = zeroes + arr;
  return arr;
}

/// Return a List of length 0
List<int> zeroArray(int length) {
  List<int> zeroes = [];
  for(int i = 0; i < length; i++) {
    zeroes.add(0);
  }
  return zeroes;
}

/// Return List contains score and a new Row after combine 2 equals number
List combine(List<int> row, int score, SharedPreferences sharedPref) {
  for (int i = 3; i >= 1; i--) {
    int a = row[i];
    int b = row[i - 1];
    if (a == b) {
      row[i] = a + b;
      score += row[i];
      int sc = sharedPref.getInt('high_score');
      if(sc == null){
        sharedPref.setInt('high_score', score);
      }else {
        if(score > sc) {
          sharedPref.setInt('high_score', score);
        }
      }
      row[i - 1] = 0;
    }
  }
  return [score, row];
}

/// Return True if one tile equal 2048, False else
bool isGameWon(List<List<int>> grid) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 64) {
        return true;
      }
    }
  }
  return false;
}

/// Return True if a Grid is complete and cannot swipe, False else
bool isGameOver(List<List<int>> grid) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 0) {
        return false;
      }
      if (i != 3 && grid[i][j] == grid[i + 1][j]) {
        return false;
      }
      if (j != 3 && grid[i][j] == grid[i][j + 1]) {
        return false;
      }
    }
  }
  return true;
}