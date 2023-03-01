import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  Rect get location {
    final renderObject = currentContext?.findRenderObject() as RenderBox;
    Offset? offset = renderObject.localToGlobal(Offset.zero);
    // if (offset != null) {
    return Rect.fromLTRB(offset.dx, offset.dy, 0, 0);
    // } else {
    //   return Rect.zero;
    // }
  }

  Size get size {
    final renderObject = currentContext?.findRenderObject() as RenderBox;
    return renderObject.size;
  }

  // Rect get location {
  //   final renderObject = currentContext?.findRenderObject();
  //   final translation = renderObject?.getTransformTo(null).getTranslation();
  //   if (translation != null) {
  //     return renderObject!.paintBounds
  //         .shift(Offset(translation.x, translation.y));
  //   } else {
  //     return Rect.zero;
  //   }
  // }
}
