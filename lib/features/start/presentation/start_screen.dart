import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

@RoutePage()
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // final PlatformWebViewController _controller = PlatformWebViewController(
  //   const PlatformWebViewControllerCreationParams(),
  // )..loadRequest(
  //   LoadRequestParams(
  //     uri: Uri.parse('http://10.90.138.70:8003'),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    html.window.open('http://10.90.138.70:8003', '_self');
    return Container();
    // return Scaffold(
    //   body: PlatformWebViewWidget(
    //     PlatformWebViewWidgetCreationParams(controller: _controller),
    //   ).build(context),
    // );
  }
}
