import 'package:flutter/material.dart';

LoadingOverlay showLoadingOverlay(BuildContext context) {
  final loadingOverlay = LoadingOverlay();

  loadingOverlay.show(context);

  return loadingOverlay;
}

class LoadingOverlay {
  LoadingOverlay();

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
