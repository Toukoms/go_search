import 'package:app/constant.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:app/request.dart';

import 'components/custom_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SpeechToText _speechToText = SpeechToText();
  TextToSpeech tts = TextToSpeech();
  bool _speechEnabled = false;
  String _lastWords = '';
  Map? data; // the data from the server
  bool isLoading = false;

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    // setState(() {});
  }

  void _startListening() async {
    setState(() {
      _lastWords = '';
    });
    await _speechToText.listen(
        onResult: _onSpeechResult, pauseFor: const Duration(seconds: 2));
    // setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    if (_speechToText.isNotListening && _lastWords != '') {
      // fecth data from server
      isLoading = true;
      data = await searchIntoWiki(_lastWords);
      isLoading = false;

      //? print(result);
      if (data!["data"]["text"] == "") {
        data = await searchIntoGoogle(_lastWords);
      } else {
        tts.speak(data!['data']['text']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Speech Demo'),
      // ),
      body: Column(
        children: <Widget>[
          CustomAppBar(),
          _speechToText.isListening
              ? Text("Listening...")
              : Text("Tap to begin listening"),
          Text(_lastWords),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(globalPadding),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: globalSpacing,
                mainAxisSpacing: globalSpacing,
                children: actuality
                    .map((val) => Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(94, 134, 128, 128),
                            borderRadius: BorderRadius.circular(globalPadding)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(val['title']!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        )))
                    .toList(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
