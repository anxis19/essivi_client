import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essivi_client/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../models/items.dart';
import '../models/menus.dart';
import '../widgets/app_bar.dart';
import '../widgets/items_design.dart';
import '../widgets/societes_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
//import '../model/menus.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(societeUID: widget.model!.societeUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(
                  title: "Items of " +
                      widget.model!.menuTitle.toString() +
                      "'s Menu")),
          const SliverToBoxAdapter(
              // child: ListTile(title: Text("Mes menus", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Signatra", fontSize: 30, letterSpacing: 2),)),
              ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Sociétés")
                .doc(widget.model!.societeUID)
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
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
                        Items model = Items.fromJson(
                          snapShot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return ItemsDesignWidget(
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
