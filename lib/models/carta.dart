import 'package:flutter/material.dart';

class Carta {
  final String id;
  final String nome;
  final String cpf;
  final String grauescolaridade;
  final String imagem;
  final String idUsuario;

  const Carta({
    @required this.id,
    @required this.nome,
    @required this.cpf,
    @required this.grauescolaridade,
    @required this.imagem,
    this.idUsuario,
  });
}
