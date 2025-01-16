import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/utils/constents.dart';
import 'package:path/path.dart' as path;

class ApiService {
  final Dio dio = Dio();
  Future<List<WallpaperModel>> getWallpapers(int currentPage) async {
    try {
      final path =
          '$listPhotosUrl${dotenv.env['ACCESS_KEY']!}&page=$currentPage&per_page=10';
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((photo) {
          return WallpaperModel.fromJson(photo as Map<String, dynamic>);
        }).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<String> downloadAndSaveImage(String imageUrl) async {
    await PhotoManager.requestPermissionExtend();
    final Directory? downloadDir = await getExternalStorageDirectory();
    final fileName = '${DateTime.now().microsecondsSinceEpoch}';
    final filePath = path.join(downloadDir!.path, fileName);

    final response = await dio.download(
      imageUrl,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );
    log(response.statusCode.toString());
    final File imageFile = File(filePath);
    final asset = PhotoManager.editor
        .saveImage(await imageFile.readAsBytes(), filename: fileName);
    log(asset.toString());
    return filePath;
  }
}
