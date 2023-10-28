import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAlbumListView extends StatelessWidget {
  const SelectAlbumListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "앨범 제목",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
