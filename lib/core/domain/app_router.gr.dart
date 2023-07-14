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
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    CreateQuizRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateQuizScreen(),
      );
    },
    ExploreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExploreScreen(),
      );
    },
    MyQuizzesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyQuizzesScreen(),
      );
    },
    QuizReportRoute.name: (routeData) {
      final args = routeData.argsAs<QuizReportRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuizReportScreen(
          key: args.key,
          quiz: args.quiz,
          quizReport: args.quizReport,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => SearchRouteArgs(search: pathParams.getString('query')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchScreen(
          key: args.key,
          search: args.search,
        ),
      );
    },
    SolveQuizRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SolveQuizRouteArgs>(
          orElse: () => SolveQuizRouteArgs(quizId: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SolveQuizScreen(
          key: args.key,
          quizId: args.quizId,
        ),
      );
    },
    StartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartScreen(),
      );
    },
    ViewQuizRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewQuizRouteArgs>(
          orElse: () => ViewQuizRouteArgs(quizId: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewQuizScreen(
          key: args.key,
          quizId: args.quizId,
        ),
      );
    },
  };
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateQuizScreen]
class CreateQuizRoute extends PageRouteInfo<void> {
  const CreateQuizRoute({List<PageRouteInfo>? children})
      : super(
          CreateQuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateQuizRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExploreScreen]
class ExploreRoute extends PageRouteInfo<void> {
  const ExploreRoute({List<PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyQuizzesScreen]
class MyQuizzesRoute extends PageRouteInfo<void> {
  const MyQuizzesRoute({List<PageRouteInfo>? children})
      : super(
          MyQuizzesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyQuizzesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuizReportScreen]
class QuizReportRoute extends PageRouteInfo<QuizReportRouteArgs> {
  QuizReportRoute({
    Key? key,
    required Quiz quiz,
    required QuizReport quizReport,
    List<PageRouteInfo>? children,
  }) : super(
          QuizReportRoute.name,
          args: QuizReportRouteArgs(
            key: key,
            quiz: quiz,
            quizReport: quizReport,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizReportRoute';

  static const PageInfo<QuizReportRouteArgs> page =
      PageInfo<QuizReportRouteArgs>(name);
}

class QuizReportRouteArgs {
  const QuizReportRouteArgs({
    this.key,
    required this.quiz,
    required this.quizReport,
  });

  final Key? key;

  final Quiz quiz;

  final QuizReport quizReport;

  @override
  String toString() {
    return 'QuizReportRouteArgs{key: $key, quiz: $quiz, quizReport: $quizReport}';
  }
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    required String search,
    List<PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            search: search,
          ),
          rawPathParams: {'query': search},
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<SearchRouteArgs> page = PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.search,
  });

  final Key? key;

  final String search;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, search: $search}';
  }
}

/// generated route for
/// [SolveQuizScreen]
class SolveQuizRoute extends PageRouteInfo<SolveQuizRouteArgs> {
  SolveQuizRoute({
    Key? key,
    required int quizId,
    List<PageRouteInfo>? children,
  }) : super(
          SolveQuizRoute.name,
          args: SolveQuizRouteArgs(
            key: key,
            quizId: quizId,
          ),
          rawPathParams: {'id': quizId},
          initialChildren: children,
        );

  static const String name = 'SolveQuizRoute';

  static const PageInfo<SolveQuizRouteArgs> page =
      PageInfo<SolveQuizRouteArgs>(name);
}

class SolveQuizRouteArgs {
  const SolveQuizRouteArgs({
    this.key,
    required this.quizId,
  });

  final Key? key;

  final int quizId;

  @override
  String toString() {
    return 'SolveQuizRouteArgs{key: $key, quizId: $quizId}';
  }
}

/// generated route for
/// [StartScreen]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ViewQuizScreen]
class ViewQuizRoute extends PageRouteInfo<ViewQuizRouteArgs> {
  ViewQuizRoute({
    Key? key,
    required int quizId,
    List<PageRouteInfo>? children,
  }) : super(
          ViewQuizRoute.name,
          args: ViewQuizRouteArgs(
            key: key,
            quizId: quizId,
          ),
          rawPathParams: {'id': quizId},
          initialChildren: children,
        );

  static const String name = 'ViewQuizRoute';

  static const PageInfo<ViewQuizRouteArgs> page =
      PageInfo<ViewQuizRouteArgs>(name);
}

class ViewQuizRouteArgs {
  const ViewQuizRouteArgs({
    this.key,
    required this.quizId,
  });

  final Key? key;

  final int quizId;

  @override
  String toString() {
    return 'ViewQuizRouteArgs{key: $key, quizId: $quizId}';
  }
}
