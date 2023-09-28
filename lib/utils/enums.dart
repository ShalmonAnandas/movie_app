enum TvType {
  movie,
  tv,
  anime,
}

enum MediaType {
  m3u8,
  video,
}

enum MediaQuality {
  unknown(400),
  p_144(144),
  p_240(240),
  p_360(360),
  p_480(480),
  p_720(720),
  p_1080(1080),
  p_1440(1440),
  p_2160(2160);

  final int quality;

  const MediaQuality(this.quality);
}
