import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String nama = '';
  String desc = '';
  String area = '';
  String gambar = '';
  String kontak = '';
  String waktu = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://foound-mobile.000webhostapp.com/detail.php?id=${widget.id}"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          nama = data['nama_barang'];
          desc = data['desc_barang'];
          area = data['area'];
          gambar = data['gambar'];
          kontak = data['kontak'];
          waktu = data['tanggal'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Barang"),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4527A0),
            fixedSize: Size(MediaQuery.of(context).size.width, 50),
          ),
          onPressed: () async {
            Uri url = Uri.parse("https://wa.me/$kontak");
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              const snackbar = SnackBar(content: Text('something went wrong'));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Text(
            "Hubungi Penemu",
            style: GoogleFonts.poppins(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://foound-mobile.000webhostapp.com/data_gambar/$gambar",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              nama,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              desc,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Divider(
              thickness: 1,
            ),
            RichText(
              text: TextSpan(
                text: 'Ditemukan di ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: area,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              waktu,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.deepPurple.shade800,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
