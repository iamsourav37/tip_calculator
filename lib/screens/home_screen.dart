import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _selection = [true, false, false];
  TextEditingController amountController = TextEditingController();
  String tipTotal;

  void calculateTip() {
    String amntInString = amountController.text;
    if (amntInString.isNotEmpty) {
      double amount = double.parse(amntInString);
      int index = _selection.indexWhere((element) => element);
      double tip = index == 0
          ? 0.1
          : index == 1
              ? 0.15
              : 0.2;

      tipTotal = (amount * tip).toStringAsFixed(2);
      setState(() {});
    }
  }

  void reset() {
    amountController.clear();
    _selection[0] = true;
    _selection[1] = false;
    _selection[2] = false;
    tipTotal = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        child: Icon(CupertinoIcons.restart),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (tipTotal != null)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "\$$tipTotal",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Total Amount",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: amountController,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '\$100',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                  children: [
                    Text("10%"),
                    Text("15%"),
                    Text("20%"),
                  ],
                  isSelected: _selection,
                  selectedColor: Colors.white,
                  fillColor: Colors.deepOrange,
                  onPressed: (index) {
                    for (int i = 0; i < _selection.length; i++) {
                      _selection[i] = index == i;
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: calculateTip,
                    child: Text("Calculate Tip"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
