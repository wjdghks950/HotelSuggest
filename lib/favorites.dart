import 'package:flutter/material.dart';
import 'model/product.dart';
import 'favoritemodel.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget{
  FavoritePage({Key key}) : super(key : key);

  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoritePage>{
  @override
  Widget build(BuildContext context){
    //print(saved);
    return MaterialApp(
      title: 'Favorite Hotels',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Favorite Hotels'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: ScopedModel.of<FavoriteList>(context).saved.length,
          itemBuilder: (context, i){
            return _buildRow(ScopedModel.of<FavoriteList>(context).saved[i]);
          }
        ),
      ),
    );
  }
  Widget _buildRow(product){ // build each row for favorites page
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(product.name),
      onDismissed: (direction){
        setState((){
          ScopedModel.of<FavoriteList>(context).saved.remove(product);
        });
      },
      child: ListTile(
        title: Text(product.name,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}