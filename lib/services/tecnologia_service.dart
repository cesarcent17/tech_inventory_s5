import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tecnologia.dart';

class TecnologiaService {
  final String baseUrl =
      "https://uisrael-ccenturion-default-rtdb.firebaseio.com/tecnologia";

  Future<void> create(Tecnologia item) async {
    final url = Uri.parse("$baseUrl.json");
    await http.post(url, body: jsonEncode(item.toMap()));
  }

  Future<List<Tecnologia>> getAll() async {
    final url = Uri.parse("$baseUrl.json");
    final response = await http.get(url);

    if (response.body == "null") return [];

    final Map<String, dynamic> data = jsonDecode(response.body);

    return data.entries.map((e) {
      final id = e.key;
      final map = Map<String, dynamic>.from(e.value);
      return Tecnologia.fromMap(id, map);
    }).toList();
  }

  Future<void> update(Tecnologia item) async {
    final url = Uri.parse("$baseUrl/${item.id}.json");
    await http.patch(url, body: jsonEncode(item.toMap()));
  }

  Future<void> delete(String id) async {
    final url = Uri.parse("$baseUrl/$id.json");
    await http.delete(url);
  }
}
