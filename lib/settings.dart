import 'package:flutter/material.dart';
import 'package:lasthope/HomePage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(53, 45, 197, 1),
              Color.fromARGB(255, 0, 0, 0)
            ], // Customize gradient colors
          ),
        ),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, left: 20),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0, left: 0),
                      child: FloatingActionButton(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.7),
                        elevation: 0,
                        onPressed: null,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Color.fromARGB(255, 255, 251, 0),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontFamily: "PressStart2P",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 251, 0),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: 100),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 40,
                            color: Color.fromARGB(255, 255, 251, 0),
                          )),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: null,
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Color.fromARGB(255, 255, 251, 0),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              fontFamily: "PressStart2P",
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 251, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 70),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Color.fromARGB(255, 255, 251, 0),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0, left: 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: null,
                      child: Icon(
                        Icons.file_copy,
                        size: 30,
                        color: Color.fromARGB(255, 255, 251, 0),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            "Files & Data",
                            style: TextStyle(
                              fontFamily: "PressStart2P",
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 251, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 70),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Color.fromARGB(255, 255, 251, 0),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0, left: 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: null,
                      child: Icon(
                        Icons.help_center,
                        size: 30,
                        color: Color.fromARGB(255, 255, 251, 0),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            "Help Center",
                            style: TextStyle(
                              fontFamily: "PressStart2P",
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 251, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 85),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Color.fromARGB(255, 255, 251, 0),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                left: 10,
              ),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 205),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(53, 45, 197, 1),
        shadowColor: Color.fromRGBO(128, 45, 83, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 255, 251, 0),
          iconSize: 37,
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 251, 0),
            fontFamily: 'PressStart2P',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
