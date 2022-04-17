import 'package:audio_session/audio_session_web.dart';
import 'package:just_audio_web/just_audio_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  JustAudioPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
