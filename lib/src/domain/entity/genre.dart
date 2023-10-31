import 'package:floor/floor.dart';

@Entity(tableName: 'genres')
class Genre {

  @primaryKey
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}
