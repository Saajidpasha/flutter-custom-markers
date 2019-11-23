import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/my_painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<MarkerId, Marker> _markers = Map();

  final _initialCameraPosition =
      CameraPosition(target: LatLng(-0.1865934, -78.4655612), zoom: 14);

  _onTap(LatLng position) async {
    final markerId = MarkerId(_markers.length.toString());

    final bytes = await _myPainterToBitmap(position.toString());

    final marker = Marker(
        markerId: markerId,
        position: position,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(bytes));

    setState(() {
      _markers[markerId] = marker;
    });
  }

  Future<Uint8List> _myPainterToBitmap(String label) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    MyPainter myPainter = MyPainter(label);
    myPainter.paint(canvas, Size(400, 100));

    final ui.Image image = await recorder.endRecording().toImage(400, 100);
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0099aa),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        markers: Set.of(_markers.values),
        onTap: _onTap,
      ),
    );
  }
}
