import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:animenginamo/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/theme/theme_size.dart';
import '../enums/alert_type.dart';
import '../models/request.dart';
import '../models/response.dart';

enum DialogType { basic }

abstract interface class Dialogs extends HookWidget {
  final DialogRequest request;
  const Dialogs({required this.request, super.key});
}

class BasicDialog extends Dialogs {
  const BasicDialog({super.key, required super.request});

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogBody(
            title: request.title ?? request.alertType!.label,
            description: request.description ?? '',
            variant: request.alertType!,
          ),
          Sizes.verticalSpace24,
          _DialogButton.single(
            mainButtonTitle: request.mainButtonTitle ?? 'Confirm',
            onTapMainButton: () => Navigator.of(context).pop(DialogResponse(confirmed: true)),
            alertType: request.alertType ?? AlertType.empty,
          ),
        ],
      ),
    );
  }
}

class ConfirmationDialog extends Dialogs {
  const ConfirmationDialog({super.key, required super.request});

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogBody(
            title: request.title ?? request.alertType!.label,
            description: request.description ?? '',
            variant: request.alertType!,
          ),
          Sizes.verticalSpace24,
          _DialogButton(
            mainButtonTitle: request.mainButtonTitle ?? 'Confirm',
            secondButtonTitle: request.secondaryButtonTitle ?? 'Cancel',
            onTapMainButton: () => Navigator.of(context).pop(DialogResponse(confirmed: true)),
            onTapSecondButton: () => Navigator.of(context).pop(DialogResponse(confirmed: false)),
            alertType: request.alertType ?? AlertType.empty,
          ),
        ],
      ),
    );
  }
}

class _BaseDialog extends StatelessWidget {
  const _BaseDialog({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          padding: const EdgeInsets.all(Sizes.padding24),
          child: child,
        ));
  }
}

class _DialogBody extends StatelessWidget {
  const _DialogBody({
    Key? key,
    required this.variant,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;
  final AlertType variant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (variant != AlertType.empty)
          CircleAvatar(
            radius: Sizes.radius12 * 3,
            backgroundColor: variant.toColor(context)!.withOpacity(.10),
            child: Icon(variant.icon, color: variant.toColor(context), size: Sizes.iconSize24 * 2),
          ),
        Sizes.verticalSpace8,
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        Sizes.verticalSpace16,
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: context.heightPercent(0.4)),
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.only(right: Sizes.padding8),
              shrinkWrap: true,
              children: [
                Text(
                  description,
                  style: context.theme.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

///[single] is when `_primaryButton~` button only was used.
///[dual] is when `_primaryButton and _secondaryButton` button was used .
///[vertical] is when you want to display the dual button into vertical axis.
enum DialogButtonType { single, dual, vertical }

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.mainButtonTitle,
    required this.secondButtonTitle,
    required this.onTapMainButton,
    required this.onTapSecondButton,
    required this.alertType,
  }) : _type = DialogButtonType.dual;

  const _DialogButton.single({
    required this.mainButtonTitle,
    required this.onTapMainButton,
    required this.alertType,
  })  : _type = DialogButtonType.single,
        secondButtonTitle = null,
        onTapSecondButton = null;

  const _DialogButton.vertical({
    required this.mainButtonTitle,
    required this.secondButtonTitle,
    required this.onTapMainButton,
    required this.onTapSecondButton,
    required this.alertType,
  }) : _type = DialogButtonType.vertical;

  final String mainButtonTitle;
  final String? secondButtonTitle;
  final VoidCallback onTapMainButton;
  final VoidCallback? onTapSecondButton;
  final AlertType alertType;
  final DialogButtonType _type;

  Widget _primaryButton(BuildContext context) => Flexible(
        child: FilledButton(
          onPressed: onTapMainButton,
          child: Text(
            mainButtonTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ).expanded(),
      );

  Widget _secondaryButton(BuildContext context) => Flexible(
        child: TextButton(
          onPressed: onTapSecondButton ?? () {},
          child: Text(
            secondButtonTitle ?? 'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(color: AlertType.empty.toColor(context)),
          ),
        ).expanded(),
      );

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case DialogButtonType.single:
        return _primaryButton(context);
      case DialogButtonType.dual:
        return Row(
          children: [
            _secondaryButton(context),
            Sizes.horizontalSpace8,
            _primaryButton(context),
          ],
        );
      case DialogButtonType.vertical:
        return Column(
          children: [
            _primaryButton(context),
            Sizes.verticalSpace8,
            _secondaryButton(context),
          ],
        );
    }
  }
}
