/// RoomId : "hkhkjihhhhh"
/// RoomImage : "hujlijkjl"
/// bedNo : "5"
/// NightPrice : "600"
/// HotelId : "hkhjjlklk"
/// RoomType : "hkhjjlklk"
/// content : "hkhjjlklk"
/// Roomnumber : "156"

class Room {
  Room({
      String? roomId, 
      String? roomImage, 
      String? bedNo, 
      String? nightPrice, 
      String? hotelId, 
      String? roomType, 
      String? content, 
      String? roomnumber,}){
    _roomId = roomId;
    _roomImage = roomImage;
    _bedNo = bedNo;
    _nightPrice = nightPrice;
    _hotelId = hotelId;
    _roomType = roomType;
    _content = content;
    _roomnumber = roomnumber;
}

  Room.fromJson(dynamic json) {
    _roomId = json['RoomId'];
    _roomImage = json['RoomImage'];
    _bedNo = json['bedNo'];
    _nightPrice = json['NightPrice'];
    _hotelId = json['HotelId'];
    _roomType = json['RoomType'];
    _content = json['content'];
    _roomnumber = json['Roomnumber'];
  }
  String? _roomId;
  String? _roomImage;
  String? _bedNo;
  String? _nightPrice;
  String? _hotelId;
  String? _roomType;
  String? _content;
  String? _roomnumber;

  String? get roomId => _roomId;
  String? get roomImage => _roomImage;
  String? get bedNo => _bedNo;
  String? get nightPrice => _nightPrice;
  String? get hotelId => _hotelId;
  String? get roomType => _roomType;
  String? get content => _content;
  String? get roomnumber => _roomnumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RoomId'] = _roomId;
    map['RoomImage'] = _roomImage;
    map['bedNo'] = _bedNo;
    map['NightPrice'] = _nightPrice;
    map['HotelId'] = _hotelId;
    map['RoomType'] = _roomType;
    map['content'] = _content;
    map['Roomnumber'] = _roomnumber;
    return map;
  }

}