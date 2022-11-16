import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/providers/test_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<double> prices = [10, 20, 30, 40, 50, 60, 70];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                // Insert buttons to pay for each price
                for (double price in prices)
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () => provider.payNow(price),
                      child: Text('Pay \$${price.toStringAsFixed(2)}'),
                    ),
                  ),
              ],
            ),
            // Add input field to input custom amount
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty || double.tryParse(value) == null) {
                    provider.payNow(0);
                  } else {
                    provider.payNow(double.parse(value));
                  }
                },
              ),
            ),

            Text(
              provider.amount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
