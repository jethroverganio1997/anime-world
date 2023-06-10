import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:animenginamo/config/theme/color_schemes.g.dart';

import '../exceptions/error_exception.dart';

final imageThemeProvider = StateNotifierProvider<ImageTheme, ColorScheme>(
  (ref) => ImageTheme(),
);

class ImageTheme extends StateNotifier<ColorScheme> {
  ImageTheme() : super(darkColorScheme);

//   Future<List<int>?> _imageToPixels(String path) async {
//     try {
//       final data = await File(path).readAsBytes();

//       final decoder = img.JpegDecoder();
//       final decodedImg = decoder.decode(data);
//       final bytes = decodedImg!.getBytes(order: img.ChannelOrder.rgb);
//       //   final bytes = image!.getBytes(order: img.ChannelOrder.rgb);
//       final pixels = <int>[];
//       for (var i = 0; i < bytes.length; i += 3) {
//         pixels.add(img.getLuminanceRgb(bytes[i], bytes[i + 1], bytes[i + 2]).toInt());
//       }
//       return pixels;
//     } catch (e) {
//       debugPrint(e.toString());
//       throw ErrorDetails(error: 'Failed to convert an image to pixels', description: e.toString());
//     }
//   }

//   Future<List<Color>?> _sourceColorsFromImage(String path) async {
//     try {
//       final pixels = await _imageToPixels(path);
//       final result = await QuantizerCelebi().quantize(pixels!, 128);
//       final ranked = Score.score(result.colorToCount);
//       return ranked.map((e) => Color(e)).toList();
//     } catch (e) {
//       debugPrint(e.toString());
//       throw ErrorDetails(error: 'Failed to convert an image to source color', description: e.toString());
//     }
//   }

  Future<PaletteGenerator> _paletteGenerator(String imagePath) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(imagePath).image,
    );
    return paletteGenerator;
  }

//   Future<String> _downloadUrlImage(String urlLink) async {
//     try {
//       // Download image
//       final http.Response response = await http.get(Uri.parse(urlLink));
//       // Get temporary directory
//       final dir = await getApplicationDocumentsDirectory();
//       // Create an image name
//       final filename = '${dir.path}/image_theme.jpg';
//       // Save to filesystem
//       final file = File(filename);
//       await file.writeAsBytes(response.bodyBytes);
//       return file.path;
//     } catch (e) {
//       debugPrint(e.toString());
//       throw ErrorDetails(error: 'Failed to download network image', description: e.toString());
//     }
//   }

  Future<ColorScheme> colorSchemeFromImage({
    required ColorScheme base,
    required String urlLink,
  }) async {
    try {
      //final localPath = await _downloadUrlImage(urlLink);
      final colors = await _paletteGenerator(urlLink);
      final color = colors.dominantColor!.color;

      final scheme = ColorScheme.fromSeed(seedColor: color, brightness: base.brightness);
      state = scheme;
      return scheme;
    } catch (e) {
      debugPrint(e.toString());
      throw ErrorDetails(error: 'Failed to convert an image to color scheme', description: e.toString());
    }
  }
}
