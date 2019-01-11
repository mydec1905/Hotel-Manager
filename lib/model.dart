class Customer {
  String name;
  String phone;
  String paid;
  String datestart;
  String dateend;

  Customer(this.name, this.phone, this.paid,this.datestart,this.dateend);
  Customer.fromMap(Map map){
    name = map[name];
    phone = map[phone];
    paid = map[paid];
    datestart = map[datestart];
    dateend = map[dateend];
  }
}
