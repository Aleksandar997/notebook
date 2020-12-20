import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services/implementations/routing_service.dart';

class DependencyInjection {
  static final getIt = GetIt.instance;

  @InjectableInit(
    initializerName: r'$initGetIt', // default
    preferRelativeImports: true, // default
    asExtension: false, // default
  )
  // @InjectableInit(generateForDir: ['test'])
  static void configureDependencies() => $initGetIt(getIt);

  static void $initGetIt(GetIt getIt,
      {String environment, EnvironmentFilter environmentFilter}) {
    final gh = GetItHelper(getIt, environment);
    gh.factory<RoutingService>(() => RoutingService());
  }
}
