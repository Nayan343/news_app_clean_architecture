part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
}

class GetArticleEvent extends ArticleEvent{
  const GetArticleEvent();

  @override
  List<Object?> get props =>[];
}
