abstract class NetworkState<T> {
  final T? data;
  final String? error;

  const NetworkState({this.data, this.error});
}

class NetworkStateSuccess<T> extends NetworkState<T> {
  const NetworkStateSuccess(T data) : super(data: data);
}

class NetworkStateFailed<T> extends NetworkState<T> {
  const NetworkStateFailed(String error) : super(error: error);
}