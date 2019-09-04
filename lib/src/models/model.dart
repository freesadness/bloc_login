import 'dart:convert';

abstract class IModel{
  Map<String, dynamic> toJson();
}

abstract class Model implements IModel{
  String toJsonString(){
    return json.encode(this.toJson());
  }
}