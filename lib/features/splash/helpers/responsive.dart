import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  late double _blockSizeHorizontal;
  late double _blockSizeVertical;
  late double _safeAreaHorizontal;
  late double _safeAreaVertical;
  late double _safeBlockHorizontal;
  late double _safeBlockVertical;

  Responsive(this.context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
  }

  // Width percentage
  double wp(double percent) => _blockSizeHorizontal * percent;
  
  // Height percentage
  double hp(double percent) => _blockSizeVertical * percent;
  
  // Safe width percentage
  double swp(double percent) => _safeBlockHorizontal * percent;
  
  // Safe height percentage
  double shp(double percent) => _safeBlockVertical * percent;

  // Screen width
  double get width => _screenWidth;
  
  // Screen height
  double get height => _screenHeight;

  // Check device type
  bool get isMobile => _screenWidth < 600;
  bool get isTablet => _screenWidth >= 600 && _screenWidth < 1200;
  bool get isDesktop => _screenWidth >= 1200;

  // Orientation
  bool get isPortrait => _mediaQueryData.orientation == Orientation.portrait;
  bool get isLandscape => _mediaQueryData.orientation == Orientation.landscape;

  // Text scale factor
  double get textScaleFactor => _mediaQueryData.textScaleFactor;

  // Responsive font size
  double sp(double size) => size * textScaleFactor;
}