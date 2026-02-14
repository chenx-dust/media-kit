import 'package:flutter/foundation.dart';
import 'package:media_kit_video/media_kit_video.dart';

final configuration = ValueNotifier<VideoControllerConfiguration>(
  const VideoControllerConfiguration(
    vo: 'mediacodec_embed',
    hwdec: 'mediacodec',
    enableHardwareAcceleration: true,
  ),
);
