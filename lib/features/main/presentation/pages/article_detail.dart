import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/constants/image_constants.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/saved_article/saved_article_bloc.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class ArticleDetailsViewArguments {
  final SavedArticleBloc? savedArticleBloc;
  final ArticleEntity? article;
  final bool? isForSave;

  const ArticleDetailsViewArguments(
      {this.article, this.isForSave = false, this.savedArticleBloc});
}

class ArticleDetailsView extends StatelessWidget {
  static const route = "/ArticleDetailsView";
  final ArticleDetailsViewArguments? arguments;

  const ArticleDetailsView({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton:
          arguments?.isForSave == true ? _buildFloatingActionButton() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [
        _buildArticleTitleAndDate(),
        _buildArticleImage(),
        _buildArticleDescription(),
      ],
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            arguments?.article?.title ?? "",
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                arguments?.article?.publishedAt ?? "",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
          arguments?.article?.urlToImage ?? ImageConst.loadingNetworkImage,
          fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${arguments?.article?.description ?? ''}\n\n${arguments?.article?.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocProvider.value(
      value: arguments?.savedArticleBloc ?? sl<SavedArticleBloc>(),
      child: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () => _onFloatingActionButtonPressed(context),
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.bookmark, color: Colors.white),
        );
      }),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<SavedArticleBloc>(context)
        .add(SaveArticle(articleEntity: arguments?.article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }
}
