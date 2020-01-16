import 'dart:io' show Platform;
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TextToSpeechService {
  // static Queue _queue = Queue();
  static double volume = 1;
  static double pitch = 0.9;
  static double rate = 0.6;
  static FlutterTts flutterTts = FlutterTts()
    ..setVolume(volume)
    ..setSpeechRate(rate)
    ..setPitch(pitch)
    ..setLanguage('vi-VN')
    ..setStartHandler(() {
      print("playing");
      ttsState = TtsState.playing;
    })
    ..setCompletionHandler(() async {
      // if (_queue.isNotEmpty) {
      //   var result = await flutterTts.speak(_queue.removeLast().toString());
      //   if (result == 1) ttsState = TtsState.playing;
      // }
      print("Complete");
      _isSpeak = true;
      ttsState = TtsState.stopped;
    })
    ..setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });
  TextToSpeechService();
  static TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  static bool _isSpeak = true;
  static Future speak(String voiceText) async {
    // if (_queue.last != null) {
    //   if (_queue.last.toString().isNotEmpty && ttsState == TtsState.stopped) {
    //     var result = await flutterTts.speak(_queue.removeLast().toString());
    //     if (result == 1) ttsState = TtsState.playing;
    //   }
    // }
    if (Platform.isIOS) return false;
    if (!_isSpeak)
      Future.delayed(const Duration(milliseconds: 200), () {
        speak(voiceText);
      });
    else {
      _isSpeak = false;
      var result = await flutterTts.speak(voiceText);
      if (result == 1) {
        ttsState = TtsState.playing;
      }
    }
  }

  static Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }
}
