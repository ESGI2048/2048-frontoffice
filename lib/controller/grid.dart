import 'package:augarde_2048/model/point.dart';
import 'dart:math';

/// Return a blank Grid.
List<List<int>> blankGrid() {
  List<List<int>> rows = [];
  for(int i = 0; i < 4; i++) {
    rows.add([0,0,0,0]);
  }
  return rows;
}

/// Compare 2 Grid.
/// @param Grid a
/// @param Grid b
/// Return True if 2 Grid are equals, False else
bool compare(List<List<int>> a, List<List<int>> b) {
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      if(a[i][j] != b[i][j]) {
        return false;
      }
    }
  }
  return true;
}

/// Create a copy of Grid
/// @param Grid grid
/// Return a new Grid
List<List<int>> copyGrid(List<List<int>> grid) {
  List<List<int>> extraGrid = blankGrid();
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      extraGrid[i][j] = grid[i][j];
    }
  }
  return extraGrid;
}

/// Create a Grid reversed
/// @param Grid grid
/// Return a new Grid reversed
List<List<int>> flipGrid(List<List<int>> grid){
  for(int i = 0; i < 4; i++) {
    List<int> row = grid[i];
    grid[i] = row.reversed.toList();
  }
  return grid;
}

/// Create a Grid transposed
/// @param Grid grid
/// Return a new Grid transposed
List<List<int>> transposeGrid(List<List<int>> grid){
  List<List<int>> newGrid = blankGrid();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      newGrid[i][j] = grid[j][i];
    }
  }
  return newGrid;
}

/// Add Number Tile in Grid
/// @param Grid grid
/// @param Grid gridNew
/// Return a new Grid with new numbers
List<List<int>> addNumber(List<List<int>> grid, List<List<int>> gridNew){
  List<Point> options = [];
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 0) {
        options.add(Point(i, j));

      }
    }
  }
  if (options.length > 0) {
    int spotRandomIndex = new Random().nextInt(options.length);
    Point spot = options[spotRandomIndex];
    int r = new Random().nextInt(100);
    grid[spot.x][spot.y] = r > 50 ? 4 : 2;
    gridNew[spot.x][spot.y] = 1;
  }

  return grid;
}