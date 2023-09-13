class ServerResponse<T> {
  Status? status;
  T? responseData;
  String? message;

  ServerResponse.loading(this.message) : status = Status.LOADING;

  ServerResponse.completed(this.responseData) : status = Status.COMPLETED;

  ServerResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $responseData";
  }
}

enum Status {LOADING, COMPLETED, ERROR }
