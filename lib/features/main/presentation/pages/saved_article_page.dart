import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/saved_article/saved_article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/pages/article_detail.dart';
import 'package:news_app_clean_architecture/features/main/presentation/widgets/article_tile.dart';
import 'package:news_app_clean_architecture/features/main/presentation/widgets/progress_error_widget.dart';

class SavedArticlePage extends StatelessWidget {
  static const route = "/SavedArticlePage";

  const SavedArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedArticleBloc, SavedArticleState>(
      buildWhen: (currentState, nextState) => currentState.status != nextState.status,
      builder: (context, state) {
        return ProgressErrorWidget(
          isProgressRunning: state.status == SavedArticleStatus.initial,
          isError: state.status == SavedArticleStatus.failed,
          errorText: state.exception?.message,
          onPressed: () => context.read<SavedArticleBloc>().add(const GetSavedArticles()),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Saved Articles"),
            ),
            body: SafeArea(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: state.articles?[index],
                    isRemovable: true,
                    onRemove: (value){
                      context.read<SavedArticleBloc>().add(RemoveArticle(articleEntity: value));
                    },
                    onArticlePressed: (article) {
                      Navigator.pushNamed(context, ArticleDetailsView.route,
                          arguments: ArticleDetailsViewArguments(article: article));
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
