import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Barang'),
        backgroundColor: Colors.amber,
      ),
      body: WebView(
        initialUrl: "https://foound-mobile.000webhostapp.com/add_page.php",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
