class Either<T> {
  const Either._(this.data, this.error, this.success);

  const Either.success(T data) : this._(data, null, true);

  const Either.error(Exception error) : this._(null, error, false);

  final T? data;
  final Exception? error;
  final bool success;

  void when({
    required void Function(T? data) success,
    required void Function(Exception error) error,
  }) {
    return this.success ? success(data) : error(this.error!);
  }
}
