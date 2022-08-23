import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NetworkFileViewer extends StatelessWidget {
  const NetworkFileViewer({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  static InAppWebViewController? webView;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            url,
          ),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(),
          ios: IOSInAppWebViewOptions(),
          android: AndroidInAppWebViewOptions(useHybridComposition: true),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
      ),
    );
  }
}
