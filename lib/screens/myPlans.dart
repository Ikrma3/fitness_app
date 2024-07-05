import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:myfitness/components/frame.dart';
import 'package:myfitness/screens/myPlansDetails.dart'; // Updated import
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPlans extends StatefulWidget {
  @override
  _MyPlansState createState() => _MyPlansState();
}

class _MyPlansState extends State<MyPlans> {
  Map<String, dynamic>? plansData;
  late List<bool> activatedPlansSelected;
  late List<bool> recentPlansSelected;

  @override
  void initState() {
    super.initState();
    loadPlansData();
  }

  Future<void> loadPlansData() async {
    final String response =
        await rootBundle.rootBundle.loadString('lib/json files/myPlans.json');
    final data = await json.decode(response);
    setState(() {
      plansData = data;
      activatedPlansSelected =
          List<bool>.filled(data['activatedPlans'].length, false);
      recentPlansSelected =
          List<bool>.filled(data['recentPlans'].length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (plansData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('My Plans')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      body: Column(
        children: [
          Stack(
            children: [
              // Image Container
              Container(
                height: 207.h,
                width: double.infinity,
                child: Image.asset(
                  plansData!['titleImage'],
                  fit: BoxFit.cover,
                ),
              ),
              // Transparent AppBar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  elevation: 0,
                  backgroundColor:
                      Color.fromARGB(60, 0, 0, 0), // Transparent AppBar
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              // Text at the bottom
              Positioned(
                bottom: 10.h, // Adjust this value for spacing
                left: 20.w,
                right: 0,
                child: Text(
                  "My Plans",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text('Activated plans',
                      style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter')),
                ),
                buildPlanList(
                    plansData!['activatedPlans'], activatedPlansSelected),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text('Recent plans',
                      style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter')),
                ),
                buildPlanList(plansData!['recentPlans'], recentPlansSelected),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlanList(List<dynamic> plans, List<bool> selectedList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return Frame(
          image: plan['image'],
          name: plan['name'],
          text: plan['name'],
          subtitle: plan['subtitle'],
          many: true,
          currentSelections: 0,
          isSelected: selectedList[index],
          onChanged: (isChecked) {
            setState(() {
              for (int i = 0; i < selectedList.length; i++) {
                selectedList[i] = false;
              }
              selectedList[index] = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanDetails(selectedPlan: plan),
              ),
            ).then((_) {
              // Reset the selection state when coming back
              setState(() {
                selectedList[index] = false;
              });
            });
          },
        );
      },
    );
  }
}
