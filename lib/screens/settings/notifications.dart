import 'package:flutter/material.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/switchComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _newMessage = false;
  bool _newFriendRequest = true;
  bool _writeOnWall = true;
  bool _likeStatus = false;
  bool _comment = false;
  bool _LikeComment = false;
  bool _CommentOnSameStatus = false;
  bool _DisableNotificationForCertainHours = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.w.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send me a push notification when',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter'),
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'I receive a new message',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter'),
                ),
                SwitchComponent(
                  value: _newMessage,
                  onChanged: (bool value) {
                    setState(() {
                      _newMessage = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('I receive a new friend request',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _newFriendRequest,
                  onChanged: (bool value) {
                    setState(() {
                      _newFriendRequest = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Someone writes on my wall',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _writeOnWall,
                  onChanged: (bool value) {
                    setState(() {
                      _writeOnWall = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Someone comments on my status',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _comment,
                  onChanged: (bool value) {
                    setState(() {
                      _comment = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Someone likes my status',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _likeStatus,
                  onChanged: (bool value) {
                    setState(() {
                      _likeStatus = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Someone likes one of my comments',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _LikeComment,
                  onChanged: (bool value) {
                    setState(() {
                      _LikeComment = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Someone comments on a status I have \n commented on',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _CommentOnSameStatus,
                  onChanged: (bool value) {
                    setState(() {
                      _CommentOnSameStatus = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Disable notifications during certain hours',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
                SwitchComponent(
                  value: _DisableNotificationForCertainHours,
                  onChanged: (bool value) {
                    setState(() {
                      _DisableNotificationForCertainHours = value;
                      // TODO: Add your action here
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(211, 234, 240, 1)),
          ],
        ),
      ),
    );
  }
}
