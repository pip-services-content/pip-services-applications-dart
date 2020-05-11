import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../persistence/ApplicationsMemoryPersistence.dart';
import '../persistence/ApplicationsFilePersistence.dart';
import '../persistence/ApplicationsMongoDbPersistence.dart';
import '../logic/ApplicationsController.dart';
import '../services/version1/ApplicationsHttpServiceV1.dart';

class ApplicationsServiceFactory extends Factory {
  static final MemoryPersistenceDescriptor =
      Descriptor('pip-services-applications', 'persistence', 'memory', '*', '1.0');
  static final FilePersistenceDescriptor =
      Descriptor('pip-services-applications', 'persistence', 'file', '*', '1.0');
  static final MongoDbPersistenceDescriptor =
      Descriptor('pip-services-applications', 'persistence', 'mongodb', '*', '1.0');
  static final ControllerDescriptor =
      Descriptor('pip-services-applications', 'controller', 'default', '*', '1.0');
  static final HttpServiceDescriptor =
      Descriptor('pip-services-applications', 'service', 'http', '*', '1.0');

  ApplicationsServiceFactory() : super() {
    registerAsType(ApplicationsServiceFactory.MemoryPersistenceDescriptor,
        ApplicationsMemoryPersistence);
    registerAsType(ApplicationsServiceFactory.FilePersistenceDescriptor,
        ApplicationsFilePersistence);
    registerAsType(ApplicationsServiceFactory.MongoDbPersistenceDescriptor,
        ApplicationsMongoDbPersistence);
    registerAsType(
        ApplicationsServiceFactory.ControllerDescriptor, ApplicationsController);
    registerAsType(ApplicationsServiceFactory.HttpServiceDescriptor,
        ApplicationsHttpServiceV1);
  }
}
