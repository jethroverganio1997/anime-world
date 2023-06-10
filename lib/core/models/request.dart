import '../enums/alert_type.dart';


class IRequest<T> {
  IRequest({
    this.title,
    this.description,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.data,
    this.variant,
    this.alertType,
  });

  final String? title;
  final String? description;
  final String? mainButtonTitle;
  final String? secondaryButtonTitle;
  final AlertType? alertType;
  final dynamic variant;
  final dynamic data;
}

class DialogRequest<T> extends IRequest<T> {
  DialogRequest({
    super.title,
    super.description,
    super.mainButtonTitle,
    super.secondaryButtonTitle,
    super.data,
    super.variant,
    required super.alertType,
  });
}


