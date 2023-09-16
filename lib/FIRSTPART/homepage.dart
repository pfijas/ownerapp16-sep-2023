import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ownerapp/FIRSTPART/profilepage.dart';
import 'dart:convert';
import 'Firstcompany.dart';
import 'dashboard.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  bool showTodayData = true;
  String selectedCategory = "Today";
  TextEditingController dateInput = TextEditingController();
  DateTime? _selectedDate;
  late List<Map<String, dynamic>> responseData;

  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.demo-zatreport.vintechsoftsolutions.com/api/Company/CompanyList/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data1 = jsonData['Data']['ResponseData']['Data1'];
        return List<Map<String, dynamic>>.from(data1);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'http://api.demo-zatreport.vintechsoftsolutions.com/api/Company/GetOverallTrans?viewmode=full&today=2021-10-23&compid=0'),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final data = jsonData['Data']['ResponseData'] as List<dynamic>;
      responseData = List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  List<IconData> cardIcons = [
    Icons.sailing,
    Icons.shopping_cart,
    Icons.payment,
    Icons.newspaper,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 2000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/hm2.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new_sharp,
                                // Change to your preferred back icon
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context); // Navigate back
                              },
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => profilepg(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        Text(
                          'VINTECH',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("SOFT SOLUTIONs"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      child: FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            final dataList =
                                snapshot.data as List<Map<String, dynamic>>;

                            final chunkedData = chunkList(
                                dataList, 2); // Split data into chunks of 2
                            return Column(
                              children: [
                                for (final chunk in chunkedData)
                                  Row(
                                    children: [
                                      for (final companyData in chunk)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 200,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                elevation: 40,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EachCompany(
                                                                    companyName:
                                                                        companyData[
                                                                            'CompanyName']),
                                                          ),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          // Adjust the radius as needed
                                                          topRight: Radius.circular(
                                                              20), // Adjust the radius as needed
                                                        ),
                                                        child: Container(
                                                          height: 100,
                                                          width:
                                                              double.infinity,
                                                          child: Image.network(
                                                            'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c2hvcHBpbmclMjBtYWxsJTIwaW50ZXJpb3J8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        companyData[
                                                            'CompanyName'],
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      subtitle: Text(
                                                        companyData['Address'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EachCompany(
                                                                    companyName:
                                                                        companyData[
                                                                            'CompanyName']),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: 150,
                    //     height: 60,
                    //     child: Card(
                    //         elevation: 5,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //           side: BorderSide(width: 0, color: Colors.brown),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: TextField(
                    //             controller: dateInput,
                    //             decoration: InputDecoration(
                    //               icon: Icon(Icons.calendar_month_sharp,
                    //                   color: Colors.black45),
                    //               labelText: "   Enter Date",
                    //               border: InputBorder.none,
                    //               contentPadding: EdgeInsets.only(bottom: 10.0),
                    //             ),
                    //             readOnly: true,
                    //             // Set this property to true to make the field non-editable
                    //             onTap: () async {
                    //               DateTime? pickedDate = await showDatePicker(
                    //                 context: context,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime(1950),
                    //                 lastDate: DateTime(2100),
                    //               );
                    //
                    //               if (pickedDate != null) {
                    //                 setState(() {
                    //                   _selectedDate = pickedDate;
                    //                   dateInput.text = DateFormat('yyyy-MM-dd')
                    //                       .format(pickedDate);
                    //                 });
                    //               }
                    //             },
                    //           ),
                    //         )),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = "Today"; // Change to "Sale"
                              });
                              fetchData(); // Call the function to fetch "Today" data
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          width: 5,
                                          color: selectedCategory == "Today"
                                              ? Colors.black
                                              : Colors.transparent),
                                    ),
                                  ),
                                  child: Center(child: Text("Today")),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory =
                                    "Weakly"; // Change to "Purchase"
                              });
                              fetchData(); // Call the function to fetch "Today" data
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          width: 5,
                                          color: selectedCategory == "Weakly"
                                              ? Colors.black
                                              : Colors.transparent),
                                    ),
                                  ),
                                  child: const Center(child: Text("Weakly")),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 130),
                      child: Container(
                        height: 50,
                        child: Container(
                            child: Center(
                                child: Text(
                          "Overall Transaction ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final transTypeDataList = responseData;

                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                (transTypeDataList.length / 2).ceil(),
                                (index) {
                                  final startIndex = index * 2;
                                  final endIndex = startIndex + 2;
                                  final rowData = transTypeDataList.sublist(
                                      startIndex, endIndex);

                                  return Row(
                                    children: [
                                      for (int i = 0; i < rowData.length; i++)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Card(
                                              elevation: 5,
                                              margin: EdgeInsets.all(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                      width: 5,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showTransactionDetails(
                                                        rowData[i], context);
                                                  },
                                                  child: ListTile(
                                                    title: Row(
                                                      children: [
                                                        Icon(
                                                          cardIcons[
                                                              index * 2 + i],
                                                          // Assign the icon based on the index
                                                          color: Colors
                                                              .blueGrey, // Adjust the color as needed
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          '${rowData[i]['TransType']}',
                                                        ),
                                                      ],
                                                    ),
                                                    // Other list tile properties
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTransactionDetails(
      Map<String, dynamic> transTypeData, BuildContext context) {
    String transType = transTypeData['TransType'];

    String cashText = 'Cash: ${transTypeData['Cash']}';
    String creditText = 'Credit: ${transTypeData['Credit']}';
    String bankText = 'Bank: ${transTypeData['Bank']}';
    String totalAmountText = 'TotalAmount: ${transTypeData['TotalAmount']}';

    if (transType == 'Receipt') {
      creditText = ''; // Empty text for credit
    }
    if (transType == 'Purchase') {
      bankText = ''; // Empty text for card
    }
    if (transType == 'Payment') {
      creditText = '';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust the radius as needed
          ),
          title: Column(
            children: [
              Text('Overall $transType Details'),
              Divider(
                color: Colors.blueGrey,
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(cashText),
              if (creditText.isNotEmpty) Text(creditText),
              // Add creditText only if not empty
              if (bankText.isNotEmpty) Text(bankText),
              SizedBox(
                height: 10,
              ),
              Text(
                totalAmountText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
