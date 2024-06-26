import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_notice_viewer.dart';

class AppNoticeBoard extends StatefulWidget {
  const AppNoticeBoard({Key? key}) : super(key: key);

  @override
  State<AppNoticeBoard> createState() => _AppNoticeBoardState();
}

class _AppNoticeBoardState extends State<AppNoticeBoard> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  late InAppWebViewController _webViewPopupController;

  ReceivePort _port = ReceivePort();

  Future download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage =
          await path_provider.getApplicationDocumentsDirectory();
      await FlutterDownloader.enqueue(
          url: url,
          savedDir: baseStorage.path,
          showNotification: true,
          openFileFromNotification: true);
    }
  }


  void extractPdfLink(String html) {
    final regex = RegExp(r'https?://[^\s]+\.pdf');

    // Find all elements with the class "pg_post"
    final elements = RegExp(r'<div class="pg_post">([\s\S]*?)<\/div>').allMatches(html);

    for (final element in elements) {
      final elementContent = element.group(1);
      if (elementContent != null) {
        final match = regex.firstMatch(elementContent);
        final pdfLink = match?.group(0);
        if (pdfLink != null) {
          print('PDF Link: $pdfLink');
          Navigator.push(context, MaterialPageRoute(builder: (context) => AppNoticePdfViewer(pdfName: pdfLink,)));
        }
      }
    }
  }

  void getData(String urll) async {
    final url = Uri.parse(urll);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final html = utf8.decode(response.bodyBytes);
      extractPdfLink(html);
    } else {
      print('Failed to fetch webpage');
    }
  }

  late String scrapUrl;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                    android: AndroidInAppWebViewOptions(
                      supportMultipleWindows: true,
                      useHybridComposition: true,
                      loadWithOverviewMode: true,
                      useWideViewPort: false,
                      builtInZoomControls: false,
                      domStorageEnabled: true,
                    ),
                    crossPlatform: InAppWebViewOptions(
                      javaScriptCanOpenWindowsAutomatically: true,
                      mediaPlaybackRequiresUserGesture: false,
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled: true,
                      useOnDownloadStart: true,
                    )),
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://narasinhaduttcollege.edu.in/ws/students-notice/")),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                  // controller.addJavaScriptHandler(handlerName: 'openWindow', callback: (args) {
                  //   final url = args.first.toString();
                  //   // Open the URL using the appropriate method (e.g., launch, webview)
                  //   // ...
                  //   final newWebView = InAppWebView(
                  //     initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  //     onDownloadStartRequest: (controller, uri) {
                  //       print("download from");
                  //     },
                  //   );
                  // });
                },
                onLoadResource: (controller, resource) {
                  print("Current URL: ${resource.url}");

                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                shouldOverrideUrlLoading: (controller, action) {
                  final url = action.request.url;
                  print("override: ${url.toString()}");
                  setState(() {
                    scrapUrl = url.toString();
                  });
                  if (url.toString().endsWith(".pdf")) {
                    print("Found");
                  } else {
                    print("Not Founbd");
                  }

                  return Future.value(NavigationActionPolicy.ALLOW);
                },
                onDownloadStartRequest: (controller, uri) {
                  print("download");
                },
                onCreateWindow: (controller, createWindowRequest) async {
                  print("onCreateWindow");
                  getData(scrapUrl);

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       content: Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         height: 400,
                  //         child: InAppWebView(
                  //           // Setting the windowId property is important here!
                  //           windowId: createWindowRequest.windowId,
                  //           initialOptions: InAppWebViewGroupOptions(
                  //             crossPlatform: InAppWebViewOptions(
                  //                 //debuggingEnabled: true,
                  //                 ),
                  //           ),
                  //           onWebViewCreated:
                  //               (InAppWebViewController controller) {
                  //             _webViewPopupController = controller;
                  //           },
                  //           onLoadResource: (controller, resource) {
                  //             print("Current URL: ${resource.url}");
                  //           },
                  //           onLoadStart:
                  //               (InAppWebViewController controller, url) {
                  //             print("onLoadStart popup ${url.toString()}");
                  //           },
                  //           onLoadStop: (InAppWebViewController controller, url) {
                  //             print("onLoadStop popup $url");
                  //           },
                  //           onDownloadStartRequest: (controller, uri) {
                  //             print("download ggg");
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );

                  return true;
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            scrapUrl = ''; // Deinitialize the scrapUrl
          });
          inAppWebViewController.goBack();
        },
      ),
    );
  }
}
