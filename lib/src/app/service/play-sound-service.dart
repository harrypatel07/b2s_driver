import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaySoundService {
  static AudioCache audioCache = AudioCache();
  static AudioPlayer advancedPlayer = AudioPlayer();
  static Future play(String path) async {
//    "sound/scannerbeep.mp3"
    advancedPlayer = await audioCache.play(path);
    advancedPlayer.setVolume(0.8);
  }
}
