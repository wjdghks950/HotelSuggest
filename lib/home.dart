import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'menu.dart';
import 'detail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuBar(),
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Main',
          style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      body: OrientationBuilder(
          builder: (context, orientation){
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: _buildGridCards(context),
            );
          },
      ),
    );
  }

  List<Card> _buildGridCards(BuildContext context){
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    
    if (products == null || products.isEmpty){ // In case the list of products is empty
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );

    return products.map((product){
      return Card(
        clipBehavior: Clip.antiAlias, // You can make it into a radius
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 16.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildStar(context, product.numstars, false), // Stars for the hotel
                  Text(
                    product == null ? '' : product.name,
                    style: theme.textTheme.button,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines:1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.location_on,
                    color: Colors.blue[400], 
                    size: 17.0,
                  ),
                  Padding(padding: EdgeInsets.only(left:8.0)),
                  Flexible(
                    child:Text(
                      product == null ? '' : product.address,
                      style: theme.textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                SizedBox(
                  width: 58.0,
                  height: 20.0,
                  child: Hero(
                    tag: product.name,
                    child: FlatButton(
                      child: Text('more',
                        style: TextStyle(
                          fontFamily:'Rubik',
                          fontSize: 10.0,
                          color: Colors.blue[400],
                        ),
                      ),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductDetail(product: product,))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}

  Widget buildStar(BuildContext context, int numstars, bool detail){ // Generate random number of stars (from 1 to 5)
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        numstars, 
        (index) => Icon(
          Icons.star, 
          color: Colors.yellow, 
          size: detail ? 25.0 : 10.0,
        ),
      ),
    );
  }