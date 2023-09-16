import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Stockchecking extends StatefulWidget {
  @override
  _StockcheckingPageState createState() => _StockcheckingPageState();
}

class _StockcheckingPageState extends State<Stockchecking> {
  List<Map<String, dynamic>> companyData = [];
  List<Map<String, dynamic>> filteredCompanyData = [];

  TextEditingController searchController = TextEditingController();

  Future<void> fetchCompanyData() async {
    final apiUrl = Uri.parse(
        'http://api.demo-zatreport.vintechsoftsolutions.com/api/Reports/iteminventory?companyId=1');
    try {
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          companyData =
              List<Map<String, dynamic>>.from(data['Data']['Inventory']);
          filteredCompanyData = companyData;
        });
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API call: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompanyData();
  }

  void filterData(String query) {
    setState(() {
      filteredCompanyData = companyData
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              item['code'].toLowerCase().contains(query.toLowerCase()) ||
              item['barcode'].toLowerCase().contains(query.toLowerCase()) ||
              item['serialno'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.grey,
        title: const Text(
          'Stocks',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: filteredCompanyData.isEmpty
                  ? CircularProgressIndicator(color: Colors.black45)
                  : ListView.builder(
                      itemCount: filteredCompanyData.length,
                      itemBuilder: (ctx, index) {
                        final item = filteredCompanyData[index];
                        return GestureDetector(
                          onTap: () {
                            showTransactionDetails(item, context);
                          },
                          child: ListTile(
                            title: Text("${item['name']}"),
                            subtitle: Text("Barcode: ${item['barcode']}"),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void showTransactionDetails(
      Map<String, dynamic> ledgerTypeData, BuildContext context) {
    String nameText = 'Name : ${ledgerTypeData['name']}';
    String barcodeText = 'barcode : ${ledgerTypeData['barcode']}';
    String codeText = 'Code : ${ledgerTypeData['code']}';
    String serialnoText = 'serialno : ${ledgerTypeData['serialno']}';
    String hsncodeText = 'hsncode: ${ledgerTypeData['hsncode']}';
    String srateText = 'srate : ${ledgerTypeData['srate']}';
    String mrpText = ' mrp: ${ledgerTypeData['mrp']}';
    String stockText = 'stock : ${ledgerTypeData['stock']}';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
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
                      ),
                    ),
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
                    Text(barcodeText),
                    Text(codeText),
                    Text(serialnoText),
                    Text(hsncodeText),
                    Text(srateText),
                    Text(mrpText),
                    Text(stockText),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 45,
                  width: 120,
                  child: ClipRRect(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
