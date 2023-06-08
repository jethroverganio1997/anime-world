import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_widgets/custom_logger.dart';

class ProviderLogger extends ProviderObserver {
  final log = getLogger('ProviderLogger');

  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    log.v("AddProvider:" '${provider.name ?? provider.runtimeType}');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log.w("DisposeProvider:" '${provider.name ?? provider.runtimeType}');
    super.didDisposeProvider(provider, container);
  }

//   @override
//   void didUpdateProvider(
//     ProviderBase provider,
//     Object? previousValue,
//     Object? newValue,
//     ProviderContainer container,
//   ) {
//     print('''
// {
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''');
//   }
}
