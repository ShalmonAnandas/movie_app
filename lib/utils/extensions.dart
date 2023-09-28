import 'enums.dart';

extension MediaQualityExtension on MediaQuality {
  static MediaQuality fromString(final String? string) {
    if (string == null) {
      return MediaQuality.unknown;
    }

    return MediaQuality.values
        .firstWhere((element) => element.quality.toString() == string, orElse: () => MediaQuality.unknown);
  }
}
