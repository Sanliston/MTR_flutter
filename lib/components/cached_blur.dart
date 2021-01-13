import 'dart:typed_data';

import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/scheduler.dart'; //part of blur performance

class CachedFrostedBox extends StatefulWidget {
  CachedFrostedBox(
      {@required this.child,
      this.sigmaX = 8,
      this.sigmaY = 8,
      this.opaqueBackground})
      : this.frostBackground = Stack(
          children: <Widget>[
            ClipRect(
                child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: new Container(
                  height: 2000,
                  decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                  )),
            )),
          ],
        );

  final Widget child;
  final double sigmaY;
  final double sigmaX;

  /// This must be opaque so the backdrop filter won't access any colors beneath this background.
  final Widget opaqueBackground;

  /// Blur applied to the opaqueBackground. See the constructor.
  final Widget frostBackground;

  @override
  State<StatefulWidget> createState() {
    return CachedFrostedBoxState();
  }
}

class CachedFrostedBoxState extends State<CachedFrostedBox> {
  final GlobalKey _snapshotKey = GlobalKey();

  Image _backgroundSnapshot;
  bool _snapshotLoaded = false;
  bool _skipSnapshot = false;

  void _snapshot(Duration _) async {
    final RenderRepaintBoundary renderBackground =
        _snapshotKey.currentContext.findRenderObject();
    final ui.Image image = await renderBackground.toImage(
      pixelRatio: WidgetsBinding.instance.window.devicePixelRatio,
    );
    // !!! The default encoding rawRgba will throw exceptions. This bug is introducing a lot
    // of encoding/decoding work.
    final ByteData imageByteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      _backgroundSnapshot = Image.memory(imageByteData.buffer.asUint8List());
    });
  }

  @override
  Widget build(BuildContext context) {
    print("cached blur called skipsnapshot: $_skipSnapshot");
    Widget frostedBackground;
    if (_backgroundSnapshot == null || _skipSnapshot) {
      print("first if statement");
      frostedBackground = RepaintBoundary(
        key: _snapshotKey,
        child: widget.frostBackground,
      );
      if (!_skipSnapshot) {
        SchedulerBinding.instance.addPostFrameCallback(_snapshot);
      }
    } else {
      print("second if statement");
      // !!! We don't seem to have a way to know when IO thread
      // decoded the image.
      if (!_snapshotLoaded) {
        frostedBackground = widget.frostBackground;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            print("snapshotloaded is now true");
            _snapshotLoaded = true;
          });
        });
      } else {
        print("frostedbackground is now offstage is now true");
        _skipSnapshot = true;
        frostedBackground = Offstage();
      }
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        frostedBackground,
        if (_backgroundSnapshot != null) _backgroundSnapshot,
        GestureDetector(onTap: () {
          setState(() {
            print("skip snapshot? : $_skipSnapshot");

            Navigator.pop(context);
          });
        }),
        widget.child,
      ],
    );
  }
}
