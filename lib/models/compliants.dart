/// uid : "jygkhkihihlo"
/// date_of_compliant : "jygkhkihihlo"
/// compliant : "jygkhkihihlo"
/// compliant_respond : "jygkhkihihlo"

class Compliants {
  Compliants({
      String? uid, 
      String? dateOfCompliant, 
      String? compliant, 
      String? compliantRespond,}){
    _uid = uid;
    _dateOfCompliant = dateOfCompliant;
    _compliant = compliant;
    _compliantRespond = compliantRespond;
}

  Compliants.fromJson(dynamic json) {
    _uid = json['uid'];
    _dateOfCompliant = json['date_of_compliant'];
    _compliant = json['compliant'];
    _compliantRespond = json['compliant_respond'];
  }
  String? _uid;
  String? _dateOfCompliant;
  String? _compliant;
  String? _compliantRespond;

  String? get uid => _uid;
  String? get dateOfCompliant => _dateOfCompliant;
  String? get compliant => _compliant;
  String? get compliantRespond => _compliantRespond;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['date_of_compliant'] = _dateOfCompliant;
    map['compliant'] = _compliant;
    map['compliant_respond'] = _compliantRespond;
    return map;
  }

}