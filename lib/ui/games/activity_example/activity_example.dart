import 'package:flutter/material.dart';
import 'custom_widgets/letter.dart'; // Import your LetterBox widget
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/return_button.dart';

void main() {
  runApp(const ActivityExampleApp());
}

class ActivityExampleApp extends StatefulWidget {
  const ActivityExampleApp({super.key});

  @override
  _ActivityExampleAppState createState() => _ActivityExampleAppState();
}

class _ActivityExampleAppState extends State<ActivityExampleApp> {
  // List of LetterBox widgets with unique keys
  List<Map<String, dynamic>> letterBoxList = [
    {'key': 'ca', 'widget': const LetterBox(text: 'ca')},
    {'key': 'be', 'widget': const LetterBox(text: 'be')},
    {'key': 'lo', 'widget': const LetterBox(text: 'lo')},
  ];

  // The list for LetterSpace stays intact; it doesn't get removed
  final List<String> letterSpaceKeys = ['ca', 'be', 'lo'];

  @override
  Widget build(BuildContext context) {
    // Define the callback function for when a correct letter is found
    void onCorrectLetterFound(bool correct, String key) {
      if (correct) {
        setState(() {
          // Remove the LetterBox with the matching key
          letterBoxList.removeWhere((item) => item['key'] == key);
        });
      }
    }

    // Create the LetterSpace list (this should not be removed)
    List<LetterSpace> letterSpaceList = letterSpaceKeys.map((key) {
      return LetterSpace(
        expectedLetter: key,
        correctLetterFound: (correct) => onCorrectLetterFound(
            correct, key), // Pass the key with the callback
      );
    }).toList();

    return MaterialApp(
      title: 'LetterBox & LetterSpace Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFAAE0F1),
        body: Flex(direction: Axis.vertical, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(width: 25),
                      ReturnButton(),
                      // Left button],
                    ]),
                    AudioButton(), // Center button
                    SizedBox(width: 80), // Placeholder to ensure spacing
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WordBox(text: ['cabelo']),
                    SizedBox(width: 25),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: letterBoxList
                        .map((item) => item['widget'] as Widget)
                        .toList(),
                    // Display the LetterBox list
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 20.0,
                      // Fixed spacing between items
                      alignment: WrapAlignment.center,
                      // Center items within the Wrap
                      children:
                          letterSpaceList, // Display the LetterSpace list (this remains intact)
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
