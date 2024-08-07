import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myfitness/components/colours.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> profileData = {};
  final ImagePicker _picker = ImagePicker();
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    String jsonString =
        await rootBundle.loadString('lib/json files/profile.json');
    setState(() {
      profileData = json.decode(jsonString);
      profileImage = profileData['profile_image'];
    });
  }

  Future<void> saveProfileData() async {
    // Save the profileData map to the JSON file
    // You need to implement file write operation to save the data
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // setState(() {
        //   profileData['profile_image'] = image.path;
        // });
        // saveProfileData();
      }
    } catch (e) {
      print('Image picker error: $e');
    }
  }

  Future<void> _editField(String field) async {
    TextEditingController controller =
        TextEditingController(text: profileData[field]);
    String? newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: field),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );

    if (newValue != null) {
      setState(() {
        profileData[field] = newValue;
      });
      saveProfileData();
    }
  }

  Future<void> _editDateField(String field) async {
    DateFormat dateFormat = DateFormat(
        'MMM d, yyyy'); // Adjust this format to match your date string
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateFormat
          .parse(profileData[field]), // Convert the date string to DateTime
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        profileData[field] =
            dateFormat.format(pickedDate); // Convert DateTime back to string
      });
      saveProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (profileData.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppin'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0.w.h),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: profileData['profile_image'] != null
                            ? (profileData['profile_image']
                                    .startsWith('assets/images/')
                                ? AssetImage(profileData['profile_image'])
                                : FileImage(File(profileData['profile_image']))
                                    as ImageProvider)
                            : AssetImage(profileImage),
                      ),
                      Positioned(
                        bottom: 9,
                        right: 4,
                        child: Container(
                          height: 26.w,
                          width: 26.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Color.fromRGBO(21, 109, 149, 1)),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: -6,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 14.w.h,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    profileData['name'] ?? 'No Name',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ProfileItem(
                        imagePath: 'assets/icons/icon_weight.png',
                        text: profileData['weight'] ?? 'N/A',
                      ),
                      ProfileItem(
                        imagePath: 'assets/icons/icon_person.png',
                        text: profileData['height_cm'] ?? 'N/A',
                      ),
                      ProfileItem(
                        imagePath: 'assets/images/cake.png',
                        text: profileData['age'] ?? 'N/A',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.ContainergetGradient(context),
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.h),
              child: Text('Profile',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 109, 149, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter')),
            ),
            Container(
              color: AppColors.getBackgroundColor(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    buildProfileItem('Name', profileData['name'] ?? 'N/A',
                        () => _editField('name')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem(
                        'Height',
                        profileData['height_ft_in'] ?? 'N/A',
                        () => _editField('height_ft_in')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Sex', profileData['sex'] ?? 'N/A',
                        () => _editField('sex')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem(
                        'Date of Birth',
                        profileData['date_of_birth'] ?? 'N/A',
                        () => _editDateField('date_of_birth')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    Row(
                      children: [
                        Text('Location',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                fontFamily: 'Inter')),
                        Spacer(),
                        Text(profileData['location'],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                fontFamily: 'Inter'))
                      ],
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    Row(
                      children: [
                        Text('Time Zone',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                fontFamily: 'Inter')),
                        Spacer(),
                        Text(profileData['time_zone'],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                fontFamily: 'Inter'))
                      ],
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Units', profileData['units'] ?? 'N/A',
                        () => _editField('units')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Email', profileData['email'] ?? 'N/A',
                        () => _editField('email')),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String label, String value, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'Inter'),
              ),
              Row(
                children: [
                  Text(value,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String imagePath;
  final String text;

  const ProfileItem({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      height: 76.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: AppColors.getGradient(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath, width: 30.w, height: 30.h),
          SizedBox(height: 4.h),
          Text(
            text,
            style: TextStyle(fontSize: 14.sp, fontFamily: 'Poppin'),
          ),
        ],
      ),
    );
  }
}
