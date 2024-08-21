part of 'article_bloc.dart';

@immutable
abstract class ArticleState extends Equatable{
  final List<ArticleEntity>? articles;
  final AppException? exception;

  const ArticleState({this.articles, this.exception});

  @override
  List<Object?> get props => [articles, exception];

  @override
  String toString() {
    return '''ArticleState {articles: ${articles?.length}, error: $exception''';
  }
}

class ArticleInitialLoading extends ArticleState {
  const ArticleInitialLoading();
}

class ArticleDone extends ArticleState{
  const ArticleDone(List<ArticleEntity> articles) : super(articles: articles);
}

class ArticleError extends ArticleState{
  const ArticleError(AppException exception) : super(exception: exception);
}
