import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_data/pip_services3_data.dart';
import '../data/version1/ApplicationV1.dart';
import './IApplicationsPersistence.dart';

class ApplicationsMemoryPersistence
    extends IdentifiableMemoryPersistence<ApplicationV1, String>
    implements IApplicationsPersistence {
  ApplicationsMemoryPersistence() : super() {
    maxPageSize = 1000;
  }

  bool matchString(String value, String search) {
    if (value == null && search == null) {
      return true;
    }
    if (value == null || search == null) {
      return false;
    }
    return value.toLowerCase().contains(search);    
  }

  bool matchSearch(ApplicationV1 item, String search) {
    search = search.toLowerCase();
    if (matchString(item.id, search)) {
      return true;
    }
    if (matchString(item.product, search)) {
      return true;
    }
    if (matchString(item.copyrights, search)) {
      return true;
    }
    return false;    
  }

  Function composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var search = filter.getAsNullableString('search');
    var id = filter.getAsNullableString('id');
    var product = filter.getAsNullableString('product');
    var group = filter.getAsNullableString('group');

    return (item) {
      if (search != null && !matchSearch(item, search)) {
        return false;
      }
      if (id != null && item.id != id) {
        return false;
      }
      if (product != null && item.product != product) {
        return false;
      }
      if (group != null && item.group != group) {
        return false;
      }
      return true; 
    };
  }

  @override
  Future<DataPage<ApplicationV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging) {
    return super
        .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);
  }
}
