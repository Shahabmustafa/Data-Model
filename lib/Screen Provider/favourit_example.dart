import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/Provider/favourite_provider.dart';
import 'package:state_management/Screen%20Provider/add_favourite.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<int> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    print('Build');
    // final favouriteProvider = Provider.of<FavouriteItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('AppBar')),
      ),
      body: ListView.builder(
        itemCount: 50,
          itemBuilder: (context,index){
        return Consumer<FavouriteItemProvider>(builder: (context,value,child){
          return ListTile(
            onTap: (){
              if(value.selectedItem.contains(index)){
                value.removeItem(index);
              }else{
                value.addItem(index);
              }
            },
            title: Text('Item ${index.toString()}'),
            trailing: Icon(
                value.selectedItem.contains(index) ? Icons.favorite : Icons.favorite_border_outlined),
          );
        });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFavourite()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
