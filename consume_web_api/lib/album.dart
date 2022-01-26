import 'dart:convert';

class Livre {
  final int id;
  final String titre;
  final String auteur;
  final int nbExemplaire;
  final int prix;
  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.nbExemplaire,
    required this.prix,
  });
  List<Livre> postFromJson(String str) =>
      List<Livre>.from(json.decode(str).map((x) => Livre.fromJson(x)));

  factory Livre.fromJson(Map<String, dynamic> json) {
    return Livre(
      id: json['id'],
      titre: json['titre'],
      auteur: json['auteur'],
      nbExemplaire: json['nbExemplaire'],
      prix: json['prix'],
    );
  }
}
