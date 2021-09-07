import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ArticleModel.dart';

class News{
  List<ArticleModel> newslist = [];
  List<ArticleModel> newslistnew = [];
  Future<void> getdata ()async{
    http.Response response= await http.get('https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=b84e0a46a6a140e493df38cfd35f2f80');
    var data=jsonDecode(response.body);
    if(data['status' ]== 'ok')
      {
        data['articles'].forEach((element){
          if(element['urlToImage'] != null && element['description'] != null){
            ArticleModel articleModel= ArticleModel(
              imageurl2: element['urlToImage'],
              title: element['title'],
              desc: element['description'],
              url: element['url'],
            );
            newslist.add(articleModel);
          }
        });
      }
  }
  Future<void> getdatabycategory (String category)async{
    http.Response response= await http.get('https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=b84e0a46a6a140e493df38cfd35f2f80');
    var data=jsonDecode(response.body);
    if(data['status'] == 'ok')
    {
      data['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel= ArticleModel(
            imageurl2: element['urlToImage'],
            title: element['title'],
            desc: element['description'],
            url: element['url'],
          );
          newslistnew.add(articleModel);
        }
      });
    }
  }
}