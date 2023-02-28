import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essivi_client/mainScreens/save_address_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../global/global.dart';
import '../models/address.dart';
import '../widgets/address_design.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';

class AddressScreen extends StatefulWidget {
  final double? totalAmount;
  final String? societeUID;

  AddressScreen({this.totalAmount, this.societeUID});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Essivi Sarl",
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ajouter une nouvelle adresse"),
        backgroundColor: Colors.cyan,
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
        onPressed: () {
          //save address to user collection
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Choisir une adresse:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Clients")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("Clientsadresse")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: circularProgress(),
                        )
                      : snapshot.data!.docs.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AddressDesign(
                                  currentIndex: address.count,
                                  value: index,
                                  addressID: snapshot.data!.docs[index].id,
                                  totalAmount: widget.totalAmount,
                                  societeUID: widget.societeUID,
                                  model: Address.fromJson(
                                      snapshot.data!.docs[index].data()!
                                          as Map<String, dynamic>),
                                );
                              },
                            );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
