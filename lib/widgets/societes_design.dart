import 'package:flutter/material.dart';

//import '../models/sellers.dart';
import '../mainScreens/menus_screen.dart';
import '../models/societes.dart';

class SocietesDesignWidget extends StatefulWidget {
  Societes? model;
  BuildContext? context;

  SocietesDesignWidget({this.model, this.context});

  @override
  _SocietesDesignWidgetState createState() => _SocietesDesignWidgetState();
}

class _SocietesDesignWidgetState extends State<SocietesDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (c)=>MenusScreen(model:widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.societeAvatarUrl!,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.societeName!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Train",
                ),
              ),
              Text(
                widget.model!.societeEmail!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
