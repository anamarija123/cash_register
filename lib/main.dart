import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

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
  String _scannedValue, _contentReceiverId = "";

  String htmlOpeningString = "<!DOCTYPE html><html><body>";
 // String htmlContentString =
 //     "<h1>An H1 Heading</h1><p>This is a paragraph. Cillum excepteur aliquip nisi ex enim ut occaecat.</p><img src='https://flutter.dev/images/flutter-logo-sharing.png'>";

  String htmlContentString =
      " <center>Lidl Hrvatska d.o.o. k.d.</center>"
      "</div><center>Velika Gorica,</center> "
      "<center>Ulica kneza Ljudevita Posavskog 53</center>"
      " <center>OIB: 66089976432, PJ: 0114</center> "
      "<center>Zagrebačka 49f, Sisak</center>";
  String htmlClosingString = "</body></html>";
  String normalText = "This is normal flutter text widget!";

  Future _scanBarcode() async {
    _scannedValue = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancel", true, ScanMode.DEFAULT);

    setState(() {
      _contentReceiverId = _scannedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Html(
              data: htmlOpeningString +
                  htmlContentString +
                  htmlClosingString, //html string to be parsed

                  useRichText: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  defaultTextStyle: TextStyle(fontSize: 14),
                  imageProperties: ImageProperties(
                    //formatting images in html content
                    height: 150,
                    width: 150,
                  ),

                  onImageTap: (src) {
                    setState(() {
                      normalText = 'You just clicked on the flutter logo!';
                    });
                  },
                onLinkTap: (url) {
                  // open url in a webview
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(normalText),
            Text(
              'Content receiver ID:',
            ),
            Text(
              _contentReceiverId,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarcode,
        tooltip: 'Increment',
        child: Icon(Icons.settings_overscan),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _createHtml() async {
    const htmlData = r"""
     <body>  
      <center>Lidl Hrvatska d.o.o. k.d.</center></div>
      <center>Velika Gorica,</center>
      <center>Ulica kneza Ljudevita Posavskog 53</center>
      <center>OIB: 66089976432, PJ: 0114</center>
      <center>Zagrebačka 49f, Sisak</center>
    
      <p style="text-align:right;">kn</p>
      
      <div class="row">
        <div class="column"></div>
        <div class="column"></div>
      </div>
    
     </body>
    """;
  }




}


