import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/article/article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/saved_article/saved_article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/article_detail.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/saved_article_page.dart';
import 'package:news_app_clean_architecture/features/main/presentation/widgets/article_tile.dart';
import 'package:news_app_clean_architecture/features/main/presentation/widgets/progress_error_widget.dart';

class DailyNewsPage extends StatelessWidget {
  static const route = "/";

  const DailyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      buildWhen: (currentState, nextState) => currentState != nextState,
      builder: (context, state) {
        return ProgressErrorWidget(
          isProgressRunning: state is ArticleInitialLoading,
          isError: state is ArticleError,
          errorText: state.exception?.message,
          onPressed: () =>
              context.read<ArticleBloc>().add(const GetArticleEvent()),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
              actions: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, SavedArticlePage.route,
                      arguments: context.read<SavedArticleBloc>()),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(Icons.bookmark, color: Colors.black),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: state.articles?[index],
                    onArticlePressed: (article) {
                      Navigator.pushNamed(context, ArticleDetailsView.route,
                          arguments: ArticleDetailsViewArguments(
                              article: article,
                              isForSave: true,
                              savedArticleBloc:
                              context.read<SavedArticleBloc>()));
                    },
                  );
                },
                itemCount: state.articles?.length ?? 0,
              ),
            ),
          ),
        );
      },
    );
  }
}
