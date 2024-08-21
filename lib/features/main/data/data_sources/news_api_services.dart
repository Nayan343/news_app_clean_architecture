import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/resources/network/network_imports.dart';

abstract class NewsApiServices{
  Future<Response> getArticles();
}

class NewsApiServicesImpl implements NewsApiServices{
  final DioClient _dioClient;
  const NewsApiServicesImpl(this._dioClient);

  @override
  Future<Response> getArticles() async{
    return await _dioClient.get(Endpoints.topHeadlines, queryParameters: {
      "apiKey":Endpoints.apiKey,
      "country":Endpoints.country,
      "category":Endpoints.category,
    });
  }
}