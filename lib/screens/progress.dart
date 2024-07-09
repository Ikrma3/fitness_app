import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/weightStepIndicator.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<dynamic> entries = [];
  Map<String, dynamic> weightData = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final String response =
          await rootBundle.loadString('lib/json files/progress.json');
      final String weightChartJson =
          await rootBundle.loadString('lib/json files/weightChart.json');
      final data = json.decode(response);
      final weightDataJson = json.decode(weightChartJson);

      setState(() {
        entries = data['entries'];
        weightData = weightDataJson;
      });
    } catch (e) {
      // Handle error
      print('Error loading JSON files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/weightIcon.png', height: 50),
                        Text('Weight')
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/date.png', height: 50),
                        Text('Date')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                  // child: CustomGraph(
                  //   heading: weightData['heading'] ?? '',
                  //   subHeading: weightData['subHeading'] ?? '',
                  //   value: weightData['value'] ?? 0,
                  //   date: (weightData['dates'] != null &&
                  //           weightData['dates'].isNotEmpty)
                  //       ? (weightData['dates'].last as String)
                  //       : '',
                  // ),
                  ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Explore', style: TextStyle(fontSize: 24)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(entries[index]['image']),
                  title: Text(entries[index]['date']),
                  subtitle: Text(entries[index]['weight']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
