//DART/FLUTTER IMPORTS
import 'package:flutter/material.dart';
//COMPONENT IMPORTS
import '../components/ui/side_drawer.dart';
//PAGE IMPORTS
import '../pages/product_edit_page.dart';
import '../pages/product_list_page.dart';
//MODEL IMPORTS

class ProductAdminPage extends StatelessWidget {
  //CONSTRUCTOR (no longer here, we use scoped models now)

  //WIDGETS
  Widget _productAdminPageRender(BuildContext context){
    return Container(
      child: DefaultTabController(
        length: 2,
        child:  Scaffold(
          drawer: sideDrawer(context),
          appBar: AppBar(
            title: Text('Product Management', style: TextStyle(color: Colors.white),),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget> [
                Tab(icon: Icon(Icons.create, color: Colors.white,),),
                Tab(icon: Icon(Icons.view_list, color: Colors.white,),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(), //
              ProductListPage(),
            ]

          ),
        )
      ),
    );
  }

  //BUILD
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _productAdminPageRender(context);
  }
}