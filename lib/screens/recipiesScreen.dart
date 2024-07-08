import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/recipiesCard.dart';

class RecipesScreen extends StatefulWidget {
  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<dynamic> sections = [];

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('lib/json files/recipies.json');
    final data = await json.decode(response);
    setState(() {
      sections = data['sections'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Recipes',
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FoodSaved()));
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(245, 250, 255, 1),
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return buildSection(sections[index]);
          },
        ),
      ),
    );
  }

  Widget buildSection(section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.w.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section['heading'],
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter'),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ViewMore(heading: section['heading']),
                  //   ),
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 230.h,
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: section['recipes'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: RecipeCard(
                    recipe: section['recipes'][index],
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FoodMood(recipe: section['recipes'][index]),
                      //   ),
                      // );
                    },
                    onSave: (recipe) {
                      // Handle saving logic here
                    },
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
