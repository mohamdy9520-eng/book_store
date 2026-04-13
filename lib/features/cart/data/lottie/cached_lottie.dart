import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class CachedLottie extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;

  const CachedLottie({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  @override
  State<CachedLottie> createState() => _CachedLottieState();
}

class _CachedLottieState extends State<CachedLottie> {
  File? file;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadLottie();
  }

  Future<void> loadLottie() async {
    try {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/${widget.url.hashCode}.json';
      final localFile = File(path);

      if (await localFile.exists()) {
        file = localFile;
      } else {
        final response = await Dio().get(
          widget.url,
          options: Options(responseType: ResponseType.plain),
        );

        await localFile.writeAsString(response.data);
        file = localFile;
      }
    } catch (e) {
      hasError = true;
      debugPrint("Lottie Error: $e");
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError) {
      return const Icon(Icons.error, color: Colors.red);
    }

    if (file != null) {
      return Lottie.file(
        file!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      );
    }

    return const SizedBox();
  }
}