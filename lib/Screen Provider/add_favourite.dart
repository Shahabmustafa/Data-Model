import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/favourite_provider.dart';

class AddFavourite extends StatefulWidget {
  const AddFavourite({Key? key}) : super(key: key);

  @override
  State<AddFavourite> createState() => _AddFavouriteState();
}

class _AddFavouriteState extends State<AddFavourite> {
  List<int> selectedItem = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('AppBar')),
      ),
      body: ListView.builder(
          itemCount: provider.selectedItem.length,
          itemBuilder: (context,index){
            return Consumer<FavouriteItemProvider>(builder: (context,value,child){
              return ListTile(
                onTap: (){
                  value.removeItem(value.selectedItem[index]);
                  // print(value.selectedItem.remove(index));
                },
                title: Text('Item ${value.selectedItem[index]}'),
                trailing: Icon(Icons.favorite),
              );
            });
          }),
    );
  }
}
