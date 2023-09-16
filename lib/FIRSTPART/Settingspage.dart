import 'package:flutter/material.dart';

import 'loginpage.dart';

class settingspae1 extends StatefulWidget {
  const settingspae1({Key? key}) : super(key: key);

  @override
  State<settingspae1> createState() => _settingspae1State();
}

class _settingspae1State extends State<settingspae1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Settings",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Notification ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Help and Support",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white70)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "LOG OUT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
