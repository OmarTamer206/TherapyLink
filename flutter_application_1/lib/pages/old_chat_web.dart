import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: undefined_prefixed_name
import 'dart:ui' as ui;

class OldChatWeb extends StatefulWidget {
  final dynamic sessionData;
  final String chatId;
  final String userId;

  const OldChatWeb({
    Key? key,
    required this.sessionData,
    required this.chatId,
    required this.userId,
  }) : super(key: key);

  @override
  State<OldChatWeb> createState() => _OldChatWebState();
}

class _OldChatWebState extends State<OldChatWeb> {
  late final html.IFrameElement _iframeElement;

  @override
  void initState() {
    super.initState();

    _iframeElement = html.IFrameElement()
      ..src = 'http://localhost:4200/old-chat/${widget.chatId}/${widget.userId}'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'chat-web-iframe',
      (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Scaffold(
        body: Center(child: Text('This view is only supported on Flutter Web.')),
      );
    }

    return HtmlElementView(viewType: 'chat-web-iframe');
  }
}
