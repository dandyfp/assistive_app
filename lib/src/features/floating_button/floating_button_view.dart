import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:volume_controller/volume_controller.dart';

class FloatingButtonView extends StatefulWidget {
  const FloatingButtonView({super.key});

  @override
  State<FloatingButtonView> createState() => _FloatingButtonViewState();
}

class _FloatingButtonViewState extends State<FloatingButtonView> {
  double volumeListenerValue = 0;
  double getVolume = 0;
  double setvolume = 0;

  @override
  void initState() {
    requestOverlayPermission();
    VolumeController().listener(
      (val) {
        setState(() => volumeListenerValue = val);
      },
    );
    VolumeController().getVolume().then((value) => setvolume = value);
    super.initState();
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  void requestOverlayPermission() async {
    bool isGranted = await FlutterOverlayWindow.isPermissionGranted();
    if (!isGranted) {
      await FlutterOverlayWindow.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return assistiveTouchIcon();
  }

  void goToHome() {
    FlutterOverlayWindow.closeOverlay();
    SystemNavigator.pop();
  }

  Widget assistiveTouchIcon() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => _assistiveMenu(),
        );
      },
      child: Icon(Icons.touch_app),
    );
  }

  /// Assistive Menu for options
  Widget _assistiveMenu() {
    return AlertDialog(
      title: const Text('Assistive Touch'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.volume_up),
            title: const Text('Volume Up'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.volume_down),
            title: const Text('Volume Down'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Go to Home'),
            onTap: () => goToHome(),
          ),
        ],
      ),
    );
  }
}
