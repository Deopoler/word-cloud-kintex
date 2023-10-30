import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAlbumListView extends StatefulWidget {
  final Function selectAlbum;
  const SelectAlbumListView({super.key, required this.selectAlbum});

  @override
  State<SelectAlbumListView> createState() => _SelectAlbumListViewState();
}

class _SelectAlbumListViewState extends State<SelectAlbumListView> {
  var selectedItem = 0;

  final albumList = [
    ['여섯번째 여름', 'PLAVE', ''],
    ['American Idiot', 'Green Day', ''],
    ['Drones', 'Muse', '']
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.separated(
          itemCount: albumList.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = index;
                });
                widget.selectAlbum(selectedItem);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.5,
                    ),
                    color: selectedItem == index ? Colors.blue : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        albumList[index][0],
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: selectedItem == index
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        " ${albumList[index][1]}",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.grey),
                      ),
                      // Image.network(albumList[index][2])
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
