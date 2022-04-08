import 'package:dio/dio.dart';
import 'package:image_fetch/models/photo.dart';
import '../constants.dart';

class PhotosRepository {
  const PhotosRepository();
  static final Dio dio = Dio();

  Future<Photo> photoById(int photoId) async {
    final response = await dio.get("${Constants.photosApi}/$photoId");
    return Photo.fromMap(response.data);
  }


  Future<List<Photo>> photosByAlbum(int albumId) async {
    final response = await dio.get("${Constants.photosApi}?albumId=$albumId");
    final photos = List.generate(
      response.data.length,
      (int index) => Photo.fromMap(response.data[index]),
    );
    return photos;
  }
}
