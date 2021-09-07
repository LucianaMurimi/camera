import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'gallery.dart';

class Camera extends StatefulWidget {
  final cameras;
  const Camera({this.cameras});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int camera = 0;
  bool flash = false;
  List<File> capturedImages = [];

  //----------------------------------------------------------------------------
  initializeCamera(camera) async{
    _controller = CameraController(widget.cameras[camera], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  //----------------------------------------------------------------------------
  @override
  void initState() {
    initializeCamera(camera);
    super.initState();
  }

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc0c0c0),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              color: Color(0xFFf2f2f2),
              padding: EdgeInsets.only(top: 32, bottom: 2.0, left: 8, right: 8),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  IconButton(
                    icon:   flash ? Icon(Icons.flash_on_sharp, color: Color(0xFF054857), size: 24) :
                    Icon(Icons.flash_off_sharp, color: Color(0xFF054857), size: 24),
                    onPressed: (){
                      setState(() {
                        flash = !flash;
                      });
                      flash ?
                      _controller.setFlashMode(FlashMode.torch) :
                      _controller.setFlashMode(FlashMode.off);
                    },
                  ),
                  Text(
                    'Snappy',
                    style: TextStyle(fontFamily: 'Rosellinda', fontSize: 42.0, color: Color(0xFFd50e72)),
                  ),
                  IconButton(
                    icon:   Icon(Icons.cameraswitch_sharp, color: Color(0xFF054857), size: 24)  ,
                    onPressed: () {
                      // Switch cameras:
                      if (widget.cameras.length > 1) {
                        setState(() {
                          camera = camera == 0 ? 1 : 0;
                          initializeCamera(camera);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('No secondary camera found'),
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
            //------------------------------------------------------------------
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller) ;
                } else {
                  return Container(padding: EdgeInsets.all(100), child: CircularProgressIndicator(color: Color(0xFF054857),), );
                }
              },
            ),
            //------------------------------------------------------------------
          ],
        ),
      ),

      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 28),
              child: IconButton(
                icon: Icon(Icons.collections_sharp, color: Colors.white, size: 24,),
                onPressed: () async {
                  // View pictures:
                  await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Gallery(
                          images: capturedImages.reversed.toList(),
                        ),
                      ));
                },),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                IconButton(
                    icon: Icon(Icons.add,  color: Colors.white, size: 24,),
                    onPressed: (){}),
                IconButton(
                    icon: Icon(Icons.remove, color: Colors.white, size: 24,),
                    onPressed: (){}),
                FloatingActionButton(
                  child: Icon(Icons.camera_alt_sharp),
                  onPressed: () async {
                    // AudioCache cache = AudioCache();
                    // await cache.play("../assets/sounds/click.wav");

                    // Take a picture in a try / catch block:
                    try{
                      await _initializeControllerFuture;
                      var image = await _controller.takePicture();

                      setState(() {
                        capturedImages.add(File(image.path));
                      });

                    }catch(err){
                      print(err);
                    }

                  },
                  backgroundColor: Color(0xFF02232b),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}


