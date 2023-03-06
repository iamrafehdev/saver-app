import 'package:flutter/material.dart';
import 'package:req_fun/req_fun.dart';
import 'package:saver/Utils/app_theme.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/app_text.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String webpage = "";

  WebViewController? controller;

  @override
  void initState() {
    webpage = "https://www.depreciate.app";

    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              pop();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.PrimaryColor)),
        title: AppText("Customer support"),
      ),
      body: WebViewWidget(controller: controller!),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: AppText(
      //         "We are located on the high street of Pershore town within Worcestershire County in a grade II listed building. The practice enjoys free parking within the surrounding area and easy accessible transport links. We aim to provide a wide range of dental treatments in a welcoming, friendly and safe environment, giving you the utmost confidence in your dental health and smile. ​ We pride ourselves on accommodating various appointment requests including weekends and late evenings. We also offer daily emergency dental appointments, in addition to out-of-hours dental emergency advice and appointments by special arrangements. ​ You can find out more by exploring our website and if you have any queries, we are only a click away. ​ We are all aware that a trip to the dentist can be quite expensive, but at Pershore Smiles we are able to offer a practice plan that would make your dental care convenient and affordable.",
      //         size: 14,
      //         color: Colors.grey[700],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: AppText(
      //         "We are located on the high street of Pershore town within Worcestershire County in a grade II listed building. The practice enjoys free parking within the surrounding area and easy accessible transport links. We aim to provide a wide range of dental treatments in a welcoming, friendly and safe environment, giving you the utmost confidence in your dental health and smile. ​ We pride ourselves on accommodating various appointment requests including weekends and late evenings. We also offer daily emergency dental appointments, in addition to out-of-hours dental emergency advice and appointments by special arrangements. ​ You can find out more by exploring our website and if you have any queries, we are only a click away. ​ We are all aware that a trip to the dentist can be quite expensive, but at Pershore Smiles we are able to offer a practice plan that would make your dental care convenient and affordable.",
      //         size: 14,
      //         color: Colors.grey[700],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  initController() {
    controller = WebViewController()
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
      ..loadRequest(Uri.parse(webpage));
  }
}
