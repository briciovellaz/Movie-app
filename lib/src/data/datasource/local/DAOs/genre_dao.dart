import 'package:floor/floor.dart';

import '../../../../domain/entity/genre.dart';

@dao
abstract class GenreDAO {

  @insert
  Future<void> insertGenre(Genre genre);

  @Query('SELECT * FROM genres WHERE id = :id')
  Future<Genre?> getGenreById(int id);

  @delete
  Future<void> deleteGenre(Genre genre);

}
