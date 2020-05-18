import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../src/data/version1/ApplicationV1.dart';

abstract class IApplicationsController {
  /// Gets a page of applications retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  Future<DataPage<ApplicationV1>> getApplications(
      String correlationId, FilterParams filter, PagingParams paging);

  /// Gets an application by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of application to be retrieved.
  /// Return         Future that receives application or error.
  Future<ApplicationV1> getApplicationById(
      String correlationId, String applicationId);

  /// Creates an application.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [item]              an application to be created.
  /// Return         (optional) Future that receives created application or error.
  Future<ApplicationV1> createApplication(
      String correlationId, ApplicationV1 application);

  /// Updates an application.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [item]              an application to be updated.
  /// Return         (optional) Future that receives updated application
  /// Throws error.
  Future<ApplicationV1> updateApplication(
      String correlationId, ApplicationV1 application);

  /// Deleted an application by it's unique id.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of the application to be deleted
  /// Return                Future that receives deleted application
  /// Throws error.
  Future<ApplicationV1> deleteApplicationById(
      String correlationId, String applicationId);
}
