import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webview extends StatefulWidget {
  const Webview({super.key});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  var initialUrl = "http://34.101.95.119/";
  double progress = 0;
  var urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if(await webViewController!.canGoBack()){
              webViewController!.goBack();
            }
          },
        ),
        title: const Text("tabersa"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                webViewController!.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: InAppWebView(
            onWebViewCreated: (controller) => webViewController = controller,
            initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
          ))
        ],
      ),
    );
  }
}
