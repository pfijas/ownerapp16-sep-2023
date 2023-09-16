import 'package:flutter/material.dart';
class salespg extends StatefulWidget {
  const salespg({Key? key}) : super(key: key);

  @override
  State<salespg> createState() => _salespgState();
}

class _salespgState extends State<salespg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Company datails ",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cash :"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Credit :"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Return :"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
