import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essivi_client/authentication/auth_screen.dart';
import 'package:essivi_client/global/global.dart';
import 'package:essivi_client/models/societes.dart';
import 'package:essivi_client/widgets/societes_design.dart';
import 'package:essivi_client/widgets/my_drawer.dart';
import 'package:essivi_client/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../assistantMethods/assistant_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    "slider/28.png",
    "slider/29.png",
    "slider/30.jpg",
    "slider/31.jpg",
    "slider/32.jpg",
    "slider/33.jpg",
    "slider/34.jpg",
    "slider/35.jpg",
    "slider/36.jpg",
    "slider/37.png",
    "slider/38.jpeg",
    "slider/39.png",
    "slider/40.png",
    "slider/41.png",
    "slider/42.png",
    "slider/43.jpg",
    "slider/44.jpg",
    "slider/45.jpg",
    "slider/46.png",
    "slider/47.png",
    "slider/48.png",
    "slider/49.png",
    "slider/50.png",
    "slider/51.png",
    "slider/52.png"
  ];

  @override
  void initState() {
    super.initState();

    clearCartNow(context);
  }

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
        title:const Text(
          "Essivi Sarl",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        // automaticallyImplyLeading: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * .3,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        autoPlayCurve: Curves.decelerate,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: items.map((index) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 1.0),
                            decoration: BoxDecoration(color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                index,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        });
                      }).toList()),
                )),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Sociétés").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Societes sModel = Societes.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        // design
                        return SocietesDesignWidget(
                          model: sModel,
                          context: context,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
