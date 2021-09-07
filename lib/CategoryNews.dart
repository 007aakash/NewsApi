import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samachar/News.dart';
import 'ArticleModel.dart';
import 'main.dart';

class CategoryNews extends StatefulWidget {
  final String newsurl;
  const CategoryNews({Key key,this.newsurl}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}


class _CategoryNewsState extends State<CategoryNews> {
  News newsClass = News();
  List<ArticleModel> newslistcategory=[];

  void getdataandset(String newsurl) async {
    await newsClass.getdatabycategory(widget.newsurl);
    setState(() {
      newslistcategory= newsClass.newslistnew;
    });
  }
  @override
  void initState() {
    getdataandset(widget.newsurl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.newsurl}',style: GoogleFonts.padauk(color: Colors.black,fontWeight: FontWeight.bold)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: newslistcategory.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return NewsBlog(
                urltoimage: newslistcategory[index].imageurl2 ?? "",
                title: newslistcategory[index].title ?? "",
                desc: newslistcategory[index].desc ?? "",
                urlforweb: newslistcategory[index].url,
              );
            }),
      ),
    );
  }
}

