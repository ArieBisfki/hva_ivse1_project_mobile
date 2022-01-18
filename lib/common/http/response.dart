class DataResponse<T> {
  DataResponse.loading(this.message) : status = Status.Loading;

  DataResponse.success(this.data) : status = Status.Success;

  Status? status;
  T? data;
  String? message;
  Object? error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { Loading, Success, Error, ConnectivityError }
