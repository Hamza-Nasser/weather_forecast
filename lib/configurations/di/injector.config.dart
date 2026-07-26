// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:weather_app/core/cache/cache_client.dart' as _i1006;
import 'package:weather_app/core/cache/cache_client_impl.dart' as _i217;
import 'package:weather_app/core/cache/cache_config.dart' as _i962;
import 'package:weather_app/core/cache/disk_cache_client.dart' as _i230;
import 'package:weather_app/core/cache/memory_cache_client.dart' as _i232;
import 'package:weather_app/core/network/client/dio_restful_client.dart'
    as _i729;
import 'package:weather_app/core/network/client/restful_client.dart' as _i727;
import 'package:weather_app/core/services/app_error_reporter.dart' as _i123;
import 'package:weather_app/core/services/prefs/app_preferences.dart' as _i1060;
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart'
    as _i985;
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart'
    as _i530;
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart'
    as _i578;
import 'package:weather_app/features/weather/data/sources/weather_remote_source_impl.dart'
    as _i834;
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart'
    as _i504;
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart'
    as _i297;
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart'
    as _i950;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i962.CacheConfig>(
      () => const _i962.CacheConfig.defaultConfig(),
    );
    gh.lazySingleton<_i1060.AppPreferences>(
      () => const _i1060.AppPreferencesImpl(),
    );
    gh.lazySingleton<_i123.AppErrorReporter>(
      () => const _i123.DeveloperLogErrorReporter(),
    );
    gh.lazySingleton<_i727.RestfulClient>(
      () => _i729.DioRestfulClient(gh<_i1060.AppPreferences>()),
    );
    gh.singleton<_i232.MemoryCacheClient>(
      () => _i232.MemoryCacheClient(gh<_i962.CacheConfig>()),
    );
    gh.lazySingleton<_i230.DiskCacheClient>(
      () => _i230.DiskCacheClient(gh<_i962.CacheConfig>()),
    );
    gh.factory<_i578.WeatherRemoteSource>(
      () => _i834.WeatherRemoteSourceImpl(gh<_i727.RestfulClient>()),
    );
    gh.lazySingleton<_i1006.CacheClient>(
      () => _i217.CacheClientImpl(
        gh<_i232.MemoryCacheClient>(),
        gh<_i230.DiskCacheClient>(),
      ),
    );
    gh.factory<_i985.SettingsCubit>(
      () => _i985.SettingsCubit(
        gh<_i1060.AppPreferences>(),
        gh<_i1006.CacheClient>(),
        gh<_i123.AppErrorReporter>(),
      ),
    );
    gh.factory<_i504.WeatherRepository>(
      () => _i530.WeatherRepositoryImpl(
        gh<_i578.WeatherRemoteSource>(),
        gh<_i1006.CacheClient>(),
        gh<_i1060.AppPreferences>(),
        gh<_i123.AppErrorReporter>(),
      ),
    );
    gh.factory<_i297.GetCurrentWeatherUseCase>(
      () => _i297.GetCurrentWeatherUseCase(gh<_i504.WeatherRepository>()),
    );
    gh.factory<_i950.WeatherBloc>(
      () => _i950.WeatherBloc(
        gh<_i297.GetCurrentWeatherUseCase>(),
        gh<_i1060.AppPreferences>(),
        gh<_i123.AppErrorReporter>(),
      ),
    );
    return this;
  }
}
