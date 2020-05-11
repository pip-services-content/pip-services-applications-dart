import 'package:pip_services3_commons/pip_services3_commons.dart';

class ApplicationV1 implements IStringIdentifiable {
  @override
  String id;
  MultiString name;
  MultiString description;
  String product;
  String group;
  String copyrights;
  String url;
  String icon;
  int min_ver;
  int max_ver;
  var access_rights; // String[]


  ApplicationV1(
      {String id,
      MultiString name,
      MultiString description,
      String product,
      String group,
      String copyrights,
      String url,
      String icon,
      int min_ver,
      int max_ver,
      var access_rights})
      : id = id,
        name = name,
        description = description,
        product = product,
        group = group,
        copyrights = copyrights,
        url = url,
        icon = icon,
        min_ver = min_ver,
        max_ver = max_ver,
        access_rights = access_rights;

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = MultiString.fromJson(json['name']);
    description = MultiString.fromJson(json['description']);
    product = json['product'];
    group = json['group'];
    copyrights = json['copyrights'];
    url = json['url'];
    icon = json['icon'];
    min_ver = json['min_ver'];
    max_ver = json['max_ver'];
    access_rights = json['access_rights'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'product': product,
      'group': group,
      'copyrights': copyrights,
      'url': url,
      'icon': icon,
      'min_ver': min_ver,
      'max_ver': max_ver,
      'access_rights': access_rights
    };
  }    
}