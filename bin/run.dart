import 'package:pip_services_applications_dart/pip_services_applications_dart.dart';

void main(List<String> argument) {
  try {
    var proc = ApplicationsProcess();
    proc.configPath = './config/config.yml';
    proc.run(argument);
  } catch (ex) {
    print(ex);
  }
}
