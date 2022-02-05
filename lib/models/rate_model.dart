/// userId : "John Smith"
/// rate : 2.6

class RateModel {
  RateModel({
      String? userId, 
      double? rate,}){
    _userId = userId;
    _rate = rate;
}
  RateModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _rate = json['rate'];
  }
  String? _userId;
  double? _rate;
  String? get userId => _userId;
  double? get rate => _rate;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['rate'] = _rate;
    return map;
  }

}