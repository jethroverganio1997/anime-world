import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/router.dart';
import '../common_widgets/dialogs.dart';
import '../enums/alert_type.dart';
import '../models/request.dart';
import '../models/response.dart';

final dialogServiceProvider = Provider.autoDispose<DialogService>(
  (ref) => DialogService(ref.watch(routerProvider)),
);

typedef _DialogBuilder = Widget Function(BuildContext, DialogRequest);

class DialogService {
  DialogService(this._goRouter);
  final GoRouter _goRouter;

  final Map<dynamic, _DialogBuilder> _dialogBuilders = {
    DialogType.basic: (context, request) => BasicDialog(request: request),
  
  };

  Future<DialogResponse?> error<T extends Object>(
    String description, {
    String? title,
    String? mainButtonTitle,
  }) async {
    return showDialog<DialogResponse>(
      barrierDismissible: false,
      context: _goRouter.routerDelegate.navigatorKey.currentContext!,
      builder: (BuildContext context) => BasicDialog(
        request: DialogRequest(
          title: title,
          description: description,
          mainButtonTitle: mainButtonTitle,
          alertType: AlertType.error,
        ),
      ),
    );
  }

  Future<DialogResponse?> success<T extends Object>(
    String description, {
    String? title,
    String? mainButtonTitle,
  }) async {
    return showDialog<DialogResponse>(
      barrierDismissible: false,
      context: _goRouter.routerDelegate.navigatorKey.currentContext!,
      builder: (BuildContext context) => BasicDialog(
        request: DialogRequest(
          title: title,
          description: description,
          mainButtonTitle: mainButtonTitle,
          alertType: AlertType.success,
        ),
      ),
    );
  }

  Future<DialogResponse?> info<T extends Object>(
    String description, {
    String? title,
    String? mainButtonTitle,
  }) async {
    return showDialog<DialogResponse>(
      barrierDismissible: false,
      context: _goRouter.routerDelegate.navigatorKey.currentContext!,
      builder: (BuildContext context) => BasicDialog(
        request: DialogRequest(
          title: title,
          description: description,
          mainButtonTitle: mainButtonTitle,
          alertType: AlertType.info,
        ),
      ),
    );
  }

  Future<DialogResponse?> show<T extends Object>({
    required DialogType dialogType,
    required AlertType alertType,
    String? title,
    required String description,
    dynamic data,
    bool? isDimissible,
    String? mainButtonTitle,
    String? secondaryButtonTitle,
  }) async {
    assert(_goRouter.routerDelegate.navigatorKey.currentContext != null);

    final dialogs = _dialogBuilders[dialogType];

    assert(dialogs != null);

    return showDialog<DialogResponse>(
      barrierDismissible: isDimissible ?? true,
      context: _goRouter.routerDelegate.navigatorKey.currentContext!,
      builder: (BuildContext context) => dialogs!(
        context,
        DialogRequest(
          title: title,
          description: description,
          mainButtonTitle: mainButtonTitle,
          secondaryButtonTitle: secondaryButtonTitle,
          data: data,
          alertType: alertType,
          variant: dialogType,
        ),
      ),
    );
  }
}
