import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/ApplicationV1.dart';

abstract class IApplicationsPersistence {
  Future<DataPage<ApplicationV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<ApplicationV1> getOneById(String correlationId, String id);

  Future<ApplicationV1> create(String correlationId, ApplicationV1 item);

  Future<ApplicationV1> update(String correlationId, ApplicationV1 item);

  Future<ApplicationV1> deleteById(String correlationId, String id);
}
