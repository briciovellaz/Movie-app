abstract class IRepository<T> {
  Future<void> fetchData();
  Future<T> getAll();
}
