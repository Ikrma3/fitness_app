import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/excerciseFrame.dart';
import 'package:myfitness/screens/summary.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartTrainingScreen extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final int totalExercises;
  final int totalTime;

  StartTrainingScreen({
    required this.exercises,
    required this.totalExercises,
    required this.totalTime,
  });

  @override
  _StartTrainingScreenState createState() => _StartTrainingScreenState();
}

class _StartTrainingScreenState extends State<StartTrainingScreen> {
  VideoPlayerController? _controller;
  int _currentExerciseIndex = 0;
  int _remainingTime = 0;
  Timer? _exerciseTimer;
  Timer? _totalTimeTimer;
  bool _isPaused = false;
  bool _isVideoInitialized = false;
  late int _totalTime;

  @override
  void initState() {
    super.initState();
    _totalTime = widget.totalTime;
    startNextExercise();
    startTotalTimeTimer();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _exerciseTimer?.cancel();
    _totalTimeTimer?.cancel();
    super.dispose();
  }

  void startNextExercise() async {
    if (_currentExerciseIndex >= widget.exercises.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SummaryScreen()),
      );
      return;
    }

    final exercise = widget.exercises[_currentExerciseIndex];
    final time = exercise['time'];
    final count = exercise['count'];

    if (time != null && time.contains(':')) {
      final timeParts = time.split(':');
      _remainingTime = int.parse(timeParts[0]) * 60 + int.parse(timeParts[1]);
    } else {
      _remainingTime = 5 * 100000000; // Arbitrary time for exercises with count
    }

    if (_controller != null) {
      await _controller!.pause();
      _controller!.dispose();
    }

    try {
      _controller = VideoPlayerController.asset(exercise['video'])
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isVideoInitialized = true;
              _controller!.setLooping(true);
              _controller!.play();
            });
          }
        });
    } catch (e) {
      print("Exception initializing video controller: $e");
    }

    if (_remainingTime > 0) {
      _exerciseTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (_remainingTime > 0 && !_isPaused) {
              _remainingTime--;
            } else if (_remainingTime <= 0) {
              timer.cancel();
              _currentExerciseIndex++;
              startNextExercise();
            }
          });
        }
      });
    } else {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void startTotalTimeTimer() {
    _totalTimeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_totalTime > 0 && !_isPaused) {
            _totalTime--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentExerciseIndex >= widget.exercises.length) {
      return Scaffold(
        body: Center(child: Text('No more exercises')),
      );
    }

    final exercise = widget.exercises[_currentExerciseIndex];
    final nextExerciseIndex = _currentExerciseIndex + 1;
    final hasNextExercise = nextExerciseIndex < widget.exercises.length;
    final nextExercise =
        hasNextExercise ? widget.exercises[nextExerciseIndex] : null;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Exercise ${_currentExerciseIndex + 1}/${widget.totalExercises}',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppin')),
                      Text(formatTime(_totalTime),
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppin',
                            color: AppColors.getSubtitleColor(context),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 359.h,
                  color: Colors.white,
                  child: Center(
                    child: _isVideoInitialized
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
                if (exercise['count'] != null)
                  Column(
                    children: [
                      Text(
                        exercise['count']!,
                        style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppin'),
                      ),
                      Text(
                        exercise['title'] ?? '',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppin'),
                      ),
                      SizedBox(height: 4.0.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Exercise",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppin',
                              color: AppColors.getSubtitleColor(context),
                            ),
                          ),
                        ],
                      ),
                      hasNextExercise
                          ? ExerciseFrame(
                              image: nextExercise!['image'],
                              title: nextExercise['title'],
                              time: nextExercise['time'] != null
                                  ? nextExercise['time']
                                  : nextExercise['count'],
                              onTap: () {},
                            )
                          : Text(
                              "Congratulations It's Last",
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppin'),
                            ),
                    ],
                  )
                else if (exercise['time'] != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      children: [
                        Text(
                          formatTime(_remainingTime),
                          style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppin'),
                        ),
                        Text(
                          exercise['title'] ?? '',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppin'),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Exercise",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppin',
                                  color: Color.fromRGBO(64, 75, 82, 1)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        hasNextExercise
                            ? ExerciseFrame(
                                image: nextExercise!['image'],
                                title: nextExercise['title'],
                                time: nextExercise['time'] != null
                                    ? nextExercise['time']
                                    : nextExercise['count'],
                                onTap: () {},
                              )
                            : Text(
                                "Congratulations It's Last",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppin'),
                              ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 135.w,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isPaused = !_isPaused;
                              if (_isPaused) {
                                _controller?.pause();
                              } else {
                                _controller?.play();
                              }
                            });
                          },
                          child: Text(
                            _isPaused ? 'Resume' : 'Pause',
                            style: TextStyle(
                                color: AppColors.getButtonTextColor(
                                    context), // Text color
                                fontSize: 17.sp,
                                fontFamily: 'Poppin' // Text size
                                ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromRGBO(21, 109, 149, 1),

                            backgroundColor: AppColors.getButtonColor(
                                context), // Text color on the button
                            side: BorderSide(
                                color: Color.fromRGBO(21, 109, 149, 1),
                                width: 1), // Border color and width
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 8.h), // Button padding
                            textStyle: TextStyle(
                              fontSize: 17.sp, // Text size
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 135.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(21, 109, 149, 1),
                              Colors.blue
                            ], // Gradient colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                              22.0.r), // Rounded corners if needed
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller?.pause();
                              _currentExerciseIndex++;
                              startNextExercise();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromRGBO(21, 109, 149, 1),
                            backgroundColor: Colors.transparent, // Text color
                            side: BorderSide(
                              color: Colors.transparent, // Border color
                              width: 0,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 8.h),
                            textStyle: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white // Text size
                                ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  22.0.r), // Match border radius if needed
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 17.sp,
                              fontFamily: 'Poppin',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class PoopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Congratulations')),
      body: Center(child: Text('You have completed all exercises!')),
    );
  }
}
