import 'package:flutter/material.dart';

class DisplayImage extends StatefulWidget {
  final image;
  const DisplayImage({this.image});

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf2f2f2),
          iconTheme: IconThemeData(color: Color(0xFF054857)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Image',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.bold, color: Color(0xFFd50e72)),
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: (){

                },
              )
            ],
          ),
        ),

        body: Center(
          child: Image.file(widget.image, fit: BoxFit.cover,),
        )
    );
  }
}
