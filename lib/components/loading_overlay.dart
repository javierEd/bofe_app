import 'package:flutter/material.dart';

LoadingOverlay showLoadingOverlay(BuildContext context) {
  final loadingOverlay = LoadingOverlay._instance();

  loadingOverlay.show(context);

  return loadingOverlay;
}

class LoadingOverlay {
  LoadingOverlay();

  factory LoadingOverlay._instance() => LoadingOverlay();

  final _overlay = OverlayEntry(
    builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(child: CircularProgressIndicator()),
      );
    },
  );

  void show(BuildContext context) {
    Overlay.of(context).insert(_overlay);
  }

  void hide() {
    _overlay.remove();
  }
}
