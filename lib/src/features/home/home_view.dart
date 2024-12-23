import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void showAssistiveTouch() async {
    await FlutterOverlayWindow.showOverlay(
      visibility: NotificationVisibility.visibilityPublic,
      enableDrag: true,
      alignment: OverlayAlignment.centerRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showAssistiveTouch(),
          child: Text('Show assistive'),
        ),
      ),
    );
  }
}
