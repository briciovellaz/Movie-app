import 'dart:convert';

import 'package:floor/floor.dart';

class GenreConverter extends TypeConverter<List<int>, String>{

  @override
  List<int> decode(String databaseValue) {
    final data = jsonDecode(databaseValue);
    return List<int>.from(data['genres_id']);
  }

  @override
  encode(List<int> value) {
    final data = <String, dynamic>{};
    data.addAll({'genres_id': value});
    return jsonEncode(data);
  }
  
}
