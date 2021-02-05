import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();

  WebViewScreen({this.url});
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Builder(builder: (BuildContext context) {
          return Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  setState(() {
                    isLoading = true;
                  });
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  setState(() {
                    isLoading = false;
                  });
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              ),
              isLoading ? CustomProgressIndicatorWidget() : Container()
            ],
          );
        }));
  }
}
