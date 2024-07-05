import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/giftCards.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<dynamic> exploreData = [];
  String selectedCardHeading = '';

  @override
  void initState() {
    super.initState();
    loadExploreData();
  }

  Future<void> loadExploreData() async {
    try {
      String exploreJson =
          await rootBundle.loadString('lib/json files/explore.json');
      setState(() {
        exploreData = json.decode(exploreJson)['cards'];
      });
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  void navigateBasedOnCardHeading(String heading) {
    setState(() {
      selectedCardHeading = heading;
    });

    // Navigate to specific screen based on the selected card heading
    if (selectedCardHeading == 'Recipes') {
      print("Rec");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Screen1()),
      // );
    } else if (selectedCardHeading == 'Heading2') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Screen2()),
      // );
    }
    // Add more conditions as needed for other headings
  }

  @override
  Widget build(BuildContext context) {
    return exploreData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 10.h),
              GridCards(
                cardsData: exploreData,
                onTapCard: navigateBasedOnCardHeading,
              ),
              SizedBox(height: 20.h),
              selectedCardHeading.isNotEmpty
                  ? Text(
                      'Selected Card Heading: $selectedCardHeading',
                      style: TextStyle(fontSize: 18.sp),
                    )
                  : SizedBox.shrink(),
            ],
          );
  }
}
