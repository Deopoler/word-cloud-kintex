import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:word_cloud_kintex/services/wordcloud_service.dart';
import 'package:word_cloud_kintex/widgets/example_image_tabbar_widget.dart';
import 'package:word_cloud_kintex/widgets/select_album_listview_widget.dart';
import 'package:word_cloud_kintex/widgets/upload_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Image? wordcloudImage;
  Uint8List? selectedImage;
  int selectedAlbum = 0;

  Future<Uint8List>? image;

  @override
  void initState() {
    super.initState();
    image = null;
  }

  void selectImage(Uint8List value) {
    selectedImage = value;
  }

  void selectAlbum(int value) {
    selectedAlbum = value;
  }

  void onSubmit() {
    if (selectedImage == null) {
      return;
    }
    print("submit");
    setState(() {
      image = WordCloudService.getWordCloudImage(selectedImage, selectedAlbum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: SizedBox(
          height: 100,
          child: Row(
            children: [
              Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
              Text(
                "소스코드",
                style: GoogleFonts.blackHanSans(fontSize: 40),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Create",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: " your original arts of words",
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const ExampleImageTabBar(),
            UploadImage(selectImage: selectImage, priorImage: selectedImage),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "앨범 선택",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            SelectAlbumListView(
              selectAlbum: selectAlbum,
            ),
            const SizedBox(height: 20),
            FilledButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: onSubmit,
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 50),
            FutureBuilder(
                future: image,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Image.memory(snapshot.data!),
                        const SizedBox(height: 100),
                        TextButton.icon(
                          label: Text(
                            'Share',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.share,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {
                            final file = XFile.fromData(snapshot.data!,
                                mimeType: 'image/png');

                            Share.shareXFiles([file],
                                text:
                                    '자신만의 워드클라우드 생성하기!\nhttps://deopoler.github.io/word-cloud-kintex/');
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Container();
                  }
                }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
