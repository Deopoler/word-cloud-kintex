import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return GestureDetector(
        onTap: () {
          getImage(ImageSource.gallery);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(10),
                width: 200,
                child: Column(
                  children: [
                    const Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                        Text(
                          "Upload Image",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: image?.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(snapshot.data!),
            );
          }
        },
      );
    }
  }
}
