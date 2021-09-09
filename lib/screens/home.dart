import 'package:firstapp/screens/all_category.dart';
import 'package:firstapp/screens/cart_screen.dart';
import 'package:firstapp/screens/product_detail.dart';
import 'package:firstapp/services/apiService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllCategory()));
              },
              icon: Icon(Icons.view_list)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.amberAccent,
              )),
        ],
      ),
      body: FutureBuilder(
          future: ApiService().getAllPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['title']),
                        leading: Image.network(
                          snapshot.data[index]['image'],
                          height: 60,
                          width: 40,
                        ),
                        subtitle: Text("Price : \$" +
                            snapshot.data[index]['price'].toString()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      snapshot.data[index]['id'])));
                        },
                      );
                    }),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amberAccent,
              ),
            );
          }),
    );
  }
}
