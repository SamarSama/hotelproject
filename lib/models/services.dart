/// service : "kjhkhikhi"
/// servicetype : "kjhkhikhi"
/// HotelIs : "kjhkhikhi"

class Services {
  Services({
      String? service, 
      String? servicetype, 
      String? hotelIs,}){
    _service = service;
    _servicetype = servicetype;
    _hotelIs = hotelIs;
}

  Services.fromJson(dynamic json) {
    _service = json['service'];
    _servicetype = json['servicetype'];
    _hotelIs = json['HotelIs'];
  }
  String? _service;
  String? _servicetype;
  String? _hotelIs;

  String? get service => _service;
  String? get servicetype => _servicetype;
  String? get hotelIs => _hotelIs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service'] = _service;
    map['servicetype'] = _servicetype;
    map['HotelIs'] = _hotelIs;
    return map;
  }

}