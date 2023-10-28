import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cloud_kintex/widgets/example_image_tabbar_widget.dart';
import 'package:word_cloud_kintex/widgets/upload_image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: SizedBox(
          height: 200,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
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
              const SizedBox(height: 20),
              const UploadImage(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
