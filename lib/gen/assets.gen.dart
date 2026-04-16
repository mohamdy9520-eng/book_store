// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Bookmark.svg
  String get bookmark => 'assets/icons/Bookmark.svg';

  /// File path: assets/icons/Home.svg
  String get home => 'assets/icons/Home.svg';

  /// File path: assets/icons/Profile.svg
  String get profile => 'assets/icons/Profile.svg';

  /// File path: assets/icons/cart.svg
  String get cart => 'assets/icons/cart.svg';

  /// File path: assets/icons/close.svg
  String get close => 'assets/icons/close.svg';

  /// File path: assets/icons/farme15.svg
  String get farme15 => 'assets/icons/farme15.svg';

  /// File path: assets/icons/search-normal.svg
  String get searchNormal => 'assets/icons/search-normal.svg';

  /// List of all assets
  List<String> get values => [
    bookmark,
    home,
    profile,
    cart,
    close,
    farme15,
    searchNormal,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/images/Facebook.png');

  /// File path: assets/images/Successmark.svg
  String get successmark => 'assets/images/Successmark.svg';

  /// File path: assets/images/google.png
  AssetGenImage get google => const AssetGenImage('assets/images/google.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// File path: assets/images/splash_android12.png
  AssetGenImage get splashAndroid12 =>
      const AssetGenImage('assets/images/splash_android12.png');

  /// File path: assets/images/visa_icon.svg
  String get visaIcon => 'assets/images/visa_icon.svg';

  /// File path: assets/images/welcome_background.png
  AssetGenImage get welcomeBackground =>
      const AssetGenImage('assets/images/welcome_background.png');

  /// List of all assets
  List<dynamic> get values => [
    facebook,
    successmark,
    google,
    splash,
    splashAndroid12,
    visaIcon,
    welcomeBackground,
  ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/cart_empty.json
  String get cartEmpty => 'assets/lottie/cart_empty.json';

  /// List of all assets
  List<String> get values => [cartEmpty];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
