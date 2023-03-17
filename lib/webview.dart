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
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshController = PullToRefreshController(
        onRefresh: () {
          webViewController!.reload();
        },
        options: PullToRefreshOptions(
          color: Colors.white,
          backgroundColor: Colors.green,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (await webViewController!.canGoBack()) {
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
              child: Stack(
            alignment: Alignment.center,
            children: [
              InAppWebView(
                onLoadStart: (controller, url) {
                  var v = initialUrl;
                  setState(() {
                    isLoading = true;
                    urlController.text = v;
                  });
                },
                onLoadStop: (controller, url) {
                  refreshController!.endRefreshing();
                  isLoading = false;
                },
                onProgressChanged: (controller, progress) {
                  if(progress == 100 ){
                    refreshController!.endRefreshing();
                  }
                  
                  setState(() {
                  this.progress = progress/100;
                  });
                },
                pullToRefreshController: refreshController,
                onWebViewCreated: (controller) =>
                    webViewController = controller,
                initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
              ),
              
              // Visibility(
              //     visible: isLoading,
              //     child: const CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation(Colors.green),
              //     ))
            ],
          ))
        ],
      ),
    );
  }
}
