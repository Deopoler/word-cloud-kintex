import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  final Function selectImage;
  final Uint8List? priorImage;
  const UploadImage(
      {super.key, required this.selectImage, required this.priorImage});

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

    widget.selectImage(await img?.readAsBytes());
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      if (widget.priorImage == null) {
        return GestureDetector(
          onTap: () {
            getImage(ImageSource.gallery);
          },
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(10),
              width: 170,
              child: Column(
                children: [
                  const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                      Text(
                        "Upload Image",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
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
        );
      } else {
        return GestureDetector(
          onTap: () {
            getImage(ImageSource.gallery);
          },
          child: Image.memory(
            widget.priorImage!,
            height: 170,
          ),
        );
      }
    } else {
      return FutureBuilder(
        future: image?.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Container();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              child: Image.memory(
                snapshot.data!,
                height: 170,
              ),
            );
          }
        },
      );
    }
  }
}
