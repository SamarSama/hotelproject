/// uid : "jjkdfjkv"
/// HotelId : "jjkdfjkv"
/// RoomId : "jjkdfjkv"
/// bookingdata : "jjkdfjkv"
/// no_of_days : 5
/// visano : "285"
/// dateofprocess : "kjnsk"

class Booking {
  Booking({
      String? uid, 
      String? hotelId, 
      String? roomId, 
      String? bookingdata, 
      dynamic? noOfDays,
      String? visano, 
      String? dateofprocess,}){
    _uid = uid;
    _hotelId = hotelId;
    _roomId = roomId;
    _bookingdata = bookingdata;
    _noOfDays = noOfDays;
    _visano = visano;
    _dateofprocess = dateofprocess;
}

  Booking.fromJson(dynamic json) {
    _uid = json['uid'];
    _hotelId = json['HotelId'];
    _roomId = json['RoomId'];
    _bookingdata = json['bookingdata'];
    _noOfDays = json['no_of_days'];
    _visano = json['visano'];
    _dateofprocess = json['dateofprocess'];
  }
  String? _uid;
  String? _hotelId;
  String? _roomId;
  String? _bookingdata;
  dynamic? _noOfDays;
  String? _visano;
  String? _dateofprocess;

  String? get uid => _uid;
  String? get hotelId => _hotelId;
  String? get roomId => _roomId;
  String? get bookingdata => _bookingdata;
  dynamic? get noOfDays => _noOfDays;
  String? get visano => _visano;
  String? get dateofprocess => _dateofprocess;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['HotelId'] = _hotelId;
    map['RoomId'] = _roomId;
    map['bookingdata'] = _bookingdata;
    map['no_of_days'] = _noOfDays;
    map['visano'] = _visano;
    map['dateofprocess'] = _dateofprocess;
    return map;
  }

}