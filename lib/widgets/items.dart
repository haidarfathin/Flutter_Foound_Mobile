import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foound_app/adddata.dart';
import 'package:foound_app/detailpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Items extends StatefulWidget {
  Items({super.key, required this.list});

  final list;

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Hi, hope you\nfind your lost items',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const Text(
            'Bagikan temuanmu atau cari yang hilang dari dirimu',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black45,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.list == null ? 0 : widget.list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, i) {
              return _buildCard(
                i: i,
                list: [widget.list],
                id: widget.list[i]['id'],
                imgPath: widget.list[i]['gambar'],
                judul: widget.list[i]['nama_barang'],
                tempat: widget.list[i]['area'],
                gambar: widget.list[i]['gambar'],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _buildCard extends StatelessWidget {
  const _buildCard({
    super.key,
    required this.imgPath,
    required this.judul,
    required this.tempat,
    required this.list,
    required this.i,
    required this.gambar,
    required this.id,
  });

  final String imgPath;
  final String judul;
  final String tempat;
  final List list;
  final int i;
  final String gambar;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color.fromRGBO(169, 173, 201, 0.3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: list[i]['id'],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://foound-mobile.000webhostapp.com/data_gambar/" +
                      gambar,
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                judul.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(
              //   height: 2,
              // ),
              Text(
                tempat,
                style: const TextStyle(
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
