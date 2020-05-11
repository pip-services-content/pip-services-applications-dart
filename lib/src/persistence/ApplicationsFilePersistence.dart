import 'package:pip_services3_data/pip_services3_data.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/ApplicationV1.dart';
import './ApplicationsMemoryPersistence.dart';

class ApplicationsFilePersistence extends ApplicationsMemoryPersistence {
  JsonFilePersister<ApplicationV1> persister;

  ApplicationsFilePersistence([String path]) : super() {
    persister = JsonFilePersister<ApplicationV1>(path);
    loader = persister;
    saver = persister;
  }
  @override
  void configure(ConfigParams config) {
    super.configure(config);
    persister.configure(config);
  }
}
