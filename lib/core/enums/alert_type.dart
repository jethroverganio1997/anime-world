
import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:flutter/material.dart';

enum AlertType {
  info(label: 'Info', icon: Icons.info_outline),
  success(label: 'Success', icon: Icons.check),
  error(label: 'Error', icon: Icons.clear),
  empty(label: 'No Result Found', icon: Icons.not_interested),
  delete(label: 'Delete', icon: Icons.delete ),
  advisory(label: 'Advisory', icon: Icons.newspaper ),
  warning(label: 'Warning', icon: Icons.warning );

  const AlertType({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  static AlertType fromString(String type) {
    switch (type) {
      case 'Info':
        return AlertType.info;
      case 'Success':
        return AlertType.success;
      case 'Empty':
        return AlertType.empty;
      case 'Delete':
        return AlertType.delete;
      case 'Advisory':
        return AlertType.advisory;
      case 'Warning':
        return AlertType.warning;
      default:
        return AlertType.error;
    }
  }

  Color? toColor(BuildContext context) {
    switch (this) {
      case AlertType.info:
        return context.colorScheme.primary;
      case AlertType.success:
        return context.colorScheme.primary;
      case AlertType.error:
        return context.colorScheme.error;
      case AlertType.delete:
        return context.colorScheme.error;
      case AlertType.warning:
        return context.colorScheme.secondary;
      case AlertType.advisory:
        return context.colorScheme.primary;
      case AlertType.empty:
        return context.colorScheme.outline;
    }
  }

 
}
