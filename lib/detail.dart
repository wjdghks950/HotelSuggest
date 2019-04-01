import 'package:flutter/material.dart';
import 'model/products_repository.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';
import 'home.dart';

class ProductDetail extends StatefulWidget{
  final Product product;

  ProductDetail({Key key, @required this.product}) : super(key : key);

  _ProductState createState() => _ProductState(this.product);
}

class _ProductState extends State<ProductDetail>{
  Product product;
  _ProductState(this.product);
  @override
  Widget build(BuildContext context){
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);}
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text('Detail',
          style: TextStyle(color: Colors.white)),
      ),
      body: Hero(
        tag: product.name,
          child: ListView(
            children:[
              Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStar(context, product.numstars, true),
                    Padding(
                      padding: EdgeInsets.only(top:10.0),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,),
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.location_on,
                      color: Colors.blue[400], 
                      size: 17.0,
                    ),
                    Padding(padding: EdgeInsets.only(left:8.0)),
                    Flexible(
                      child: Text(
                        product == null ? '' : product.address,
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 13.0,
                        ),
                        softWrap:true,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.phone,
                      color: Colors.blue[400], 
                      size: 17.0,
                    ),
                    Padding(padding: EdgeInsets.only(left:8.0)),
                    Text(
                      product == null ? '' : product.phone,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Divider(height: 2.0, color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                  Text(
                    product == null ? '' : product.description,
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 13.0,
                    ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}