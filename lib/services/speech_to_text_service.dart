import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );

    if (isAvailable) {
      _speech.listen(
        partialResults: false,
        localeId: 'en_US',
        onResult: (value) => onResult(value.recognizedWords));
    }
    return isAvailable;
  }

  // is lestening and update the UI
  static bool isListening() {
    return _speech.isListening;
  }

  static void dispose() {
    _speech.stop();
    _speech.cancel();
  }
}