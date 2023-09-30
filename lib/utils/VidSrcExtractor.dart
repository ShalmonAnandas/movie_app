import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'ExtractorUtils.dart';
import 'enums.dart';

class VidSrcExtractor {
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/605.1.15 (KHTML, like Gecko) Chrome/118.0.5993.18 Safari/605.1.15';

  static const String proxy = 'custom_proxy';

  static final Dio dio = Dio(
    BaseOptions(
      headers: {'user-agent': userAgent},
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  static Future<String?> extract(String url) async {
    final Response urlResponse = await dio.get(url);

    LinkResponse videoUrl;

    final Document document = parse(urlResponse.data);
    final List<String> servers = [];
    final String? playerUrl = document.querySelector('#player_iframe')?.attributes['src'];
    if (playerUrl == null) {
      return null;
    }

    for (final Element element in document.querySelectorAll('.source')) {
      final String? dataHash = element.attributes['data-hash'];
      if (dataHash != null && dataHash.isNotEmpty) {
        try {
          final Response resp = await dio.get(
            'https://v2.vidsrc.me/srcrcp/$dataHash',
            options: Options(headers: {'referer': 'https://rcp.vidsrc.me/'}),
          );
          servers.add(resp.realUri.toString());
        } catch (e) {
          log(e.toString());
        }
      }
    }
    // log(servers.toString());

    for (final String server in servers) {
      final String fixedLink = server.replaceAll('https://vidsrc.xyz/', 'https://embedsito.com/');
      // log("fixed link $fixedLink");
      if (fixedLink.contains('/prorcp')) {
        final Response srcResp = await dio.get(
          server,
          options: Options(headers: {'referer': 'https://v2.vidsrc.me'}),
        );
        final String respBody = srcResp.data;

        final RegExp m3u8Regex = RegExp(r'((https:|http:)//.*\.m3u8)');

        final String? srcm3u8 = m3u8Regex.stringMatch(respBody);

        final RegExp passRegex = RegExp(r"""['"](.*set_pass[^"']*)""");

        final String? pass = passRegex.firstMatch(respBody)?.group(1)?.replaceAll("^//", 'https://');

        if (pass != null && srcm3u8 != null) {
          videoUrl = LinkResponse(srcm3u8, 'https://vidsrc.stream/', pass, MediaQuality.p_1080,
              title: 'VidSrc', header: {'TE': 'trailers'});
          // log(videoUrl.url);
          return (videoUrl.url);
        }
      } else {
        return null;
      }
    }
  }
}
