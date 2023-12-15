import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:lasthope/path.dart';
import 'package:lasthope/pixel.dart';
import 'package:lasthope/player.dart';
import 'package:lasthope/ghost.dart';
import 'package:lasthope/ghost2.dart';
import 'package:lasthope/ghost3.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 15;
  int numberOfSquares = 15 * 20;
  int player = 271;
  int ghost = 28;
  int ghost2 = 88;
  int ghost3 = 17;
  bool preGame = true;
  bool mouthClosed = false;
  var controller;
  int score = 0;
  bool paused = false;
  AudioPlayer advancedPlayer = new AudioPlayer();
  AudioPlayer advancedPlayer2 = new AudioPlayer();
  AudioCache audioInGame = new AudioCache(prefix: 'assets/');
  AudioCache audioMunch = new AudioCache(prefix: 'assets/');
  AudioCache audioDeath = new AudioCache(prefix: 'assets/');
  AudioCache audioPaused = new AudioCache(prefix: 'assets/');

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    22,
    29,
    30,
    32,
    34,
    35,
    37,
    39,
    40,
    42,
    44,
    45,
    47,
    49,
    50,
    52,
    54,
    55,
    57,
    59,
    60,
    74,
    75,
    77,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    87,
    89,
    90,
    92,
    97,
    102,
    104,
    105,
    107,
    108,
    109,
    110,
    112,
    114,
    115,
    116,
    117,
    119,
    120,
    122,
    132,
    134,
    135,
    139,
    140,
    141,
    143,
    144,
    145,
    149,
    150,
    151,
    152,
    154,
    160,
    162,
    163,
    164,
    169,
    175,
    180,
    181,
    182,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    192,
    193,
    194,
    195,
    209,
    210,
    212,
    213,
    215,
    216,
    217,
    218,
    219,
    221,
    222,
    224,
    225,
    228,
    232,
    236,
    239,
    240,
    245,
    247,
    249,
    254,
    255,
    257,
    258,
    259,
    260,
    264,
    265,
    266,
    267,
    269,
    270,
    284,
    285,
    286,
    287,
    288,
    289,
    290,
    291,
    292,
    293,
    294,
    295,
    296,
    297,
    298,
    299
  ];

  List<int> junctions = [
    16,
    18,
    21,
    23,
    26,
    61,
    63,
    66,
    68,
    71,
    73,
    93,
    96,
    98,
    101,
    126,
    128,
    131,
    136,
    138,
    146,
    148,
    168,
    157,
    161,
    196,
    198,
    206,
    271,
    276,
    278,
    283,
    233,
    235,
    250,
    246,
    244,
    253
  ];

  List<int> pellets = [
    16,
    17,
    18,
    19,
    20,
    21,
    23,
    24,
    25,
    26,
    27,
    28,
    31,
    33,
    36,
    38,
    41,
    43,
    46,
    48,
    51,
    53,
    56,
    58,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    76,
    78,
    86,
    88,
    91,
    93,
    94,
    95,
    96,
    98,
    99,
    100,
    101,
    103,
    106,
    111,
    113,
    118,
    121,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    133,
    136,
    137,
    138,
    142,
    146,
    147,
    148,
    153,
    155,
    156,
    157,
    158,
    159,
    161,
    165,
    166,
    167,
    168,
    170,
    171,
    172,
    173,
    174,
    176,
    177,
    178,
    179,
    183,
    187,
    191,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    211,
    214,
    220,
    223,
    226,
    227,
    229,
    230,
    231,
    233,
    234,
    235,
    237,
    238,
    241,
    242,
    243,
    244,
    246,
    248,
    250,
    251,
    252,
    253,
    256,
    261,
    262,
    263,
    268,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    283,
    287,
    288,
    289,
    290,
    292,
    293,
    294,
    295,
    296,
    297,
    299
  ];

  List<int> food = [];
  String direction = "right";
  String ghostLast = "left";
  String ghostLast2 = "left";
  String ghostLast3 = "down";

  void startGame() {
    if (preGame) {
      preGame = false;
      getFood();

      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (paused) {
        } else {
          advancedPlayer.resume();
        }
        if (player == ghost || player == ghost2 || player == ghost3) {
          advancedPlayer.stop();

          setState(() {
            player = -1;
          });
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(
                      child: Text(
                    'GameOver',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                    ),
                  )),
                  content: Text("Your Score : " + (score).toString()),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          player = numberInRow * 14 + 1;
                          ghost = numberInRow * 2 - 2;
                          ghost2 = numberInRow * 9 - 1;
                          ghost3 = numberInRow * 11 - 2;
                          paused = false;
                          preGame = false;
                          mouthClosed = false;
                          direction = "right";
                          food.clear();
                          getFood();
                          score = 0;
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(53, 45, 197, 1),
                        primary: Color.fromRGBO(
                            255, 255, 255, 1), // Change the button color
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.yellow,
                            fontFamily: 'PressStart2P',
                          )),
                    )
                  ],
                );
              });
        }
      });
      Timer.periodic(Duration(milliseconds: 190), (timer) {
        if (!paused) {
          moveGhost();
          moveGhost2();
          moveGhost3();
        }
      });
      Timer.periodic(Duration(milliseconds: 170), (timer) {
        setState(() {
          mouthClosed = !mouthClosed;
        });
        if (pellets.contains(player)) {
          pellets.remove(player);
        }
        if (food.contains(player)) {
          setState(() {
            food.remove(player);
          });
          score++;
        }

        switch (direction) {
          case "left":
            if (!paused) moveLeft();
            break;
          case "right":
            if (!paused) moveRight();
            break;
          case "up":
            if (!paused) moveUp();
            break;
          case "down":
            if (!paused) moveDown();
            break;
        }
      });
    }
  }

  void restart() {
    startGame();
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++)
      if (!barriers.contains(i)) {
        food.add(i);
      }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void moveGhost() {
    if (junctions.contains(ghost)) {
      // Activate random movement at junctions
      // Modify this part to suit your random movement logic
      // Here, I'm assuming you have a function getRandomDirection() that returns "left", "right", "up", or "down"
      String randomDirection = getRandomDirection();
      setState(() {
        ghostLast = randomDirection;
      });
    }

    switch (ghostLast) {
      case "left":
        if (!barriers.contains(ghost - 1)) {
          setState(() {
            ghost--;
          });
        } else {
          handleBarrier();
        }
        break;
      case "right":
        if (!barriers.contains(ghost + 1)) {
          setState(() {
            ghost++;
          });
        } else {
          handleBarrier();
        }
        break;
      case "up":
        if (!barriers.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
          });
        } else {
          handleBarrier();
        }
        break;
      case "down":
        if (!barriers.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
          });
        } else {
          handleBarrier();
        }
        break;
    }
  }

  void handleBarrier() {
    // You can add logic here to handle the barrier, for example, changing direction or stopping
    // In this example, I'm changing direction to a random direction when a barrier is encountered
    String randomDirection = getRandomDirection();
    setState(() {
      ghostLast = randomDirection;
    });
  }

  String getRandomDirection() {
    List<String> directions = ["left", "right", "up", "down"];
    return directions[Random().nextInt(4)];
  }

  void moveGhost2() {
    if (junctions.contains(ghost2)) {
      // Activate random movement at junctions
      // Modify this part to suit your random movement logic
      // Here, I'm assuming you have a function getRandomDirection() that returns "left", "right", "up", or "down"
      String randomDirection2 = getRandomDirection2();
      setState(() {
        ghostLast2 = randomDirection2;
      });
    }

    switch (ghostLast2) {
      case "left":
        if (!barriers.contains(ghost2 - 1)) {
          setState(() {
            ghost2--;
          });
        } else {
          handleBarrier2();
        }
        break;
      case "right":
        if (!barriers.contains(ghost2 + 1)) {
          setState(() {
            ghost++;
          });
        } else {
          handleBarrier2();
        }
        break;
      case "up":
        if (!barriers.contains(ghost2 - numberInRow)) {
          setState(() {
            ghost2 -= numberInRow;
          });
        } else {
          handleBarrier2();
        }
        break;
      case "down":
        if (!barriers.contains(ghost2 + numberInRow)) {
          setState(() {
            ghost2 += numberInRow;
          });
        } else {
          handleBarrier2();
        }
        break;
    }
  }

  void handleBarrier2() {
    // You can add logic here to handle the barrier, for example, changing direction or stopping
    // In this example, I'm changing direction to a random direction when a barrier is encountered
    String randomDirection = getRandomDirection2();
    setState(() {
      ghostLast2 = randomDirection;
    });
  }

  String getRandomDirection2() {
    List<String> directions = ["left", "right", "up", "down"];
    return directions[Random().nextInt(4)];
  }

  void moveGhost3() {
    switch (ghostLast) {
      case "left":
        if (!barriers.contains(ghost3 - 1)) {
          setState(() {
            ghost3--;
          });
        } else {
          if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          } else if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          } else if (player == 206) {
            ghostLast3 = "right";
          }
        }
        break;
      case "right":
        if (!barriers.contains(ghost3 + 1)) {
          setState(() {
            ghost3++;
          });
        } else {
          if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          } else if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          }
        }
        break;
      case "up":
        if (!barriers.contains(ghost3 - numberInRow)) {
          setState(() {
            ghost3 -= numberInRow;
            ghostLast3 = "up";
          });
        } else {
          if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          }
        }
        break;
      case "down":
        if (!barriers.contains(ghost3 + numberInRow)) {
          setState(() {
            ghost3 += numberInRow;
            ghostLast3 = "down";
          });
        } else {
          if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          SizedBox(height: 80),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    " Score:" + (score).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PressStart2P',
                        fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text("Play",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PressStart2P',
                            fontSize: 20)),
                  ),
                  if (!paused)
                    GestureDetector(
                      child: Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                      onTap: () => {
                        if (!paused)
                          {
                            paused = true,
                            advancedPlayer.pause(),
                          }
                        else
                          {
                            paused = false,
                            advancedPlayer2.stop(),
                          },
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )
                      },
                    ),
                  if (paused)
                    GestureDetector(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onTap: () => {
                        if (paused)
                          {paused = false, advancedPlayer2.stop()}
                        else
                          {
                            paused = true,
                            advancedPlayer.pause(),
                          },
                      },
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: (MediaQuery.of(context).size.height.toInt() * 0.0339).toInt(),
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
                // print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                // print(direction);
              },
              child: Container(
                child: GridView.builder(
                    padding:
                        (MediaQuery.of(context).size.height.toInt() * 0.0139)
                                    .toInt() >
                                10
                            ? EdgeInsets.only(top: 80)
                            : EdgeInsets.only(top: 20),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numberInRow,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (mouthClosed && player == index) {
                        return Padding(
                          padding: EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      } else if (player == index) {
                        // Render player based on the direction
                        switch (direction) {
                          case "left":
                            return Transform.rotate(
                              angle: pi,
                              child: MyPlayer(),
                            );
                          case "right":
                            return MyPlayer();
                          case "up":
                            return Transform.rotate(
                              angle: 3 * pi / 2,
                              child: MyPlayer(),
                            );
                          case "down":
                            return Transform.rotate(
                              angle: pi / 2,
                              child: MyPlayer(),
                            );
                          default:
                            return MyPlayer();
                        }
                      } else if (ghost == index) {
                        return MyGhost();
                      } else if (ghost2 == index) {
                        return MyGhost2();
                      } else if (ghost3 == index) {
                        return MyGhost3();
                      } else if (barriers.contains(index)) {
                        // Render pixels for barriers
                        return MyPixel(
                          innerColor: Color.fromRGBO(53, 45, 197, 1),
                          outerColor: Color.fromRGBO(53, 45, 197, 1),
                        );
                      } else if (pellets.contains(index)) {
                        // Render pixels for pellets
                        return MyPixel(
                          innerColor: Color.fromARGB(255, 255, 251, 0),
                          outerColor: Color.fromRGBO(0, 0, 0, 1),
                          child: Text("p"),
                        );
                      } else if (preGame || food.contains(index)) {
                        // Render pixels for preGame or food
                        return MyPath(
                          innerColor: Colors.yellow,
                          outerColor: Colors.black,
                        );
                      } else {
                        // Render pixels for other cases
                        return MyPath(
                          innerColor: Colors.yellow,
                          outerColor: Colors.black,
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
