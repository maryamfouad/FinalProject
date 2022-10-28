import 'package:dna_graduation/UI/buyerScreens/CategoryPage/items.dart';
import 'package:flutter/material.dart';
import 'package:dna_graduation/UI/buyerScreens/BNB.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map categoryResp = {};
  List categoryData = [];
  Future getData() async {
    var url = Uri.parse("https://matjar-api.matjarteam.repl.co/categories");
    Response response = await get(url);

    String body = response.body;
    print(body);
    Map list1 = json.decode(body);

    return list1;
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        categoryResp = value;
        if (categoryResp['code'] != 200) {
          print('error in getting data: ' + categoryResp['MSG']);
        }
        categoryData = categoryResp["data"];
        print(categoryData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.7,
        bottomOpacity: 0.1,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black, fontFamily: "Roboto"),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 25,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 60,
            child: ListView.builder(
              itemCount: categoryData.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Category(categoryData[index]["categoryName"],
                    categoryData[index]['id']);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget Category(String Type, categoryId) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Items(categoryId: categoryId, categoryName: Type)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 50,
        width: MediaQuery.of(context).size.width - 100,
        child: Center(
          child: Text(
            "$Type",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[400],
        ),
      ),
    );
  }
}