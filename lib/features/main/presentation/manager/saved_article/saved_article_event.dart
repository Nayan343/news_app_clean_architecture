part of 'saved_article_bloc.dart';

abstract class SavedArticleEvent extends Equatable {
  const SavedArticleEvent();
}

class SaveArticle extends SavedArticleEvent{
  const SaveArticle({this.articleEntity});
  final ArticleEntity? articleEntity;
  @override
  // TODO: implement props
  List<Object?> get props => [articleEntity];
}

class RemoveArticle extends SavedArticleEvent{
  const RemoveArticle({this.articleEntity});
  final ArticleEntity? articleEntity;
  @override
  // TODO: implement props
  List<Object?> get props => [articleEntity];
}

class GetSavedArticles extends SavedArticleEvent{
  const GetSavedArticles();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
