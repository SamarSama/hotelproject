
import 'package:flutter/cupertino.dart';
import 'package:hotelproject/models/hotel1.dart';

class CustomerDataProvider extends ChangeNotifier{
  List<Hotel1> allHotels = [];

  void setAllHotels( List<Hotel1> allHotels)
  {
    this.allHotels=allHotels;
    notifyListeners();
  }

  void addNewHotel(Hotel1 hotel1)
  {
    allHotels=[...allHotels,hotel1];
    notifyListeners();
  }

}