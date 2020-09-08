class ShippingDetailsModel{
  String name;
  String email;
  String phoneNumber;
  String country;
  String state;
  String city;
  String address;
  String houseNumber;
  String quantity;
  String sideNotes;

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map["name"]=name??"NA";
    map["email"]=email??"NA";
    map["phoneNumber"]=phoneNumber;
    map["country"]=country??"NA";
    map["state"]=state??"NA";
    map["city"]=city??"NA";
    map["address"]=address??"NA";
    map["houseNumber"]=houseNumber??"NA";
    map["quantity"]=quantity??"NA";
    map["sideNotes"]=sideNotes??"NA";
    return map;
  }
}