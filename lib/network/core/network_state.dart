sealed class NetworkState<T> {
}
class Initial extends NetworkState {
  final bool value;
  Initial(this.value);
}
class Loading extends NetworkState {
  final bool value;
  Loading(this.value);
}
class Loaded extends NetworkState {
  final bool value;
  Loaded(this.value);
}
class Success<T> extends NetworkState<T> {
  T data;
  Success(this.data);
}
class Error extends NetworkState {
  final String message;
  Error(this.message);
}
