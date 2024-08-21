import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/article/article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/saved_article/saved_article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/article_detail.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/daily_news_page.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/saved_article_page.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

final navKey = GlobalKey<NavigatorState>();

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint("${settings.name}");
    switch (settings.name) {
      case DailyNewsPage.route:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<ArticleBloc>()..add(const GetArticleEvent()),
              ),
              BlocProvider(
                lazy: false,
                create: (context) =>
                    sl<SavedArticleBloc>()..add(const GetSavedArticles()),
              ),
            ],
            child: const DailyNewsPage(),
          ),
        );
      case ArticleDetailsView.route:
        return _materialRoute(
          ArticleDetailsView(
            arguments: settings.arguments as ArticleDetailsViewArguments,
          ),
        );
      case SavedArticlePage.route:
        final savedArticleBloc = settings.arguments as SavedArticleBloc;
        return _materialRoute(
          BlocProvider.value(
            value: savedArticleBloc,
            child: const SavedArticlePage(),
          ),
        );
      default:
        return _materialRoute(const SizedBox.shrink());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
