import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../data/model/giocatore.dart';

class GiocatoriRepository {

  Future<List<Giocatore>> getGiocatori() async {
    final String response = await rootBundle.loadString('lib/data/listone.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Giocatore.fromJson(json)).toList();
  }

}