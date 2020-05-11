import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/ApplicationV1.dart';
import '../../src/persistence/IApplicationsPersistence.dart';
import './IApplicationsController.dart';
import './ApplicationsCommandSet.dart';

class ApplicationsController
    implements IApplicationsController, IConfigurable, IReferenceable, ICommandable {
  static final ConfigParams _defaultConfig = ConfigParams.fromTuples(
        ['dependencies.persistence', 'pip-services-applications:persistence:*:*:1.0']
    );
  IApplicationsPersistence persistence;
  ApplicationsCommandSet commandSet;
  DependencyResolver dependencyResolver = DependencyResolver(ApplicationsController._defaultConfig);

  @override
  void configure(ConfigParams config) {
    dependencyResolver.configure(config);
  }

  @override
  void setReferences(IReferences references) {
    dependencyResolver.setReferences(references);
    persistence = dependencyResolver.getOneRequired<IApplicationsPersistence>('persistence');
  }

  @override
  CommandSet getCommandSet() {
    commandSet ??= ApplicationsCommandSet(this);
    return commandSet;
  }

  @override
  Future<DataPage<ApplicationV1>> getApplications(
      String correlationId, FilterParams filter, PagingParams paging) {
    return persistence.getPageByFilter(correlationId, filter, paging);
  }

  @override
  Future<ApplicationV1> getApplicationById(String correlationId, String applicationId) {
    return persistence.getOneById(correlationId, applicationId);
  }

  @override
  Future<ApplicationV1> createApplication(String correlationId, ApplicationV1 application) {
    application.id = application.id ?? IdGenerator.nextLong();
    return persistence.create(correlationId, application);
  }

  @override
  Future<ApplicationV1> updateApplication(String correlationId, ApplicationV1 application) {
    return persistence.update(correlationId, application);
  }

  @override
  Future<ApplicationV1> deleteApplicationById(String correlationId, String applicationId) {
    return persistence.deleteById(correlationId, applicationId);
  }
}
