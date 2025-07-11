import 'package:flutter/material.dart';
import 'dart:io';
import 'package:absensi/pages/home_page.dart';

class SuccessAbsenWidget extends StatefulWidget {
  const SuccessAbsenWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<SuccessAbsenWidget> createState() => _SuccessAbsenState();
}

class _SuccessAbsenState extends State<SuccessAbsenWidget> {
  void pushToCamera() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification')),
      body: Column(
        children: [
          SizedBox(width: double.infinity, child: Text('Berhasil Absen')),
          Image.file(File(widget.imagePath)),
          ElevatedButton(onPressed: pushToCamera, child: Text('Kembali')),
        ],
      ),
    );
  }
}
