import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cloud_kintex/widgets/example_image_tabbar_widget.dart';
import 'package:word_cloud_kintex/widgets/select_album_listview_widget.dart';
import 'package:word_cloud_kintex/widgets/upload_image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            const UploadImage(),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "앨범 선택",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            const SelectAlbumListView(),
            const SizedBox(height: 20),
            FilledButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
