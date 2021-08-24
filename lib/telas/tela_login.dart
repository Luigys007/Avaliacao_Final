import 'package:flutter/material.dart';
import '../componentes/card_login.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dimensoesDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(31, 112, 155, 1),
              Color.fromRGBO(31, 112, 155, 0.85),
              Color.fromRGBO(31, 112, 155, 0.70),
              Color.fromRGBO(31, 112, 155, 0.5),
              Color.fromRGBO(31, 112, 155, 0.70),
              Color.fromRGBO(31, 112, 155, 0.85),
              Color.fromRGBO(31, 112, 155, 1),
            ])),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: dimensoesDispositivo.width * 0.75,
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 70,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black38,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Text(
                    "CURSO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CardLogin()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
