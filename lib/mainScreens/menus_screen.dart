import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essivi_client/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../assistantMethods/assistant_methods.dart';
import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../models/menus.dart';
import '../models/societes.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/menus_design.dart';
import '../widgets/societes_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
//import '../model/menus.dart';

class MenusScreen extends StatefulWidget {
  final Societes? model;
  MenusScreen({this.model});
  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            clearCartNow(context);

            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const MySplashScreen()));
          },
        ),
        title: Text(
          "Essivi Sarl",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      //drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(
                  title: widget.model!.societeName.toString() + "Menus")),
          const SliverToBoxAdapter(
              // child: ListTile(),
              //title: Text("Mes menus", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Signatra", fontSize: 30, letterSpacing: 2),),

              ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Sociétés")
                .doc(widget.model!.societeUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapShot) {
              return !snapShot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Menus model = Menus.fromJson(
                          snapShot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return MenusDesignWidget(
                          model: model,
                          context: context,
                        );
                      },
                      itemCount: snapShot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
