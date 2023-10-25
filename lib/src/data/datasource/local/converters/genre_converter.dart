import 'dart:convert';

import 'package:floor/floor.dart';

class GenreConverter extends TypeConverter<List<int>, String>{

  @override
  List<int> decode(String databaseValue) {
    List<int> result=[];
    final data = jsonDecode(databaseValue);
    result = List<int>.from(data['genres_id']);
    return result;
  }

  @override
  encode(List<int> value) {
    final data = <String, dynamic>{};
    data.addAll({'genres_id': value.join(',')});
    return jsonEncode(data);
  }
  
}
