part of 'saved_article_bloc.dart';

enum SavedArticleStatus { initial, success, failed}
final class SavedArticleState extends Equatable {
  const SavedArticleState({this.status, this.articles, this.exception,});
  final List<ArticleEntity>? articles;
  final SavedArticleStatus? status;
  final AppException? exception;

  SavedArticleState copyWith({
    List<ArticleEntity>? articles,
    SavedArticleStatus? status,
    AppException? exception,
  }) =>
      SavedArticleState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        exception: exception ?? this.exception,
      );

  @override
  String toString() {
    return '''SavedArticleState { status: $status, articles: ${articles?.length}, error: $exception''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, articles, exception];
}
