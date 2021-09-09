import 'package:firstapp/services/apiService.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  //const ProductDetail({ Key? key }) : super(key: key);
  final int id;
  ProductDetail(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                      snapshot.data['image'],
                      height: 200,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "\$" + snapshot.data['price'].toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data['title'],
                      style: TextStyle(fontSize: 25),
                    ),
                    Chip(
                      label: Text(
                        snapshot.data['category'].toString(),
                        style: TextStyle(
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(snapshot.data['description']),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_outlined),
        onPressed: () async {
          await ApiService().updateCart(1, id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Product added to cart")));
        },
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
