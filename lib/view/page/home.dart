import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:augarde_2048/controller/grid.dart';
import 'package:augarde_2048/controller/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<int>> grid = [];
  List<List<int>> gridNew = [];
  int score = 0;
  bool isgameOver = false;
  bool isgameWon = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    //
    grid = blankGrid();
    gridNew = blankGrid();
    addNumber(grid, gridNew);
    addNumber(grid, gridNew);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 80) / 4;
    double gridHeight = gridWidth;
    double height = 30 + (gridHeight * 4) + 10;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          '2048',
          fontSize: 25.0,
          textBold: true,
        ),
        backgroundColor: Color(gridBackground),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  width: 200.0,
                  height: 82.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(gridBackground),
                  ),
                  child: Column(
                    children: <Widget>[
                      PaddingWith(
                        widget: MyText('Score', textBold: true,),
                        top: 10.0,
                        bottom: 2.0,
                      ),
                      PaddingWith(
                        widget: MyText('$score', fontSize: 22.0, textBold: true,),
                        top: 10.0,
                        bottom: 10.0,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: height,
                color: Color(gridBackground),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: GridView.count(
                          primary: false,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          crossAxisCount: 4,
                          children: getGrid(gridWidth, gridHeight),
                        ),
                        onVerticalDragEnd: (DragEndDetails details) {
                          //primaryVelocity -ve up +ve down
                          if (details.primaryVelocity < 0) {
                             handleGesture(0);
                          } else if (details.primaryVelocity > 0) {
                             handleGesture(1);
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          //-ve right, +ve left
                          if (details.primaryVelocity > 0) {
                             handleGesture(2);
                          } else if (details.primaryVelocity < 0) {
                             handleGesture(3);
                          }
                        },
                      ),
                    ),
                    isgameOver
                        ? Container(
                      height: height,
                      color: Color(transparentWhite),
                      child: Center(
                        child: MyText(
                          'Game over !',
                          fontSize: 30.0,
                          textBold: true,
                          color: Color(gridBackground),
                        ),
                      ),
                    )
                        : SizedBox(),
                    isgameWon
                        ? Container(
                      height: height,
                      color: Color(transparentWhite),
                      child: Center(
                        child: MyText(
                          'You won !',
                          fontSize: 30.0,
                          textBold: true,
                          color: Color(gridBackground),
                        ),
                      ),
                    )
                        : SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(gridBackground),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: IconButton(
                          iconSize: 35.0,
                          icon: refreshIcon,
                          onPressed: () {
                            setState(() {
                              grid = blankGrid();
                              gridNew = blankGrid();
                              grid = addNumber(grid, gridNew);
                              grid = addNumber(grid, gridNew);
                              score = 0;
                              isgameOver = false;
                              isgameWon = false;
                            });
                          },
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(gridBackground),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            MyText(
                              'High Score',
                              textBold: true,
                            ),
                            FutureBuilder<String>(
                              future: getHighScore(),
                              builder: (ctx, snapshot) {
                                if (snapshot.hasData) {
                                  return MyText(
                                    snapshot.data,
                                    textBold: true,
                                  );
                                } else {
                                  return MyText(
                                    '0',
                                    textBold: true,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Return Grid
  List<Widget> getGrid(double width, double height) {
    List<Widget> grids = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int num = grid[i][j];
        String number;
        int color;

        if (num == 0) {
          color = emptyGridBackground;
          number = "";
        } else if (num == 2 || num == 4) {
          color = gridColorTwoFour;
          number = "$num";
          //image1 = 4;

        } else if (num == 8 || num == 64 || num == 256) {
          color = gridColorEightSixtyFourTwoFiftySix;
          number = "$num";
        } else if (num == 16 || num == 32 || num == 1024) {
          color = gridColorSixteenThirtyTwoOneZeroTwoFour;

          number = "$num";
        } else if (num == 128 || num == 512) {
          color = gridColorOneTwentyEightFiveOneTwo;
          number = "$num";
        } else {
          color = gridColorWin;
          number = "$num";
        }
        double size;
        String n = "$number";
        // Scale Font Size
        switch (n.length) {
          case 1:
          case 2:
            size = 40.0;
            break;
          case 3:
            size = 30.0;
            break;
          case 4:
            size = 20.0;
            break;
        }
        grids.add(ItemTile(number, width, height, color, size, null));
      }
    }
    return grids;
  }


  void handleGesture(int direction) {
    /*
      0 = up
      1 = down
      2 = left
      3 = right
    */
    bool flipped = false;
    bool played = true;
    bool rotated = false;

    if (direction == 0) {
      setState(() {
        grid = transposeGrid(grid);
        grid = flipGrid(grid);
        rotated = true;
        flipped = true;
      });
    } else if (direction == 1) {
      setState(() {
        grid = transposeGrid(grid);
        rotated = true;
      });
    } else if (direction == 2) {
    } else if (direction == 3) {
      setState(() {
        grid = flipGrid(grid);
        flipped = true;
      });
    } else {
      played = false;
    }

    if (played) {
      print('playing');
      List<List<int>> past = copyGrid(grid);
      print('past $past');
      for (int i = 0; i < 4; i++) {
        setState(() {
          List result = operate(grid[i], score, sharedPreferences);
          score = result[0];
          print('score in set state $score');
          grid[i] = result[1];
        });
      }
      setState(() {
        grid = addNumber(grid, gridNew);
      });
      bool changed = compare(past, grid);
      print('changed $changed');
      if (flipped) {
        setState(() {
          grid = flipGrid(grid);
        });
      }

      if (rotated) {
        setState(() {
          grid = transposeGrid(grid);
        });
      }

      if (changed) {
        setState(() {
          grid = addNumber(grid, gridNew);
          print('is changed');
        });
      } else {
        print('not changed');
      }

      bool gameover = isGameOver(grid);
      if (gameover) {
        print('game over');
        setState(() {
          isgameOver = true;
        });
      }

      bool gamewon = isGameWon(grid);
      if (gamewon) {
        print("GAME WON");
        setState(() {
          isgameWon = true;
        });
      }
      print(grid);
      print(score);
    }
  }

  Future<String> getHighScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int score = sharedPreferences.getInt('high_score');
    if (score == null) {
      score = 0;
    }
    return score.toString();
  }

}
