import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// flutter run --no-sound-null-safety

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "";

  void _RecuperarPreco() async {
    http.Response response =
        await http.get("https://www.mercadobitcoin.net/api/BTC/ticker/");
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["ticker"]["buy"].toString().split(".")[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/bitcoin.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "R\$" + _preco + ".00",
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
                RaisedButton(
                  child: const Text("Atualizar",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  color: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
                  onPressed: _RecuperarPreco,
                )
              ],
            ),
          )),
      backgroundColor: Colors.white30,
    );
  }
}
