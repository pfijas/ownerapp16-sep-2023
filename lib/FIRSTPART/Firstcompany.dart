import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ownerapp/FIRSTPART/homepage.dart';
import 'package:ownerapp/FIRSTPART/stockchecking.dart';
import 'dashboard.dart';

class EachCompany extends StatefulWidget {
  final String companyName;

  const EachCompany({Key? key, required this.companyName}) : super(key: key);

  @override
  State<EachCompany> createState() => _EachCompanyState();
}

class _EachCompanyState extends State<EachCompany> {
  List<dynamic>? companyData;

  Future<void> fetchCompanyData() async {
    final url = Uri.parse(
        'http://api.demo-zatreport.vintechsoftsolutions.com/api/Dashboard/loaddashboard?Company=QMARTPERIYA2020TO21&FromDate=2019-06-11&ToDate=2021-06-11&companyId=1');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          companyData = data['Data']['Dashbaord'];
        });
      } else {
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error during API call: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/eachpage.jpg', // Replace with your image path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.grey,
                  expandedHeight: 120.0, // Set the height of the app bar
                  pinned: true, // Make the app bar pinned
                  floating: false, // Make the app bar not float
                  snap: false, // Make the app bar not snap
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.companyName,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: companyData != null
                            ? ListView.builder(
                          itemCount: companyData!.length + 1,
                          shrinkWrap: true,
                          physics:
                          NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index < companyData!.length) {
                              var transaction =
                              companyData![index];
                              String transType =
                              transaction['TransType'];

                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Container(
                                  decoration:
                                  const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 3,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$transType ",
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Divider(
                                            color:
                                            Colors.blueGrey),
                                        Row(
                                          children: [
                                            if (transType ==
                                                'Purchase' ||
                                                transType == 'Sales' ||
                                                transType ==
                                                    'Payment' ||
                                                transType ==
                                                    'Receipt')
                                              Row(
                                                children: [
                                                  Text(
                                                      "Cash: ${transaction['Cash']}"),
                                                  SizedBox(
                                                    width: 60,
                                                  ),
                                                  Text(
                                                      "Receipt: ${transaction['Receipt']}"),
                                                ],
                                              ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            if (transType ==
                                                'Sales' ||
                                                transType ==
                                                    'Payment' ||
                                                transType ==
                                                    'Receipt' ||
                                                transType ==
                                                    'Purchase')
                                              Row(
                                                children: [
                                                  Text(
                                                      "Bank: ${transaction['Bank']}"),
                                                 SizedBox(width: 100),
                                                  Text(
                                                      "Credit: ${transaction['Credit']}"),
                                                ],
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 120.0),
                                          child: Text(
                                            "Total Amount: ${transaction['TotalAmount']}",
                                            style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Render the buttons
                              return Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.brown,
                                      minimumSize: Size(140.0, 35.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.book_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Ledger', // Change the button text here
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Stockchecking(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.brown,
                                      minimumSize: Size(140.0, 35.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.store_mall_directory),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Stock ', // Change the button text here
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        )
                            : Center(
                          child: CircularProgressIndicator(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
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
