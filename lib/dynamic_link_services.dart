import 'package:dynamic_link_app/post_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import 'invitation_screen.dart';

class DynamicLinkServices {
  DynamicLinkServices._();
  static final DynamicLinkServices instance = DynamicLinkServices._();
  FirebaseDynamicLinks _dynamicLinks = FirebaseDynamicLinks.instance;
  Logger _loger = Logger();

  // Future<void>? initDynamicLinks() {
  //   _dynamicLinks.onLink.listen((dynamicLinkData) {
  //     _handleDeepLink(dynamicLinkData);
  //   }).onError((error) {
  //     _loger.e("onlink error");
  //     print(error.message);
  //   });
  // }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri deepLink = data!.link;
    if (deepLink != null) {
      print('_handleDeepLink | DeepLink ${deepLink}');
      var isPost = deepLink.pathSegments.contains('post');
      var isInvitation = deepLink.pathSegments.contains('invite');
      if (isPost) {
        var id = deepLink.queryParameters['id'];

        if (id != null) {
          Get.to(() => PostScreen(
                title: id,
              ));
        }
      } else if (isInvitation) {
        var id = deepLink.queryParameters['id'];

        if (id != null) {
          Get.to(() => InvitationScreen(
                title: id,
              ));
        }
      }
    }
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      // If the app is not opened, getInitialLink() is called.
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        _handleDeepLink(data);
      }

// we open the app by the click of a dynamic link, onLink() will be called.
      _dynamicLinks.onLink.listen((dynamicLinkData) {
        _handleDeepLink(dynamicLinkData);
      });
    } catch (e) {
      print(e.toString());
    }
  }






  Future<String> createDynamicLink(String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://abddynamic.page.link',
      link: Uri.parse('https://abdapp.com/post?title=$title'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.dynamic_link_app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.dynamicLinkApp',
        minimumVersion: '0',
      ),
    );
    // final Uri dynamicUrl = await _dynamicLinks.buildLink(parameters);

    final ShortDynamicLink shortLink =
        await _dynamicLinks.buildShortLink(parameters);
    Uri url = shortLink.shortUrl;
    print(url.toString());
    return url.toString();
  }

  Future<String> buildDynamicLink(String title, String image, String docId, String type,{context}) async {
    String url = 'https://abddynamic.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('https://abdapp.com/$type?id=$docId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.dynamic_link_app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.dynamicLinkApp',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(image),
        title: title,
        description: 'this is descriprion',
      ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        campaign: 'promo',
        medium: 'social',
        source: 'Kanara',
      ),
      itunesConnectAnalyticsParameters: const ITunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'promo',
      ),
    );


// crete short link
    final ShortDynamicLink shortLink =
        await _dynamicLinks.buildShortLink(parameters);
    String? desc = '${shortLink.shortUrl}';

// share this link to your friends
    await share(title: title, desc: desc);
    return url.toString();
  }

  share({String? title, String? desc}) async {
    await Share.share(
      desc!,
      subject: title,
    );
  }
}
