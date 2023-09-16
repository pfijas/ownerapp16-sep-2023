import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LedgerDetails extends StatefulWidget {
  const LedgerDetails({Key? key}) : super(key: key);

  @override
  State<LedgerDetails> createState() => _LedgerDetailsState();
}

class _LedgerDetailsState extends State<LedgerDetails> {
  String apiURL =
      'http://api.demo-zatreport.vintechsoftsolutions.com/api/Reports/ledgerbalancedetails?companyId=1&ledgerid=1';
  Map<String, dynamic> apiData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        apiData = jsonData['Data'];
      });
    } else {
      setState(() {
        apiData = {
          'MySQLMessage': {'Message': 'Failed to load data'}
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: BackButton(),
        title: Text("Ledger Details", style: TextStyle(
          fontSize: 15,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  if (apiData['LedgerDetails'] != null)
                    Column(
                      children:
                          apiData['LedgerDetails'].map<Widget>((transaction) {
                        return Column(
                          children: [
                            Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 3,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  title: Center(
                                      child: Text(
                                    "Voucher: ${transaction['voucher']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  )),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Voucher No: ${transaction['voucher_no']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Transaction Date: ${transaction['trans_date']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Transaction Amount: ${transaction['trans_amount']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Transaction Description: ${transaction['trans_description']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Add a SizedBox between cards
                          ],
                        );
                      }).toList(),
                    )
                  else
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.black45,
                    ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
