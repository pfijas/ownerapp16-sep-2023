import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Firstcompany.dart';
import 'ledgerDetails.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> companyData = []; // Change to dynamic
  List<Map<String, dynamic>> filteredCompanyData = [];

  // Change to dynamic
  List<String> balanceAmntList = [];
  List<String> balanceDateList = [];

  TextEditingController searchController = TextEditingController();

  Future<void> fetchCompanyData() async {
    final apiUrl = Uri.parse(
        'http://api.demo-zatreport.vintechsoftsolutions.com/api/Reports/ledgerbalance?companyId=1');
    try {
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          companyData = List<Map<String, dynamic>>.from(
              data['Data']['LedgerBalance']); // Corrected field name
          // Initialize the filtered data with the full data initially
          filteredCompanyData = companyData;

          // Extract balance_amnt and balance_date lists
          if (companyData.isNotEmpty) {
            balanceAmntList = companyData
                .map((item) => item['balance_type'].toString())
                .toList();
            balanceDateList = companyData
                .map((item) => item['balance_amnt'].toString())
                .toList();
          }
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

  // Function to handle filtering based on the search query
  void filterData(String query) {
    setState(() {
      filteredCompanyData = companyData
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              item['code'].toLowerCase().contains(query.toLowerCase()) ||
              item['area'].toLowerCase().contains(query.toLowerCase()) ||
              item['phone'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  List<String> networkImageUrls = [
    'https://images.unsplash.com/photo-1694638275387-9971d6b19880?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1682688759350-050208b1211c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1682905926517-6be3768e29f0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://plus.unsplash.com/premium_photo-1671644439657-789881ebbef4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1682685797406-97f364419b4a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1693850323307-b36c58092934?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=600&q=60'
    // Add more paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.grey,
        title: const Text(
          'Ledgers',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 50,
                child: TextField(
                  cursorColor: Colors.black45,
                  controller: searchController,
                  onChanged: filterData,
                  decoration: InputDecoration(
                    hintText: 'Search name ',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: Colors
                              .black), // Change the border color when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Change the border color when not focused
                    ),
                  ),
                ),
              )),
          Expanded(
            child: Center(
                child: filteredCompanyData.isEmpty
                    ? CircularProgressIndicator(
                        color: Colors.black45,
                      )
                    : ListView.builder(
                        itemCount: filteredCompanyData.length,
                        itemBuilder: (ctx, index) {
                          final item = filteredCompanyData[index];
                          // Determine the index for the network image based on data (e.g., use index % networkImageUrls.length)
                          int imageUrlIndex = index % networkImageUrls.length;

                          // Determine the text color based on the value of balance_type
                          Color textColor = Colors.black; // Default color
                          if (balanceAmntList[index] == 'CR') {
                            textColor = Colors.green; // Green for "CR"
                          } else if (balanceAmntList[index] == 'DR') {
                            textColor = Colors.red; // Red for "DR"
                          }

                          return GestureDetector(
                            onTap: () {
                              showTransactionDetails(item, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        networkImageUrls[imageUrlIndex]),
                                  ),
                                  title: Text("${item['name']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text("code: ${item['code']}"),
                                  trailing: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${balanceAmntList[index]} ${balanceDateList[index]}',
                                          style: TextStyle(
                                              color:
                                                  textColor), // Apply text color
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ),
        ],
      ),
    );
  }

  void showTransactionDetails(
      Map<String, dynamic> ledgerTypeData, BuildContext context) {
    String nameText = 'Name : ${ledgerTypeData['name']}';
    String codeText = 'Code : ${ledgerTypeData['code']}';
    String phoneText = 'Phone : ${ledgerTypeData['phone']}';
    String addressText = 'Address : ${ledgerTypeData['address']}';
    String areaText = 'Area: ${ledgerTypeData['area']}';
    String emailText = 'Email : ${ledgerTypeData['email']}';
    String balanceAmnttext = '${ledgerTypeData['balance_amnt']}';
    String balancetypeText = 'Balance  :  ${ledgerTypeData['balance_type']}';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                        child: Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(nameText),
                    Text(codeText),
                    Text(phoneText),
                    Text(addressText),
                    Text(areaText),
                    Text(emailText),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(' $balancetypeText $balanceAmnttext ',
                            style:
                                const TextStyle(fontWeight: FontWeight.w900))),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 45,
                      width: 120,
                      child: ClipRRect(
                        child: Card(
                          color: Color.fromRGBO(39, 39, 38, 0.5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LedgerDetails(),
                                ),
                              );
                            },
                            child: const Text(
                              'Ledger details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 45,
                      width: 120,
                      child: ClipRRect(
                        child: Card(
                          color: Colors.redAccent,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
