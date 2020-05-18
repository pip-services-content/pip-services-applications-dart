import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class ApplicationsHttpServiceV1 extends CommandableHttpService {
  ApplicationsHttpServiceV1() : super('v1/applications') {
    dependencyResolver.put('controller',
        Descriptor('pip-services-applications', 'controller', '*', '*', '1.0'));
  }
}
