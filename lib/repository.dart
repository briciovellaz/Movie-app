abstract class IRepository<T> {
  Future<void> fetchData();
  Future<List<T>> getAll();
}
