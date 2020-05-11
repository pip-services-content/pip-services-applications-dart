import 'dart:async';
import 'package:mongo_dart_query/mongo_dart_query.dart' as mngquery;
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_mongodb/pip_services3_mongodb.dart';

import '../data/version1/ApplicationV1.dart';
import './IApplicationsPersistence.dart';

class ApplicationsMongoDbPersistence
    extends IdentifiableMongoDbPersistence<ApplicationV1, String>
    implements IApplicationsPersistence {
  ApplicationsMongoDbPersistence() : super('applications') {
    maxPageSize = 1000;
  }

  dynamic composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var criteria = [];

    var search = filter.getAsNullableString('search');
    if (search != null) {
      var searchRegex = RegExp(search, caseSensitive: false);
      var searchCriteria = [];
      searchCriteria.add({ 'id': { r'$regex': searchRegex } });
      searchCriteria.add({ 'product': { r'$regex': searchRegex } });
      searchCriteria.add({ 'copyrights': { r'$regex': searchRegex } });
      criteria.add({ r'$or': searchCriteria });
    }    

    var id = filter.getAsNullableString('id');
    if (id != null) {
      criteria.add({'_id': id});
    }

    var product = filter.getAsNullableString('product');
    if (product != null) {
      criteria.add({'product': product});
    }

    var group = filter.getAsNullableString('group');
    if (group != null) {
      criteria.add({'group': group});
    }

    return criteria.isNotEmpty ? {r'$and': criteria} : null;
  }

  @override
  Future<DataPage<ApplicationV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging) async {
    return super
        .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);
  }
}
