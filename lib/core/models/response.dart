class IResponse<T> {
  IResponse({
    this.confirmed = false,
    this.data,
  });

  final bool confirmed;
  final T? data;
    bool get isCancel => confirmed == false;
}

class DialogResponse<T> extends IResponse<T> {
  DialogResponse({super.confirmed, super.data});
}

class BottomSheetResponse<T> extends IResponse<T> {
  BottomSheetResponse({super.confirmed, super.data});
}
