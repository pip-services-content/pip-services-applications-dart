import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/ApplicationV1.dart';
import '../../src/persistence/IApplicationsPersistence.dart';
import './IApplicationsController.dart';
import './ApplicationsCommandSet.dart';

class ApplicationsController
    implements
        IApplicationsController,
        IConfigurable,
        IReferenceable,
        ICommandable {
  static final ConfigParams _defaultConfig = ConfigParams.fromTuples([
    'dependencies.persistence',
    'pip-services-applications:persistence:*:*:1.0'
  ]);
  IApplicationsPersistence persistence;
  ApplicationsCommandSet commandSet;
  DependencyResolver dependencyResolver =
      DependencyResolver(ApplicationsController._defaultConfig);

  /// Configures component by passing configuration parameters.
  ///
  /// - [config]    configuration parameters to be set.
  @override
  void configure(ConfigParams config) {
    dependencyResolver.configure(config);
  }

  /// Set references to component.
  ///
  /// - [references]    references parameters to be set.
  @override
  void setReferences(IReferences references) {
    dependencyResolver.setReferences(references);
    persistence = dependencyResolver
        .getOneRequired<IApplicationsPersistence>('persistence');
  }

  /// Gets a command set.
  ///
  /// Return Command set
  @override
  CommandSet getCommandSet() {
    commandSet ??= ApplicationsCommandSet(this);
    return commandSet;
  }

  /// Gets a page of applications retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<ApplicationV1>> getApplications(
      String correlationId, FilterParams filter, PagingParams paging) {
    return persistence.getPageByFilter(correlationId, filter, paging);
  }

  /// Gets an application by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of application to be retrieved.
  /// Return         Future that receives application or error.
  @override
  Future<ApplicationV1> getApplicationById(
      String correlationId, String applicationId) {
    return persistence.getOneById(correlationId, applicationId);
  }

  /// Creates an application.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [item]              an application to be created.
  /// Return         (optional) Future that receives created application or error.
  @override
  Future<ApplicationV1> createApplication(
      String correlationId, ApplicationV1 application) {
    application.id = application.id ?? IdGenerator.nextLong();
    return persistence.create(correlationId, application);
  }

  /// Updates an application.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [item]              an application to be updated.
  /// Return         (optional) Future that receives updated application
  /// Throws error.
  @override
  Future<ApplicationV1> updateApplication(
      String correlationId, ApplicationV1 application) {
    return persistence.update(correlationId, application);
  }

  /// Deleted an application by it's unique id.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of the application to be deleted
  /// Return                Future that receives deleted application
  /// Throws error.
  @override
  Future<ApplicationV1> deleteApplicationById(
      String correlationId, String applicationId) {
    return persistence.deleteById(correlationId, applicationId);
  }
}
