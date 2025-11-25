import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as path;

/// List of sample videos available for playback.
final sources = <String>[];

Future<void> prepareSources() async {
  final uris = [
    'https://github.com/mpvkit/video-test/raw/master/resources/HDR10_ToneMapping_Test_240_1000_nits.mp4',
    'https://github.com/mpvkit/video-test/raw/master/resources/hdr.mkv',
    'https://github.com/mpvkit/video-test/raw/master/resources/HDR10+.mp4',
    'https://github.com/mpvkit/video-test/raw/master/resources/DolbyVision_P5.mp4',
    'https://github.com/mpvkit/video-test/raw/master/resources/DolbyVision_P8.mp4',
    'https://github.com/mpvkit/video-test/raw/master/resources/pgs_subtitle.mkv',
  ];
  final directory = await path.getApplicationSupportDirectory();
  for (int i = 0; i < uris.length; i++) {
    progress.value = 'Downloading sample video ${(i + 1)} of ${uris.length}...';
    final file = File(
      path.join(
        directory.path,
        'media_kit_test',
        uris[i].endsWith('.mkv')
          ? 'video$i.mkv'
          : 'video$i.mp4',
      ),
    );
    if (!await file.exists()) {
      final response = await http.get(Uri.parse(uris[i]));
      if (response.statusCode == 200) {
        await file.create(recursive: true);
        await file.writeAsBytes(response.bodyBytes);
        sources.add(file.path);
      } else {
        i--;
      }
    } else {
      sources.add(file.path);
    }
  }
}

String convertBytesToURL(Uint8List bytes) {
  // N/A
  throw UnimplementedError();
}

final ValueNotifier<String> progress = ValueNotifier<String>(
  'Downloading sample video 1 of 6...',
);
