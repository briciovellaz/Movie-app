import '../../domain/entity/genre.dart';

class GenreDataHandler {
  final int id;
  final String name;

  GenreDataHandler({
    required this.id,
    required this.name,
  });

  factory GenreDataHandler.fromJson(Map<String, dynamic> json) {
    return GenreDataHandler(
      id: json['id'],
      name: json['name'],
    );
  }

  Genre toModel() {
    return Genre(
      id: id,
      name: name,
    );
  }
}
