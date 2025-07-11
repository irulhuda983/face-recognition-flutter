import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:absensi/widgets/camera_widget.dart';
import 'package:absensi/pages/absen_success.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class AddAbsensiPage extends StatefulWidget {
  const AddAbsensiPage({Key? key}) : super(key: key);

  @override
  State<AddAbsensiPage> createState() => _AddAbsensiPageState();
}

class _AddAbsensiPageState extends State<AddAbsensiPage> {
  CameraController? _cameraController;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(enableContours: true, enableLandmarks: true),
  );

  bool _canProcess = true;
  bool _isBusy = false;
  bool _isLoading = false;

  bool isDetectFace = false;

  bool? wasLeftEyeOpen;
  bool? wasRightEyeOpen;
  DateTime? lastBlinkTime;
  bool isLivenessVerified = false;

  bool _isCameraInitialized = false;

  String _messageText = '';

  @override
  void initState() {
    super.initState();
    if (!_isCameraInitialized) {
      _isCameraInitialized = true;
    }
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    _cameraController?.dispose();
    super.dispose();
  }

  void checkLiveness(Face face) {
    final left = face.leftEyeOpenProbability;
    final right = face.rightEyeOpenProbability;

    // Pastikan probability tersedia
    if (left != null && right != null) {
      // Cek perubahan dari open -> close -> open (blink)
      if (wasLeftEyeOpen != null && wasRightEyeOpen != null) {
        final leftClosed = wasLeftEyeOpen! && left < 0.4;
        final rightClosed = wasRightEyeOpen! && right < 0.4;

        final leftOpenedBack = left > 0.6;
        final rightOpenedBack = right > 0.6;

        if (leftClosed && rightClosed && leftOpenedBack && rightOpenedBack) {
          // Blink terdeteksi
          final now = DateTime.now();
          if (lastBlinkTime == null || now.difference(lastBlinkTime!) > Duration(seconds: 1)) {
            print("✅ Kedipan terdeteksi! Liveness OK");
            lastBlinkTime = now;
            isLivenessVerified = true;
          }
        }
      }

      // Update previous state
      wasLeftEyeOpen = left > 0.6;
      wasRightEyeOpen = right > 0.6;
    }
  }

  Future<void> _captureAndSaveImage(CameraController controller) async {
    try {
      final XFile file = await controller.takePicture();

      final originalFile = File(file.path);

      // Baca gambar sebagai byte
      final bytes = await originalFile.readAsBytes();

      // Decode ke image
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage == null) return;

      // Flip horizontal
      img.Image flippedImage = img.flipHorizontal(originalImage);

      // Simpan kembali sebagai file baru (atau overwrite)
      final flippedBytes = img.encodeJpg(flippedImage);

      final flippedFile = await originalFile.writeAsBytes(flippedBytes);

      print('📸 Foto terbalik disimpan di: ${flippedFile.path}');

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SuccessAbsenWidget(imagePath: file.path)),
        );
      }
    } catch (e) {
      print('Gagal mengambil gambar: $e');
    }
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    _isBusy = true;

    final faces = await _faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      // if (!mounted) return;
      setState(() {
        isDetectFace = false;
        _messageText = 'Muka tidak ditemukan';
      });
    }

    if (faces.isNotEmpty) {
      if (faces.length == 1) {
        // if (!mounted) return;
        setState(() {
          isDetectFace = true;
          _messageText = 'Muka ditemukan';
        });

        await Future.delayed(Duration(seconds: 2));
        // if (!mounted) return;
        setState(() {
          _messageText = 'Tahan 5 detik untuk absen';
        });

        await Future.delayed(Duration(seconds: 5));
        // if (!mounted) return;
        setState(() {
          _messageText = 'mengabil foto';
        });
        if (_cameraController != null) {
          await _captureAndSaveImage(_cameraController!);
        }
      } else {
        // if (!mounted) return;
        setState(() {
          isDetectFace = false;
          _messageText = 'Pastikan wajah tidak lebih dari 1';
        });
      }
    } else {
      // if (!mounted) return;
      setState(() {
        isDetectFace = false;
        _messageText = 'Wajah tidak ditemukan';
      });
    }

    _isBusy = false;
  }

  Future<void> _onCameraReady() async {
    print('ready');
  }

  void _onCameraController(controller) {
    _cameraController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Presensi')),
      body: Stack(
        children: [
          CameraView(
            onImage: _processImage,
            onCameraFeedReady: _onCameraReady,
            initialCameraLensDirection: CameraLensDirection.front,
            // onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
            // ⬇️ Tambahan:
            onCameraControllerAvailable: _onCameraController,
            isDetectFace: isDetectFace,
            messageText: _messageText,
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
