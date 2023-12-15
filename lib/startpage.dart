import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lasthope/HomePage.dart';
import 'package:lasthope/settings.dart';

class StartPage extends StatelessWidget {
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 5.5,
              width: MediaQuery.of(context).size.width,
            ),
            Image.asset(
              'images/pacman_logo.png',
              width: 200,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 251, 0),
                fontFamily: 'PressStart2P',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 255, 251, 0),
                          Color.fromARGB(255, 255, 251, 0),
                        ],
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Play",
                      style: TextStyle(
                        fontFamily: "PressStart2P",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    )),
                  ),
                ),
                //Settings
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 255, 251, 0),
                          Color.fromARGB(255, 255, 251, 0),
                        ],
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: "PressStart2P",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
