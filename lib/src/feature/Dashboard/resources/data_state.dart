abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState(this.data, this.error);
}

class DataSuccess extends DataState<Map<String, dynamic>> {
  const DataSuccess(Map<String, dynamic>? data) : super(data, null);
}

class DataFailed extends DataState<Map<String, dynamic>> {
  const DataFailed(String error) : super(null, error);
}
