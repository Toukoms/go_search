import 'dart:math';
import 'package:app/constant.dart';
import 'package:app/heyper.big.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:o_popup/o_popup.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.theme}) : super(key: key);
  final String theme;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  TextToSpeech tts = TextToSpeech();
  bool _speechEnabled = false;
  String _lastWords = '';
  Map? data; // the data from the server
  List<Map<String, String>>? bigData; // the data from the server
  bool isLoading = false;
  String dataToShow = "";

  final random = Random();

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés à l'écran
    int randomInt = random.nextInt(5) + 1;
    bigData = hyperBigData[widget.theme]?['data$randomInt'];
    return Scaffold(
      body: Column(
        children: <Widget>[
          const CustomAppBar(),
          const SizedBox(
            height: 20,
          ),
          _speechToText.isListening
              ? const Text("Listening...")
              : _speechEnabled
                  ? const Text("Tap l'icon micro pour commencer")
                  : const Text("The user has denied the use of speech recognition."),
          Text(_lastWords),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(globalSpacing),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: globalSpacing,
                mainAxisSpacing: globalSpacing,
                children: bigData!
                    .map(
                      (val) => OPopupTrigger(
                        // barrierColor: primaryColor,
                        triggerWidget: ElementSrapped(
                          val: val,
                        ),
                        popupHeader:
                            OPopupContent.standardizedHeader(val['title']!),
                        popupContent: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(val['image'] ?? "https://w7.pngwing.com/pngs/249/19/png-transparent-google-logo-g-suite-google-guava-google-plus-company-text-logo.png"),
                              Text(
                                val['date']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: share, icon: const Icon(Icons.share, color: Colors.white,), tooltip: "partager",),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text("Plus d'info")),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    // Configuration de la détection de silence
    // _speechToText.setSilenceDetection(
    //   minimumSilenceDuration: Duration(seconds: 3),
    //   pauseDetectionDelay: Duration(seconds: 2),
    // );
    _lastWords = '';
    await _speechToText.listen(
        onResult: _onSpeechResult,
        pauseFor: const Duration(seconds: 2),
        cancelOnError: true);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    // if (_speechToText.isNotListening && _lastWords != '') {
    //   // fecth data from server
    //   isLoading = true;
    //   data = await searchIntoWiki(_lastWords);
    //   isLoading = false;

    //   //? print(result);
    //   if (data!["data"]["text"] == "") {
    //     data = await searchIntoGoogle(_lastWords);
    //   } else {
    //     tts.speak(data!['data']['text']);
    //   }
    //   setState(() {});
    // }
  }

  void soundLevelListener(double level) {
    print('Niveau de son : $level');
  }

  void recognitionCompleteListener() {
    // Arrêt de la reconnaissance vocale lorsque la reconnaissance est terminée
    _stopListening();
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Example share',
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title'
    );
  }
}

class ElementSrapped extends StatelessWidget {
  const ElementSrapped({
    Key? key,
    this.val,
  }) : super(key: key);
  final val;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(globalSpacing),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(globalPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Image.network(
          //     "https://w7.pngwing.com/pngs/817/902/png-transparent-google-logo-google-doodle-google-search-google-company-text-logo-thumbnail.png"),
          Text(val['title']!,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),),
              Image.network(val['logo']!),
          Text(val['date']!, style: const TextStyle(color: Colors.white38),),

        ],
      ),
    );
  }
}