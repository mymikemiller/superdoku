import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:superdoku/game.dart';
import 'selection_row.dart';

void main() {
  runApp(new MyApp());
}

// Support loading the skin image asynchronously
Future<ui.Image> _loadImage(AssetBundleImageKey key) async {
  final ByteData data = await key.bundle.load(key.name);
  if (data == null) throw 'Unable to read data';
  var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  var frame = await codec.getNextFrame();
  return frame.image;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SuperDoku',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  SelectionRow _selectionRow = SelectionRow();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperDoku'),
      ),
      body: FutureBuilder<ui.Image>(
        future: _loadImage(AssetBundleImageKey(
            name: 'images/osx/osx.png',
            bundle: DefaultAssetBundle.of(context),
            scale: 1.0)),
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text('Loading...'));
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Game(tiles: snapshot.data);
              }
          }
        },
      ),
    );
  }
}
