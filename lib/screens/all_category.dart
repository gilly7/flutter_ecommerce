import 'package:firstapp/screens/category_product.dart';
import 'package:firstapp/services/apiService.dart';
import 'package:flutter/material.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getAllCategory(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // return Text("success");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryProductScreen(snapshot.data[index])));
                    },
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: Text(
                            snapshot.data[index].toString().toUpperCase(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
