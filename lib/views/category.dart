import 'dart:convert';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'package:wallpaperplace/data/data.dart';
import 'package:wallpaperplace/model/photosmodel.dart';  
import 'package:wallpaperplace/widget/appbar.dart'; 

class CategorieScreen extends StatefulWidget {
  final String categorie;

  CategorieScreen({@required this.categorie, String category});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotosModel> photos = new List();

  getCategorieWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=30&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon (Icons.arrow_back_ios, color: Colors.blue,)),
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 4.0,
         
      ),
      body: SingleChildScrollView(
        child: wallPaper(photos, context)
        ,
      ),
    );
  }
}