import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/di/modules/netwok_module.dart';
import 'package:greetings_world_shopper/di/modules/preference_module.dart';
import 'package:inject/inject.dart';
import '../../main.dart';
import 'app_component.inject.dart' as g;

/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [NetworkModule, PreferenceModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
    NetworkModule networkModule,
    PreferenceModule preferenceModule,
  ) async {
    return await g.AppComponent$Injector.create(
      networkModule,
      preferenceModule,
    );
  }

  /// An accessor to RestClient object that an application may use.
  @provide
  Repository getRepository();
}
