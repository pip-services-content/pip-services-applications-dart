import 'package:pip_services3_container/pip_services3_container.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import '../build/ApplicationsServiceFactory.dart';

class ApplicationsProcess extends ProcessContainer {
  ApplicationsProcess() : super('applications', 'Applications microservice') {
    factories.add(ApplicationsServiceFactory());
    factories.add(DefaultRpcFactory());
  }
}
