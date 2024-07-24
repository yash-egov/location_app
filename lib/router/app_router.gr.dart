// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    WeatherPageRoute.name: (routeData) {
      final args = routeData.argsAs<WeatherPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WeatherPageScreen(
          args.city,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
  };
}

/// generated route for
/// [WeatherPageScreen]
class WeatherPageRoute extends PageRouteInfo<WeatherPageRouteArgs> {
  WeatherPageRoute({
    required String city,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WeatherPageRoute.name,
          args: WeatherPageRouteArgs(
            city: city,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'WeatherPageRoute';

  static const PageInfo<WeatherPageRouteArgs> page =
      PageInfo<WeatherPageRouteArgs>(name);
}

class WeatherPageRouteArgs {
  const WeatherPageRouteArgs({
    required this.city,
    this.key,
  });

  final String city;

  final Key? key;

  @override
  String toString() {
    return 'WeatherPageRouteArgs{city: $city, key: $key}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
