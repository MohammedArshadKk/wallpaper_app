import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/utils/constents.dart';

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
}
