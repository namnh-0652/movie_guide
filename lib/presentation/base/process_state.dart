class ProcessState<T> {
  final Status status;
  final T? data;
  final String? errorMessage;
  ProcessState(this.status, {this.data, this.errorMessage});

  factory ProcessState.loading() => ProcessState(Status.loading);

  factory ProcessState.error(String? errorMessage) =>
      ProcessState(Status.error, errorMessage: errorMessage);

  factory ProcessState.success(T? data) =>
      ProcessState(Status.success, data: data);

  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
}

enum Status { loading, success, error }
