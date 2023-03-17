import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tabersa extends StatefulWidget {
  const Tabersa({super.key});

  @override
  State<Tabersa> createState() => _TabersaState();
}

class _TabersaState extends State<Tabersa> {
  WebViewController? _tabersacontroller;

  @override
  void initState() {
    _tabersacontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
              return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {},
      //   ),
      // ),
      body: WebViewWidget(
        controller: _tabersacontroller!,
      ),
    );
  }
}
