import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samachar/CategoryNews.dart';
import 'package:samachar/News.dart';
import 'CategoriesModel.dart';
import 'ArticleModel.dart';
import 'webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.grey),
      home: Home(),
    );
  }
}
//the darkest mind 2.i am  mother 3.legion 4.12 strong 5.jurassic world fallen

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categoireslist = List<CategoriesModel>();

  List<ArticleModel> newslist2 = [];

  void getdataandset() async {
    News newsClass = News();
    await newsClass.getdata();
    setState(() {
      newslist2 = newsClass.newslist;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoireslist = getCategories();
    getdataandset();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sama',
              style:
                  GoogleFonts.courierPrime(color: Colors.black, fontSize: 24),
            ),
            Text(
              'Char',
              style: GoogleFonts.courierPrime(color: Colors.blue, fontSize: 24),
            ),
          ],
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter,
        children: [SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoireslist.length,
                      itemBuilder: (context, index) {
                        return CategoryWidget(
                          imgurl: categoireslist[index].imageurl,
                          text: categoireslist[index].text,
                        );
                      }),
                ),

                // SizedBox(height: 10,),
                // Container(
                //   height: 50,
                //   child:AdWidget(ad: banner,),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist2.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsBlog(
                          urltoimage: newslist2[index].imageurl2 ?? "",
                          title: newslist2[index].title ?? "",
                          desc: newslist2[index].desc ?? "",
                          urlforweb: newslist2[index].url,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
         ],
      )
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String imgurl;
  final String text;
  const CategoryWidget({Key key, this.imgurl, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(newsurl: text)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        height: 70,
        child: Stack(
          children: [
            Container(
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(imgurl),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.courierPrime(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsBlog extends StatelessWidget {
  final String title;
  final String desc;
  final String urltoimage;
  final String urlforweb;

  const NewsBlog(
      {Key key, this.title, this.desc, this.urltoimage, this.urlforweb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(urlforweb)));
        print(urlforweb);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          child: Container(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          urltoimage,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.roboto(
                        color: Colors.black54, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
