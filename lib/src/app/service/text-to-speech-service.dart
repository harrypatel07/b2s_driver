
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TextToSpeechService {
  static double volume = 0.8;
  static double pitch = 0.9;
  static double rate = 0.6;
  static FlutterTts flutterTts = FlutterTts()
    ..setVolume(volume)
    ..setSpeechRate(rate)
    ..setPitch(pitch)
;
  dynamic languages;
  String language;
  TextToSpeechService() {

    _getLanguages();
    flutterTts.setStartHandler(() {
      print("playing");
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      ttsState = TtsState.stopped;
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });
  }
  static TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;
  // initTts() {
  //   flutterTts = FlutterTts();

  //   _getLanguages();

  //   flutterTts.setStartHandler(() {
  //     print("playing");
  //     ttsState = TtsState.playing;
  //   });

  //   flutterTts.setCompletionHandler(() {
  //     print("Complete");
  //     ttsState = TtsState.stopped;
  //   });

  //   flutterTts.setErrorHandler((msg) {
  //     print("error: $msg");
  //     ttsState = TtsState.stopped;
  //   });
  // }

  Future _getLanguages() async {
    language = 'vi-VN';
    flutterTts.setLanguage(language);
  }

  static Future speak(String voiceText) async {
    if (voiceText != null) {
      if (voiceText.isNotEmpty) {
        var result = await flutterTts.speak(voiceText);
        if (result == 1) ttsState = TtsState.playing;
      }
    }
  }

  static Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }
}
