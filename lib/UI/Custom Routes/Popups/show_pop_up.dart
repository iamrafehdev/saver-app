import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'hero_dialog_route.dart';

Future showPopUp({
  required BuildContext context,
  dynamic data,
  Object heroTag = "",
  bool isRect = false,
  double? left,
  double? top,
  Rect? rect,
  required Widget child,
  EdgeInsets padding = EdgeInsets.zero,
  bool animate = true,
  Size size = const Size(0, 0),
}) {
  // print(rect);
  return Navigator.push(
    context,
    HeroDialogRoute(
      builder: (context) => CustomRoute(
        heroTag: heroTag,
        rect: isRect == true
            ? Rect.fromLTRB(left!, top!, 0, 0)
            : Rect.fromCenter(
                center: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
        padding: padding,
        size: size,
        animate: animate,
        child: child,
      ),
    ),
  );
}

class CustomRoute extends StatefulWidget {
  const CustomRoute({
    Key? key,
    required this.heroTag,
    required this.rect,
    required this.child,
    required this.padding,
    required this.size,
    required this.animate,
  }) : super(key: key);
  final Object heroTag;
  final Rect rect;
  final Widget child;
  final EdgeInsets padding;
  final Size size;
  final bool animate;

  @override
  State<CustomRoute> createState() => _CustomRouteState();
}

class _CustomRouteState extends State<CustomRoute> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  GlobalKey childKey = GlobalKey();
  Size? childSize;
  late Function(dynamic) callBack;
  dynamic valueReturned;
  bool isKeyboaredShow = false;

  @override
  void initState() {
    super.initState();
    callBack = (dynamic value) {
      setState(() {
        valueReturned = value;
      });
    };
    if (widget.child is PopupWidget) {
      (widget.child as PopupWidget).callBack = callBack;
    }
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        if (controller.isDismissed) {
          Navigator.pop(context, valueReturned);
        }
      });
    if (widget.animate) {
      controller.forward();
    }

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   childSize = childKey.size;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.animate) {
          controller.reverse();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: KeyboardVisibilityBuilder(
          builder: (p0, isKeyboardVisible) => Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () => widget.animate ? controller.reverse() : Navigator.pop(context),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: (widget.rect.top + widget.padding.top + widget.size.height - (isKeyboardVisible ? 0 : 0)),
                left: widget.rect.left / 2 + 5,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Hero(
                    tag: widget.heroTag,
                    child: Transform.scale(
                      scale: widget.animate ? controller.value : 1,
                      child: Material(child: SizedBox(key: childKey, child: widget.child)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopupWidget extends StatelessWidget {
  PopupWidget({Key? key}) : super(key: key);
  Function(dynamic)? callBack;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
