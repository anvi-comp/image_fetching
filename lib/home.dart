import 'package:flutter/material.dart';
import 'package:image_fetch/repositories/album.dart';
import 'album.dart';
import 'models/album.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  List<Album> albums = [];

  final AlbumRepository albumRepository = const AlbumRepository();
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    albums = await albumRepository.fetchAlbums();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: albums.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, int index) {
                return const Divider(color: Colors.transparent);
              },
              itemBuilder: (context, int index) {
                // final user =
                //     users.firstWhere((e) => e.id == albums[index].userId);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AlbumPage(
                          albumId: albums[index].id,
                        ),
                      ),
                    );
                  },
                  tileColor: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(albums[index].title),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                );
              },
            ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Anvi Sharma"),
              accountEmail: Text("anvisharma@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_rounded), title: Text("Exit"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
