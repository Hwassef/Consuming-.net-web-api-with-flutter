import 'dart:convert';

import 'package:consume_web_api/appValueNotifiier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album.dart';
import 'album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Livre>> fetchLivre() async {
    final response = await http.get(Uri.parse(
      'http://localhost:32350/test',
    ));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Livre>((json) => Livre.fromJson(json)).toList();
    } else {
      throw (response.statusCode);
    }
  }

  Future<Livre> deleteLivre(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://localhost:32350/test/$id'),
    );

    if (response.statusCode == 200) {
      return Livre.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to delete album.');
    }
  }

  Future<Livre> addLivre(int i, String t, String a, int n, int p) async {
    final response = await http.put(
      Uri.parse('http://localhost:32350/test'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': i,
        'titre': t,
        'auteur': a,
        'nbExemplaire': n,
        'prix': p,
      }),
    );

    if (response.statusCode == 200) {
      return Livre.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to update album.');
    }
  }

  Future<Livre> updateLivre(int id, String t, String a, int n, int p) async {
    final response = await http.put(
      Uri.parse('http://localhost:32350/test/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'titre': t,
        'auteur': a,
        'nbExemplaire': n,
        'prix': p,
      }),
    );

    if (response.statusCode == 200) {
      return Livre.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to update album.');
    }
  }

  late Future<List<Livre>> futureLivre;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _nbExemplaireController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureLivre = fetchLivre();
  }

  AppValueNotifier appValueNotifier = AppValueNotifier();
  String t = "delete";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (FutureBuilder<List<Livre>>(
          future: futureLivre,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DataTable(
                columns: [
                  DataColumn(label: Text('Id')),
                  DataColumn(label: Text('Titre')),
                  DataColumn(label: Text('Auteur')),
                  DataColumn(label: Text('Nombre Exemplaire')),
                  DataColumn(label: Text('Prix')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: List.generate(
                  snapshot.data!.length,
                  (index) => (DataRow(
                    cells: [
                      DataCell(Text(snapshot.data![index].id.toString())),
                      DataCell(Text(snapshot.data![index].titre)),
                      DataCell(Text(snapshot.data![index].auteur)),
                      DataCell(
                          Text(snapshot.data![index].nbExemplaire.toString())),
                      DataCell(Text(snapshot.data![index].prix.toString())),
                      DataCell(
                        ElevatedButton(
                          child: Text('$t'),
                          onPressed: () {
                            deleteLivre(snapshot.data![index].id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          },
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('AlertDialog Title'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _idController
                                          ..text = snapshot.data![index].id
                                              .toString(),
                                        decoration: const InputDecoration(),
                                      ),
                                      TextField(
                                        controller: _titreController
                                          ..text = snapshot.data![index].titre
                                              .toString(),
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Title',
                                        ),
                                      ),
                                      TextField(
                                        controller: _auteurController
                                          ..text = snapshot.data![index].auteur
                                              .toString(),
                                        decoration: const InputDecoration(
                                          hintText: 'Enter auteur',
                                        ),
                                      ),
                                      TextField(
                                        controller: _nbExemplaireController
                                          ..text = snapshot
                                              .data![index].nbExemplaire
                                              .toString(),
                                        decoration: const InputDecoration(
                                          hintText: 'Enter copies',
                                        ),
                                      ),
                                      TextField(
                                        controller: _prixController
                                          ..text = snapshot.data![index].prix
                                              .toString(),
                                        decoration: const InputDecoration(
                                          hintText: 'Enter prix',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //change this
                                      updateLivre(
                                        int.parse(_idController.text),
                                        _titreController.text,
                                        _auteurController.text,
                                        int.parse(_nbExemplaireController.text),
                                        int.parse(_prixController.text),
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  super.widget));
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
                ),
              );

              //return Text(snapshot.data!.titre);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          hintText: 'Enter id',
                        ),
                      ),
                      TextField(
                        controller: _titreController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Title',
                        ),
                      ),
                      TextField(
                        controller: _auteurController,
                        decoration: const InputDecoration(
                          hintText: 'Enter auteur',
                        ),
                      ),
                      TextField(
                        controller: _nbExemplaireController,
                        decoration: const InputDecoration(
                          hintText: 'Enter copies',
                        ),
                      ),
                      TextField(
                        controller: _prixController,
                        decoration: const InputDecoration(
                          hintText: 'Enter prix',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addLivre(
                        int.parse(_idController.text),
                        _titreController.text,
                        _auteurController.text,
                        int.parse(_nbExemplaireController.text),
                        int.parse(_prixController.text),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
