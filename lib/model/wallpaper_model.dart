class WallpaperModel {
  final String id;
  final String slug;
  final String altDescription;
  final String imageUrl;
  final String downloadLink;

  WallpaperModel({
    required this.id,
    required this.slug,
    required this.altDescription,
    required this.imageUrl,
    required this.downloadLink,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      id: json['id'],
      slug: json['slug'],
      altDescription: json['alt_description'] ?? '',
      imageUrl: json['urls']['regular'],
      downloadLink: json['links']['download'],
    );
  }
}
