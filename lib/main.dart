import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:ui' as ui;

const htmlData = r"""
<html>
<p id='top'>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}
</style>
</head>
<body>

<center>Lidl Hrvatska d.o.o. k.d.</center></div>
<center>Velika Gorica,</center>
<center>Ulica kneza Ljudevita Posavskog 53</center>
<center>OIB: 66089976432, PJ: 0114</center>
<center>Zagrebačka 49f, Sisak</center>

<p style="text-align:right;">kn</p>

<div style="overflow-x:auto;">
  <table>
    <tr>
      <th>Čokoladni donut</th>
      <th>7,98</th>
    </tr>
    <tr>
      <th>Maslinovo ulje</th>
      <th>40,50</th>
    </tr>
	  <tr>
      <th>Voda</th>
      <th>6,55</th>
    </tr>
  </table>
</div>
<p>---------------------------------------------------------------------------------------------------</p>
<div style="overflow-x:auto;">
  <table>
    <tr>
      <th>Ukupno:</th>
      <th>7,98</th>
    </tr>
  </table>
</div>
<div style="overflow-x:auto;">
  <table>
    <tr>
      <th>JIR:</th>
      <th>a3f6f688-3fd5-434a-8d8f-3685a48a36f7</th>
    </tr>
    <tr>
      <th>ZKI:</th>
      <th>9f2242a21a546c74cb4e00c24aba5f79</th>
    </tr>
  </table>
</div>
<center>www .lidl.hr</center>
</body>
</html>
             
       
""";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Scan barcode and QR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _globalKey = new GlobalKey();

  String htmlClosingString = "</body></html>";


  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
      _globalKey.currentContext.findRenderObject();
      // if it needs repaint, we paint it.
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => _capturePng());
        return null;
      }

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: _globalKey,
      child: new Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Center(
          child:new Column(
            children: <Widget>[
           Html(
            data: htmlData,
            customTextAlign: (_) => TextAlign.right,
          ),
              new Text(
                'click below given button to capture iamge',
              ),
              new RaisedButton(
                child: Text('capture Image'),
                onPressed: _capturePng,
              ),
            ],
         ),
        ),
      )

    );
  }

}


