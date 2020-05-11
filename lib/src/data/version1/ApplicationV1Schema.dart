import 'package:pip_services3_commons/pip_services3_commons.dart';

class ApplicationV1Schema extends ObjectSchema {
  ApplicationV1Schema() : super() {
    withOptionalProperty('id', TypeCode.String);
    withRequiredProperty('name', TypeCode.Map);
    withOptionalProperty('description', TypeCode.Map);
    withRequiredProperty('product', TypeCode.String);
    withOptionalProperty('group', TypeCode.String);
    withOptionalProperty('copyrights', TypeCode.String);
    withOptionalProperty('url', TypeCode.String);
    withOptionalProperty('icon', TypeCode.String);
    withOptionalProperty('min_ver', TypeCode.Integer);
    withOptionalProperty('max_ver', TypeCode.Integer);
    withOptionalProperty('access_rights', ArraySchema(TypeCode.String));
  }
}