class RequestBookingModel {
  final int id;
  RequestBookingModel(this.id);
  factory RequestBookingModel.fromJson(Map<String, dynamic> json) {
    return RequestBookingModel(1);
  }
}
