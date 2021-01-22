import 'package:flutter/material.dart';


class Labels extends StatelessWidget {

  final String ruta;
  final String texto;
  final String link;

  const Labels({
    Key key,
    @required this.ruta,
    @required this.texto,
    @required this.link
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.texto, style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.link, style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold
            )),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.ruta);
            }
          )
        ],
      ),
    );
  }
}