// HOMEScreen file
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mapfeature_project/helper/constants.dart';
import 'package:mapfeature_project/moodTracer/mood_selector.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';
import 'package:mapfeature_project/screens/ChatScreen.dart';
import 'package:mapfeature_project/moodTracer/graph.dart';

class HOMEScreen extends StatefulWidget {
  final String userId;
  final List<SentimentRecording> moodRecordings;
  final Function(SentimentRecording) onMoodSelected;
  final double selectedMoodPercentage;
  final String token;
  final String? email;
  final String? username;
  final String? name;

  HOMEScreen({
    required this.userId,
    required this.moodRecordings,
    required this.onMoodSelected,
    required this.selectedMoodPercentage,
    required this.token,
    this.email,
    this.username,
    this.name,
  });

  @override
  _HOMEScreenState createState() => _HOMEScreenState();
}

class _HOMEScreenState extends State<HOMEScreen> {
  String userName = '';
  double selectedMoodPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    userName = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                height: 100.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Card(
                  elevation: 4.0,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80.0),
                      topLeft: Radius.circular(80.0),
                    ),
                  ),
                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 30.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello $userName,',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                fontFamily: primaryFont,
                              ),
                            ),
                            const Text(
                              'How are you feeling today ? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: primaryFont,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Image.asset(
                            'images/photo_2024-01-17_04-23-53-removebg-preview.png',
                            width: 140.0,
                            height: 220.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 190,
                left: 30,
                child: MoodSelector(
                  onSelected: widget.onMoodSelected,
                  updateSelectedMood: _updateSelectedMood,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 290, right: 20, left: 20),
                child: MoodGraph(
                  moodData: {'currentDay': selectedMoodPercentage},
                  selectedMoodPercentage: selectedMoodPercentage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 470, right: 10, left: 10),
                child: _buildFeatureList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labelText(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        labelText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          fontFamily: primaryFont,
          color: Color(0xff1F5D6B),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelText('AI Friend'),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatBot(
                  userId: widget.userId,
                  userName: userName,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: primaryColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 6, top: 10, bottom: 4),
                  child: Image.asset(
                    'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                    width: 100,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Text(
                    'How was your Day ?',
                    style: TextStyle(
                        fontFamily: primaryFont,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _labelText('SELF TEST'),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'test');
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: primaryColor,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 70.0),
                  child: Text(
                    'Beck Depression Test',
                    style: TextStyle(
                        fontFamily: primaryFont,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 6, top: 0, bottom: 0),
                  child: Image.asset(
                    'images/photo_2024-01-18_02-56-42-removebg-preview.png',
                    width: 140,
                    height: 160,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _labelText('SELF CARE KIT'),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'recommendation');
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: primaryColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, bottom: 4),
                  child: Image.asset(
                    'images/photo_2024-01-18_02-56-32-removebg-preview.png',
                    width: 100,
                    height: 150,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '100+',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: primaryFont,
                            color: Colors.white),
                      ),
                      Text(
                        'Recommendations',
                        style: TextStyle(
                            fontFamily: primaryFont,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'To Ease Your Mind',
                        style: TextStyle(
                            fontFamily: primaryFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _labelText('TIME KEEPER'),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'Todo');
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: primaryColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, bottom: 4),
                  child: Image.asset(
                    "images/photo_2024-01-18_05-46-33-removebg-preview.png",
                    width: 100,
                    height: 150,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Table Companion',
                        style: TextStyle(
                            fontFamily: primaryFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _updateSelectedMood(double moodPercentage) {
    setState(() {
      selectedMoodPercentage = moodPercentage;
    });
  }
}
