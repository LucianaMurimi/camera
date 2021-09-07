import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'display_image.dart';

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Gallery extends StatefulWidget {
  final images;
  const Gallery({this.images});

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<bool> selected = [];

  @override
  void initState() {
    for(int i = 0; i < widget.images.length; i++){
      selected.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),

      appBar: AppBar(
        backgroundColor: Color(0xFFf2f2f2),
        iconTheme: IconThemeData(color: Color(0xFF054857)),
        title: Text(
          'Pictures',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.bold, color: Color(0xFFd50e72)),
        ),
      ),

      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,

        children: <Widget>[
          for(int i = 0; i < widget.images.length; i++)

            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                    border: selected[i] == true ? Border.all(color: Color(0x80d50e72), width: 2.8, style: BorderStyle.solid) :
                      Border.all(style: BorderStyle.none),
                  ),
                  child: Image.file(widget.images[i], fit: BoxFit.cover,)),
              onTap: () async {
                // View pictures:
                await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayImage(
                        image: widget.images[i],
                      ),
                    ));
              },
              onLongPress: (){
                selected[i] = !selected[i];
                setState(() {

                });
              },
            )

        ],
      ),
    );

  }
}
