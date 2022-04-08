import 'package:flutter/material.dart';
import 'package:image_fetch/photo.dart';
import 'package:image_fetch/repositories/album.dart';
import 'package:image_fetch/repositories/photos.dart';

import 'models/album.dart';
import 'models/photo.dart';

class AlbumPage extends StatefulWidget {
  final int albumId;
  const AlbumPage({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final PhotosRepository photosRepository = const PhotosRepository();
  final AlbumRepository albumRepository = const AlbumRepository();
  bool isLoading = true;
  Album? album;
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    album = await albumRepository.albumById(widget.albumId);
    photos = await photosRepository.photosByAlbum(album!.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhotoPage(photoId: photos[index].id!),
                      ),
                    );
                  },
                  child: Card(
                    child: GridTile(
                      child: Image.network(
                        photos[index].thumbnailUrl!,
                      ), //just for testing, will fill with image later
                    ),
                  ),
                );
              },
            ),
    );
  }
}
