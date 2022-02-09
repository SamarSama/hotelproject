/// userId : "John Smith"
/// rate : 2.6
/// HotelId : "Ljldfjdj"

class RateModel {
  RateModel({
      String? userId, 
      double? rate, 
      String? hotelId,}){
    _userId = userId;
    _rate = rate;
    _hotelId = hotelId;
}

  RateModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _rate = json['rate'];
    _hotelId = json['HotelId'];
  }
  String? _userId;
  double? _rate;
  String? _hotelId;

  String? get userId => _userId;
  double? get rate => _rate;
  String? get hotelId => _hotelId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['rate'] = _rate;
    map['HotelId'] = _hotelId;
    return map;
  }

}