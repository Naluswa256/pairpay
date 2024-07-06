// deep_link_handler.dart
// ignore_for_file: inference_failure_on_untyped_parameter, inference_failure_on_function_invocation, public_member_api_docs

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/reset_password_screen.dart';

class DeepLinkHandler {
  final BuildContext context;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  DeepLinkHandler(this.context);

  void initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }

    // Handle link when app is in warm state (foreground or background)
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          _handleDeepLink(uri);
        }
      },
      onError: (err) {
        debugPrint('Error: $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    if (uri.path == '/reset-password') {
      final token = uri.queryParameters['token'];
      if (token != null) {
        Get.to(() => ResetPasswordScreen(resetpasswordtoken: token));
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
