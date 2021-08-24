//carta.imagemimport 'dart:html';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/foto.dart';
import '../models/carta.dart';
import '../providers/cartas_providers.dart';
import 'package:provider/provider.dart';

class TelaFormCartas extends StatefulWidget {
  @override
  TelaFormCartasState createState() => TelaFormCartasState();
}

String dropdownValue = '0';

class TelaFormCartasState extends State<TelaFormCartas> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();
  File imagem = null;

  fotografar() async {
    final ImagePicker picker = ImagePicker();
    try {
      final arquivoImagem = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        preferredCameraDevice: CameraDevice.front,
      );
      if (arquivoImagem == null) return;

      setState(() {
        imagem = File(arquivoImagem.path);
        dadosForm['imagem'] = arquivoImagem.path;
        print('teste:');
        print(dadosForm['imagem']);
      });
    } catch (e) {
      print('Catch fotografar:\n$e');
    }
  }

  void saveForm(context, Carta carta) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoCarta = Carta(
        id: carta != null ? carta.id : carta,
        nome: dadosForm['nome'],
        cpf: dadosForm['cpf'],
        grauescolaridade: dadosForm['grauescolaridade'],
        imagem: dadosForm['imagem']);

    if (formValido) {
      if (carta != null) {
        Provider.of<CartaProvider>(context, listen: false)
            .patchCarta(novoCarta);
        dropdownValue = carta.cpf;
        Navigator.of(context).pop();
      } else {
        Provider.of<CartaProvider>(context, listen: false).postCarta(novoCarta);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final carta = ModalRoute.of(context).settings.arguments as Carta;
    print(carta);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Aluno"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, carta);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                initialValue: carta != null ? carta.nome : '',
                onSaved: (value) {
                  dadosForm['nome'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um nome válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CPF'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['cpf'] = value;
                },
                initialValue: carta != null ? carta.cpf : '',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Grau de Escolaridade',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward, color: Colors.blueGrey),
                iconSize: 24,
                elevation: 20,
                itemHeight: 60,
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    dadosForm['grauescolaridade'] = newValue;
                  });
                },
                items: <String>[
                  '0',
                  'Analfabeto',
                  'Até 5º Ano Incompleto',
                  '5º Ano Completo',
                  '6º ao 9º Ano do Fundamental	',
                  'Fundamental Completo',
                  'Médio Incompleto',
                  'Médio Completo',
                  'Superior Incompleto',
                  'Superior Completo',
                  'Mestrado',
                  'Doutorado'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Divider(),
              Container(
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.green,
                )),
                alignment: Alignment.center,
                child: carta != null
                    ? Image.file(
                        imagem != null ? imagem : File(carta.imagem),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Text("Nenhuma imagem!"),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: fotografar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
